<div id='breadcrumb-trail'>{$board.category} &raquo; {kkkurl link_text=$board.name slug='board' args=$board.short_name} &raquo; Create Thread</div> 

<div align='center'>
    <div class='quick-reply'>
        <form action='{$display_settings.public_dir}/new-thread/' method='post'>
            <input type='hidden' name='state' value='post' /> 
            <input type='hidden' name='board_id' value='{$board.id}' />
            
            <table class='inputTable'>
                <tr>
                    <td style='font-weight: bold; font-size: large;'>
                        <label for='title'>Title</title>
                    </td>
                    <td colspan='2' id='title_td'>
                        <input type='text' name='post[title]' id='title' maxlength='60' size='61' value='{$post.title}' />
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
            </table>
        </form>
    </div>
</div>

{literal}
<script type='text/javascript'>
    var title = new Spry.Widget.ValidationTextField("title_td", "none", {useCharacterMasking:true, validateOn:['change','blur']});    
    var post_text = new Spry.Widget.ValidationTextarea('text_td');
</script>
{/literal}
