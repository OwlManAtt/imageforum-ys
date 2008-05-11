<?php
/**
 * Process a reply submitted via the reply form. 
 *
 * This file is part of 'Kitto_Kitto_Kitto'.
 *
 * 'Kitto_Kitto_Kitto' is free software; you can redistribute
 * it and/or modify it under the terms of the GNU
 * General Public License as published by the Free
 * Software Foundation; either version 3 of the License,
 * or (at your option) any later version.
 * 
 * 'Kitto_Kitto_Kitto' is distributed in the hope that it will
 * be useful, but WITHOUT ANY WARRANTY; without even the
 * implied warranty of MERCHANTABILITY or FITNESS FOR A
 * PARTICULAR PURPOSE.  See the GNU General Public
 * License for more details.
 * 
 * You should have received a copy of the GNU General
 * Public License along with 'Kitto_Kitto_Kitto'; if not,
 * write to the Free Software Foundation, Inc., 51
 * Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 *
 * @author Nicholas 'Owl' Evans <owlmanatt@gmail.com>
 * @copyright Nicolas Evans, 2007
 * @license http://www.gnu.org/licenses/gpl-3.0.txt GPLv3
 * @package Kitto_Kitto_Kitto
 * @subpackage Board
 * @version 1.0.0
 **/

$ERRORS = array();
$POST_AS = array('user' => 'No','anonymous' => 'Yes',);

$thread_id  = ($_REQUEST['thread_id']);
$post_text = trim(clean_xhtml($_REQUEST['post']['text']));
$identity = stripinput(trim($_POST['post']['identity']));

if((strtotime($User->getDatetimeLastPost()) + $APP_CONFIG['post_interval']) > time())
{
    $text = secondsToMinutes($APP_CONFIG['post_interval']);
    $ERRORS[] = "You may only post once every $text.";
} // end user posted too quickly

if($post_text == null) 
{
    $ERRORS[] = 'No message specified. It is possible that your HTML was so badly mal-formed that it was dropped by the HTML filter.';
}   

if(in_array($identity,array_keys($POST_AS)) == false)
{
    $ERRORS[] = 'Invalid identity specified.';
}

$thread = new BoardThread($db);
$thread = $thread->findOneByBoardThreadId($thread_id);

if($thread == null)
{
    $ERRORS[] = 'Thread does not exist.';
}
else
{
    if($thread->getLocked() != 'N')
    {
        $ERRORS[] = 'That thread is locked.';
    }

    $board = new Board($db);
    $board = $board->findOneByBoardId($thread->getBoardId());
    
    if($board == null)
    {
        $ERRORS[] = 'Invalid board.';
    }
    else
    {
        if($board->hasAccess($User) == false)
        {
            $ERRORS[] = 'Invalid board.';
        }
    }
} // end thread exists

// This post includes an image.
if(sizeof($ERRORS) == 0)
{
    $image_id = 0;
    if($_FILES['image']['size'] > 0 && $_FILES['image']['tmp_name'] != '')
    {
        $image = new BoardImage($db);
        
        try
        {
            $image->create($_FILES['image']);
            $image_id = $image->getBoardThreadPostImageId();
        }
        catch(UploadError $e)
        {
            $ERRORS[] = "{$e->getMessage()} (code {$e->getCode()})"; 
        }
    } // process image
} // end do not process image if errors in post

if(sizeof($ERRORS) > 0)
{
    draw_errors($ERRORS);
} 
else
{
    $post = new BoardPost($db);
    $post->create(array(
        'board_thread_id' => $thread->getBoardThreadId(),
        'user_id' => $User->getUserId(),
        'post_text' => $post_text, 
        'posted_datetime' => $post->sysdate(),
        'poster_type' => $identity,
        'board_thread_post_image_id' => $image_id,
    ));
    
    $thread->setThreadLastPostedDatetime($thread->sysdate());
    $thread->save();
    
    $_SESSION['board_notice'] = "Your message has been posted successfully in <strong>{$thread->getThreadName()}</strong>.";

    redirect(null,null,"board/{$thread->getBoardShortName()}");
} // end create post

?>
