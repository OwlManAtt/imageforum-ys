<?php
/**
 *
 * @author     OwlManAtt <owlmanatt@gmail.com> 
 * @copyright  2007-2008, Yasashii Syndicate 
 * @version    2.4.0
 **/

/**
 * Exception for wrapping PHP upload errors.
 *
 * @version    Release: @package_version@
*/
class UploadError extends Exception
{
    /**
     * Sets up the exception. 
     * 
     * @param   string    $message    The error text.
     * @param   int       $code       An error code.
     * @access private
     * @return void
    */
    public function __construct($message, $code = 0) 
    {
        parent::__construct($message,$code);
    }

    /**
     * Convert the exception into a string. 
     * 
     * @access private
     * @return string
    */
    public function __toString() 
    {
        return __CLASS__ . ": [{$this->code}]: {$this->message} in '{$this->file}' on line {$this->line}.\n";
    }
} // end UploadError 

?>
