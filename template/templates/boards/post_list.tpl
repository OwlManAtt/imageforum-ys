<div id='breadcrumb-trail'>{$board.category} &raquo; {kkkurl link_text="/`$board.short_name`/ &mdash; `$board.name`" slug='board' args=$board.short_name} &raquo; {if $thread.sticky == 1}Sticky: {/if}{$thread.name}{if $thread.can_edit == 1} <span style='color: gray;'>({kkkurl link_text='Change Topic' slug='edit-thread' args=`$thread.id`/`$page`})</span>{/if}</div>

{if $board_notice != ''}<p id='forum_notice' class='{$fat} notice-box'>{$board_notice}</p>{/if}
{section name=index loop=$posts}
{include file='boards/_post.tpl' post=$posts[index] locked=$thread.locked}
{sectionelse}
<p>There are no posts on this page!</p> 
{/section}

<br clear='all' />
<div class='pages'>{$pagination}</div>

{if $thread.locked == 'N'}<div align='center'>
    <a name='post'>&nbsp;</a>
    <div class='quick-reply'>
        <form action='{$display_settings.public_dir}/thread-reply/' method='post' enctype='multipart/form-data'>
            <input type='hidden' name='thread_id' value='{$thread.id}' />
            <input type='hidden' name='MAX_FILE_SIZE' value='{$max_file_size_bytes}' />

            <table border='0'>
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
                    <td style='vertical-align: top; font-weight: bold; font-size: large;'>
                        <label for='post_text'>Message</label>
                    </td>
                    <td colspan='2' id='post_text_td'>
                        <textarea name='post[text]' id='post_text' cols='60' rows='15'></textarea>
                    </td>
                </tr>
                <tr>
                    <td align='right' colspan='3'>
                        <input type='submit' value='Reply' />
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
{/if}
