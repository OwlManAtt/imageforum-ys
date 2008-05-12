<?php
/**
 * Provides the ability to delete posts and threads, and lock/stick threads. 
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


$post_id = stripinput($_POST['post']['id']);
$page = stripinput($_POST['post']['page']);

$post = new BoardPost($db);
$post = $post->findOneByBoardThreadPostId($post_id);

if($post == null)
{
    $ERRORS[] = 'Invalid post specified.';
}
else
{
    $thread = new BoardThread($db);
    $thread = $thread->findOneByBoardThreadId($post->getBoardThreadId());
    
    if($thread == null)
    {
        $ERRORS[] = 'Invalid thread.';
    }
    else
    {
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
    } // end thread valid
} // end post exists

$MAP = array(
    // action => permission
    'delete_post' => 'delete_post',
    'delete_thread' => 'delete_post',
    'stick' => 'manage_thread',
    'lock' => 'manage_thread',
    'delete_image' => 'delete_post',
);

if($User->hasPermission($MAP[$_POST['action']]) == false)
{
    $ERRORS[] = 'You do not have permission to do that.';
}

if(sizeof($ERRORS) > 0)
{
    draw_errors($ERRORS);
}
else
{   
    switch($_POST['action'])
    {
        case 'delete_image':
        {
            if($post->hasImage() == false)
            {
                $_SESSION['board_notice'] = 'That post does not have an image to purge.';
            } // end no image
            else
            {
                $image = new BoardImage($db);
                $image = $image->findOneByBoardThreadPostImageId($post->getBoardThreadPostImageId());

                if($image == null)
                {
                    draw_errors(array('Image could not be found.')); 
                }
                else
                {
                    @unlink($post->getImagePath());
                    @unlink($post->getImageThumbPath());

                    $post->setBoardThreadPostImageId(0);
                    $post->save(); 
                    $image->destroy();

                    $_SESSION['board_notice'] = 'Image purged successfully.';
                } // end image loadable
            } // end has image
                
            redirect(null,null,"threads/{$thread->getBoardShortName()}/{$thread->getBoardThreadId()}/{$page}");

            break;
        } // end delete_image

        case 'delete_post':
        {

            if($thread->grabPosts(null,true) == 1)
            {
                $_SESSION['board_notice'] = 'You have deleted the thread.';

                // Last post, kill the thread since
                // there's nothing left in here.
                $board_id = $thread->getBoardShortName();
                $thread->destroy();

                redirect(null,null,"board/$board_id");
            }
            else
            {
                $_SESSION['board_notice'] = 'You have deleted the post.';

                $post->destroy();
                redirect(null,null,"threads/{$thread->getBoardShortName()}/{$thread->getBoardThreadId()}");
            }
            break;
        } // end delete_post
        
        case 'delete_thread':
        {
            $_SESSION['board_notice'] = 'You have deleted the thread.';

            $board_id = $thread->getBoardShortName();
            $thread->destroy();

            redirect(null,null,"board/$board_id");

            break;
        } // end delete_thread
        
        case 'lock':
        {
            if($thread->getLocked() == 'Y')
            {
                $thread->setLocked('N');
                $_SESSION['board_notice'] = 'You have unlocked the thread.';
            }
            else
            {
                $thread->setLocked('Y');
                $_SESSION['board_notice'] = 'You have locked the thread.';
            }
            
            $thread->save();
            redirect(null,null,"threads/{$thread->getBoardShortName()}/{$thread->getBoardThreadId()}/$page");
            
            break;
        } // end lock 
        
        case 'stick':
        {
            if($thread->getStickied() == true)
            {
                $_SESSION['board_notice'] = 'You have unstuck the thread.';
                $thread->setStickied(false);
            }
            else
            {
                $_SESSION['board_notice'] = 'You have stuck the thread.';
                $thread->setStickied(true);
            }

            $thread->save();
            redirect(null,null,"threads/{$thread->getBoardShortName()}/{$thread->getBoardThreadId()}/$page");

            break;
        } // end stick
        
        default:
        {
            draw_errors('Invalid action.');

            break;
        } // end default
    } // end action switch
} // end permission wrapping
?>
