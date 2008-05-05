<p>You may update your password, e-mail address, and other preferences here. If you wish to update any fields in the '<em>Account Settings</em>' section, please enter your old password.</p>

{if $notice != ''}<p id='pref_notice' class='{$fat} notice-box'>{$notice}{/if}

<div align='center'>
    <form action='{$display_settings.public_dir}/preferences/' method='post'>
        <input type='hidden' name='state' value='save_account' />
    
        <table class='inputTable' style='padding-bottom: 1em;' width='45%'>
            <tr>
                <td colspan='2' class='inputTableHead'>Account Settings</td>
            </tr>
            <tr>
                <td width='20%' class='inputTableRow inputTableSubhead'>
                    <label for='old'>Old Password</label>
                </td>
                <td width='80%' class='inputTableRow' id='old_td'>
                    <input type='password' name='password[old]' id='old' />
                </td>
            </tr>
            <tr>
                <td class='inputTableRowAlt inputTableSubhead'>
                    <label for='a'>New Password</label>
                </td>
                <td class='inputTableRowAlt' id='a_td'>
                    <input type='password' name='password[a]' id='a' />
                </td>
            </tr>
            <tr>
                <td width='20%' class='inputTableRow inputTableSubhead'>
                    <label for='b'>Repeat</label>
                </td>
                <td class='inputTableRow' id='b_td'>
                    <input type='password' name='password[b]' id='b' />
                </td>
            </tr>
            <tr>
                <td class='inputTableRowAlt inputTableSubhead'>
                    <label for='email'>E-mail Address</label>
                </td>
                <td class='inputTableRowAlt' id='email_td'>
                    <input type='text' name='user[email]' id='email' value='{$prefs.email}' />
                </td>
            </tr>
            <tr>
                <td class='inputTableRow' style='text-align: right;' colspan='2'>
                    <input type='submit' value='Save Account Settings' />
                </td>
            </tr>
        </table>
    </form>
    <hr width='43%' />
    <form action='{$display_settings.public_dir}/preferences/' method='post'>
        <input type='hidden' name='state' value='save_preferences' />

        <table class='inputTable' style='padding-top: 1em;' width='45%'>
            <tr>
                <td colspan='3' class='inputTableHead'>Preferences</td>
            </tr>
            <tr>
                <td width='20%' class='inputTableRow inputTableSubhead'>
                    <label for='default_post_as'>Post Anonymously?</label>
                </td>
                <td class='inputTableRow' width='80%' colspan='2' id='default_post_as_td'>
                    {html_options name='user[default_post_as]' id='default_post_as' selected=$prefs.default_post_as options=$post_as_options}
                </td>
            </tr>
            <tr>
                <td width='20%' class='inputTableRow inputTableSubhead'>
                    <label for='timezone'>Timezone</label>
                </td>
                <td class='inputTableRow' width='80%' colspan='2' id='timezone_td'>
                    {html_options name='user[timezone]' id='timezone' selected=$prefs.timezone_id options=$timezones}
                </td>
            </tr>
            <tr>
                <td width='20%' class='inputTableRowAlt inputTableSubhead'>
                    <label for='datetime_format'>Date Format</label>
                </td>
                <td class='inputTableRowAlt' width='80%' colspan='2' id='datetime_format_td'>
                    {html_options name='user[datetime_format]' id='datetime_format' selected=$prefs.datetime_format_id options=$datetime_formats}
                </td>
            </tr>
            <tr>
                <td width='20%' class='inputTableRowAlt inputTableSubhead'>
                    <label for='avatar'>Avatar</label>
                </td>
                <td class='inputTableRowAlt' style='vertical-align: top;' id='avatar_td'>
                    {html_options name='user[avatar]' id='avatar' options=$avatars selected=$prefs.avatar_id onChange="return imagePicker(this.form.avatar[this.form.avatar.selectedIndex].value,'`$display_settings.public_dir`/resources/avatars/','avatar_image');"}
                </td>
                <td class='inputTableRowAlt'>
                    <img src='{$prefs.avatar_url}' alt='Avatar' border='0' id='avatar_image' {if $prefs.avatar_id == ''}style='display: none;' {/if}/>
                </td>
            </tr>
            <tr>
                <td width='20%' class='inputTableRow inputTableSubhead'>
                    <label for='show_status'>Show Online Status</label>
                </td>
                <td width='80%' class='inputTableRow' colspan='2' id='show_status_td'>
                    {html_options name='user[show_online_status]' id='show_status' options=$online_status selected=$prefs.show_online_status}
                </td>
            </tr>
            <tr>
                <td width='20%' class='inputTableRowAlt inputTableSubhead'>
                    <label for='profile'>Profile</label>
                </td>
                <td width='80%' class='inputTableRowAlt' colspan='2' id='profile_td'>
                    <textarea name='user[profile]' id='profile' cols='55' rows='10'>{$prefs.profile}</textarea>
                </td>
            </tr>
            <tr>
                <td width='20%' class='inputTableRow inputTableSubhead'>
                    <label for='signature'>Signature</label>
                </td>
                <td width='80%' class='inputTableRow' colspan='2' id='signature_td'>
                    <textarea name='user[signature]' id='signature' cols='55' rows='10'>{$prefs.signature}</textarea>
                </td>
            </tr>
            <tr>
                <td class='inputTableRowAlt' style='text-align: right;' colspan='3'>
                    <input type='submit' value='Save Preferences' />
                </td>
            </tr>
        </table>
    </form>
</div>
