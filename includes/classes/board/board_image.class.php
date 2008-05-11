<?php

class BoardImage extends ActiveTable
{
    protected $table_name = 'board_thread_post_image';
    protected $primary_key = 'board_thread_post_image_id'; 
    protected $MIMETYPES = array(
        'jpeg' => 'jpg',
        'gif' => 'gif',
        'png' => 'png',
    );

    /**
     * Return an image's mimetype. False if not an image/supported MIME. 
     * 
     * @param mixed $file_path FullpPath to file. 
     * @return bool|string 
     **/
    private function sys_get_mime_type($file_path)
    {
        $file_path_encoded = escapeshellarg($file_path);
        $mime = trim(`file -bi $file_path_encoded`);
        $mime = explode('/',$mime);

        if($mime[0] != 'image')
        {
            return false;
        }

        if(array_key_exists($mime[1],$this->MIMETYPES) == false)
        {
            return false;
        }

        return $mime[1];
    } // end sys_get_mime_type

    public function setImageOriginalName($filename)
    {
        $filename = str_replace(' ','_',$filename);
        $filename = str_replace('#','',$filename);
        $filename = str_replace('@','',$filename);
        $filename = str_replace('/','',$filename);
        $filename = str_replace('\\','',$filename);
        
        return $this->set($filename,'image_original_name');
    } // end setImageOriginalName

    public function create($FILE)
    {
        global $APP_CONFIG;

        $imagefile_name = $FILE['name'];

        if($FILE['name'] == '')
        {
            throw new ArgumentError('Filename was blank.');
        }

        switch ($FILE['error']) 
        {
            case UPLOAD_ERR_OK:
            {
                break;
            } // end OK

            case UPLOAD_ERR_INI_SIZE:
            {
                throw new UploadError('The uploaded file exceeds the '.ini_get('upload_max_file_size').' limit.',UPLOAD_ERR_INI_SIZE);

                break;
            } // end ini_size

            case UPLOAD_ERR_FORM_SIZE:
            {
                throw new UploadError("The uploaded file exceeds {$APP_CONFIG['max_upload_filesize']} bytes.",UPLOAD_ERR_FORM_SIZE);

                break;
            } // end form size

            case UPLOAD_ERR_PARTIAL:
            {
                throw new UploadError('The file was only partially uploaded.',UPLOAD_ERR_PARTIAL);

                break;
            } // end err partial

            case UPLOAD_ERR_NO_FILE:
            {
                throw new UploadError('No file was uploaded.',UPLOAD_ERR_NO_FILE); 

                break;
            } // end no file

            case UPLOAD_ERR_NO_TMP_DIR:
            {
                throw new UploadError('Temporary folder does not exist.',UPLOAD_ERR_NO_TMP_DIR);

                break;
            } // end no tmp dir

            case UPLOAD_ERR_CANT_WRITE:
            {
                throw new UploadError('Cannot write file.', UPLOAD_ERR_CANT_WRITE);
                
                break;
            } // end cant write

            default:
            {
                throw new UploadError('Unknown upload error.',500);

                break;
            } // end unknown error
        } // end handle error switch
       
        if(is_file($FILE['tmp_name']) == false)
        {
            throw new UploadError('Temporary file does not exist.',501); 
        }

        if(is_readable($FILE['tmp_name']) == false) 
        {
            throw new UploadError('Temporary file could not be read in security context.',502);
        }
       
        $mimetype = $this->sys_get_mime_type($FILE['tmp_name']); 
        if($mimetype == false)
        {
            throw new UploadError('Invalid MIME type.',503);
        }

        preg_match('/\.([a-z0-9]{1,4})$/i',$imagefile_name,$MATCH);
        $extension = $MATCH[1];
        if($extension == 'jpeg')
        {
            $extension = 'jpg';
        }

        if($this->MIMETYPES[$mimetype] != $extension)
        {
            throw new UploadError('File extension was inappropriate for MIME type.',505);
        }
        
        if(@getimagesize($FILE['tmp_name']) == false) 
        {
            throw new UploadError('Image malformed.',504);
        }

        $file_md5 = md5_file($FILE['tmp_name']);
       
        $existing_upload = new BoardImage($this->db);
        $existing_upload = $existing_upload->findOneByImageHash($file_md5);
        
        // Somebody has already posted this. Use the old upload/ID.
        if($existing_upload != null)
        {
            return $this->load($existing_upload->getBoardThreadPostImageId());
        }

        $DIMENSIONS = getimagesize($FILE['tmp_name']);
        
        $this->setImageExtension($extension);
        $this->setImageWidth($DIMENSIONS[0]);
        $this->setImageHeight($DIMENSIONS[1]);
        $this->setImageSizeBytes($FILE['size']);
        $this->setImageHash($file_md5);
        $this->setImageOriginalName($imagefile_name);

        // Store the files in dir/xy/xyaaaaaaaaaaaaaaaaaaaaaaaaaa.jpg 
        $subdir = $APP_CONFIG['upload_directory'].'/'.substr($this->getImageHash(),0,2);
        $location = $subdir."/{$this->getImageHash()}.{$extension}"; 
        
        $thumb_subdir = $APP_CONFIG['upload_directory'].'/'.substr($this->getImageHash(),0,2).'/thumb';
        $thumb_location = $thumb_subdir."/{$this->getImageHash()}.{$extension}"; 
        
        try
        {
            $this->store_image($subdir,$location,$FILE);
            $this->make_thumb($this->getImageHeight(),$this->getImageWidth(),$extension,$location,$thumb_subdir,$thumb_location);
        }
        catch(UploadError $e)
        {
            // Upload failed. (Try to) purge the files (they may not exist) and hand the exception up.
            @unlink($location);
            @unlink($thumb_location);

            throw $e;
        }

        return $this->save();
    } // end create
   
