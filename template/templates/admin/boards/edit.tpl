<form action='{$display_settings.public_dir}/admin-boards-edit/' method='post'>
    <input type='hidden' name='state' value='save' />
    <input type='hidden' name='board[id]' value='{$board.id}' />
    
    {include file='admin/boards/_form.tpl'}
</form>
