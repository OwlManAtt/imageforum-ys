<p>In order to post, you will have to create an account. You will not be required to post under your account name - posting anonymously is an option. Moderators will not be able to see who an anonymous poster is; only administrators have that ability.</p>
<p>Your email address is required to make life difficult for jackasses and to be used to contact you if you forget your password and request a reset.</p>
<p>If you can't read the CAPTCHA image - those blue letters in the image - click it to generate a new one. If you still cannot read it, go to hell.</p>

<div align='center'>
    <form action='{$display_settings.public_dir}/{$self.slug}' method='post'>
        <input type='hidden' name='state' value='process' />
        
        <table class='inputTable'>
            <tr>
                <td class='inputTableRow inputTableSubhead'>
                    <label for='username'>User Name</label>
                </td>
                <td class='inputTableRow' id='username_td'>
                    <input type='text' name='user[user_name]' id='username' value='' maxlength='25' />
                </td>
            </tr>
            
            <tr>
                <td class='inputTableRowAlt inputTableSubhead'>
                    <label for='password'>Password</label>
                </td>
                <td class='inputTableRowAlt' id='password_td'>
                    <input type='password' name='user[password]' id='password' value='' />
                </td>
            </tr>

            <tr>
                <td class='inputTableRow inputTableSubhead'>
                    <label for='password_again'>Password Again</label>
                </td>
                <td class='inputTableRow' id='password_again_td'>
                    <input type='password' name='user[password_again]' id='password_again' value='' />
                </td>
            </tr>
        
            <tr>
                <td class='inputTableRowAlt inputTableSubhead'>
                    <label for='email'>E-mail Address</label>
                </td>
                <td class='inputTableRowAlt' id='email_td'>
                    <input type='text' name='user[email]' id='email' value='' />
                </td>
            </tr>

            <tr>
                <td class='inputTableRow inputTableSubhead' align='center'>
                    <a href="#" onclick="javascript:document.getElementById('captchaimage').src = '{$display_settings.public_dir}/captcha.php?' + Math.random();return false;">
                        <img id="captchaimage" src="{$display_settings.public_dir}/captcha.php" alt="CAPTCHA image" style='border: 0;' />
                    </a>
                </td>
                <td class='inputTableRow' id='code_td'>
                    <input type='text' name='captcha_code' id='captcha_code' value='' /><br />
                </td>
            </tr>
            
            <tr>
                <td colspan='2' class='inputTableRowAlt' align='center'>
                    Registration indicates that you agree to abide by the {kkkurl link_text='Terms and Conditions' slug='terms-and-conditions'}.
                </td>
            </tr>

            <tr>
                <td colspan='2' class='inputTableRow' style='text-align: right;'>
                    <input type='submit' value='Submit' />
                </td>
            </tr>

        </table>
    </form>
</div>