    private function make_thumb($height,$width,$file_type,$fullsize_location,$thumb_subdir,$thumb_destination)
    {
        global $APP_CONFIG;

        $this->mkhashdir($thumb_subdir);

        if($height > $APP_CONFIG['image_max_dimension'] || $width > $APP_CONFIG['image_max_dimension'])
        {
            if($height > $width)
            {
                $new_h = $APP_CONFIG['image_max_dimension'];
                $new_w = (($new_h / $width) * $width); 
            }
            else
            {
                $new_w = $APP_CONFIG['image_max_dimension'];
                $new_h = (($new_w / $height) * $height); 
            }

            $new_h = ceil($new_h);
            $new_w = ceil($new_w);

            $quality = 70;
            if($file_type == 'gif')
            {
                $quality = 90;
            }

            $convert = '/usr/bin/convert '.escapeshellarg($fullsize_location);
            $convert .= " -resize {$new_w}x{$new_h} -quality {$quality} ";
            $convert .= escapeshellarg($thumb_destination);
            $convert_output = exec($convert);

            if(file_exists($thumb_destination) == false)
            {
                throw new UploadError('Thumbnailing failed.',509);
            }
        } // end image needs thumbnailing
        else
        {
            // Link image as-is to thumb directory.
            if(symlink($fullsize_location,$thumb_destination) == false)
            {
                throw new UploadError('Symlink thumbnailing failed',510);
            }
        } // end no thumbnail operation needed
        
        return true;
    } // end make_thumb
    
    private function store_image($subdir,$location,$FILE)
    {    
        $this->mkhashdir($subdir);

        if(move_uploaded_file($FILE['tmp_name'],$location) == false) 
        {
            throw new UploadError('Could not move image from temporary to permanent storage.',507); 
        }

        if($FILE['size'] != filesize($location)) 
        {
            throw new UploadError('Permanently-stored file did not match size of temporary file.',508);
        } 
    } // end store_image

    private function mkhashdir($subdir)
    {
        if(file_exists($subdir) == false)
        {
            $mkresult = @mkdir($subdir); 

            if($mkresult == false)
            {
                throw new UploadError('Could not create hash directory.',506);
            }
        } // end create dir

        return true;
    } // end mkhashdir
} // end BoardImage

?>
