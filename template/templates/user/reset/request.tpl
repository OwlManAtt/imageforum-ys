<p>If you have forgotten your password, you can reset it by filling out the form below. An e-mail will be sent to the address we have on file to verify that this is a valid request. Further directions can be found there.</p> 

{if $notice != ''}<p id='reset_notice' class='{$fat} notice-box'>{$notice}</p>{/if}

<div align='center'>
    <form action='{$display_settings.public_dir}/reset-password' method='post'>
        <input type='hidden' name='state' value='send' />

        <table class='inputTable'>
            <tr>
                <td class='inputTableRow inputTableSubhead'>
                    <label for='user_name'>User Name</label>
                </td>
                <td class='inputTableRow' id='user_name_td'>
                    <input type='text' name='forgot[user_name]' id='user_name' maxlength='25' /><br />
                </td>
            </tr>
            <tr>
                <td class='inputTableRowAlt inputTableSubhead'>
                    <label for='email'>E-mail</label>
                </td>
                <td class='inputTableRowAlt' id='email_td'>
                    <input type='text' name='forgot[email]' id='email' /><br />
                </td>
            </tr>
            <tr>
                <td class='inputTableRow inputTableSubhead' style='text-align: center;'>
                    <a href="#" onclick="javascript:document.getElementById('captchaimage').src = '{$display_settings.public_dir}/captcha.php?' + Math.random();return false;">
                        <img id="captchaimage" src="{$display_settings.public_dir}/captcha.php" alt="CAPTCHA image" style='border: 0;' />
                    </a>
                </td>
                <td class='inputTableRow' id='code_td'>
                    <input type='text' name='forgot[code]' id='code' /><br />
                </td>
            </tr>
            <tr>
                <td class='inputTableRowAlt' colspan='2' style='text-align: right;'>
                    <input type='submit' value='Submit' />
                </td>
            </tr>
        </table>
    </form>
</div>
