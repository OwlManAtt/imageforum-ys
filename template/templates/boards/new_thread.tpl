<div id='breadcrumb-trail'>{$board.category} &raquo; {kkkurl link_text="/`$board.short_name`/ &mdash; `$board.name`" slug='board' args=$board.short_name} &raquo; Create Thread</div> 

<div align='center'>
    <div class='quick-reply'>
        <form action='{$display_settings.public_dir}/new-thread/' method='post' enctype='multipart/form-data'>
            <input type='hidden' name='MAX_FILE_SIZE' value='{$max_file_size_bytes}' /> 
            <input type='hidden' name='state' value='post' /> 
            <input type='hidden' name='board_id' value='{$board.id}' />
            
            <table class='inputTable'>
                <tr>
                    <td style='font-weight: bold; font-size: large;'>
                        <label for='identity'>Post Anonymously?</label>
                    </td>
                    <td colspan='2' id='identity_td'>
                        {html_options name='post[identity]' id='identity' selected=$identity_preference options=$post_as_options}
                    </td>
                </tr>
                <tr>
                    <td style='font-weight: bold; font-size: large;'>
                        <label for='image'>Image</label>
                    </td>
                    <td colspan='2' id='image_td'>
                         <input type='file' name='image' id='image' size='35' />
                    </td>
                </tr>
                <tr>
                    <td style='font-weight: bold; font-size: large;'>
                        <label for='title'>Title</label>
                    </td>
                    <td colspan='2' id='title_td'>
                        <input type='text' name='post[title]' id='title' maxlength='80' size='61' value='{$post.title}' />
                    </td>
                </tr>
                <tr>
                    <td style='vertical-align: top; font-weight: bold; font-size: large;'>
                        <label for='text'>Message</label>
                    </td>
                    <td colspan='2' id='text_td'>
                        <textarea name='post[text]' id='text' cols='60' rows='15'>{$post.body}</textarea>
                    </td>
                </tr>
                <tr>
                    <td align='right' colspan='3'>
                        <input type='submit' value='Post Thread' />
                    </td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td colspan='2' id='post-rules'>
                        <ul class='post-rules'>
                            <li>Image uploading is always optional.</li>
                            <li>Maximum file size allowed is {$max_file_size_human}MB.</li>
                            <li>Supported file types are GIF, JPG, and PNG.</li>
                            <li>Images greater than {$max_dimension}x{$max_dimension} pixels will be thumbnailed.</li>
                        </ul>
                    </td>
                </tr>
            </table>
        </form>
    </div>
</div>
