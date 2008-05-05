<div align='center'>	
    <table class='inputTable'> 
        <tr>
            <td class='inputTableRow inputTableSubhead' width='40%'>User</td>
            <td class='inputTableRow'>{$profile.user_name}</td>
        </tr>
        
        <tr>
            <td class='inputTableRowAlt inputTableSubhead'>Title</td>
            <td class='inputTableRowAlt'>{$profile.title}</td> 
        </tr>
        
        <tr>
            <td class='inputTableRow inputTableSubhead'>Member Since</td>
            <td class='inputTableRow'>{$profile.created}</td>
        </tr>
        {if $profile.show_online_status == 1} 
        <tr>
            <td class='inputTableRowAlt inputTableSubhead'>Last Online</td>
            <td class='inputTableRowAlt'>{if $profile.last_active == 0}<em>Never!</em>{else}{$profile.last_active|timediff}{/if}</td>
        </tr>
        {/if}
        <tr>
            <td class='inputTableRow inputTableSubhead'>Last Posted</td>
            <td class='inputTableRow'>{if $profile.last_post == 0}<em>Never!</em>{else}{$profile.last_post|timediff}{/if}</td>
        </tr>
        <tr>
            <td class='inputTableRowAlt inputTableSubhead'>Posts</td>
            <td class='inputTableRowAlt'>{$profile.posts|number_format}</td>
        </tr>
        <tr>
            <td style='text-align: center;' class='inputTableRow' colspan='2'>
                {if $logged_in == 1}
                <form action='{$display_settings.public_dir}/write-new-message/{$profile.id}/' method='get' style='display: inline; padding-right: 1em;'>
                    <input type='submit' value='Send Message' />
                </form>
                {/if}
                {if $edit_user == 1}
                <form action='{$display_settings.public_dir}/admin-users/' method='get' style='display: inline;'>
                    <input type='hidden' name='user_id' value='{$profile.id}' />
                    <input type='submit' value='User Admin Panel' />
                </form>
                {/if}
            </td>
        </tr>
        {if $profile.special_status != ''}<tr>
            <td class='inputTableRowAlt' colspan='2' style='text-align: center; font-size: x-large;'>{$profile.special_status}</td>
        </tr>{/if}
    </table>
    {if $profile.profile != ''}<div id='user-profile-area'>{$profile.profile}</div>{/if}
</div>
