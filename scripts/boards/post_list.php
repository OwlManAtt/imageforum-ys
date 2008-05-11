<?php
/**
 * List out the posts in a thread. 
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
$max_items_per_page = 15;

// Handle the page ID for slicing and dicing the inventory up.
$page_id = stripinput($_REQUEST['page']);
if($page_id == null || $page_id <= 0)
{
    $page_id = 1;
}

// Where do we slice the record set?
$start = (($page_id - 1) * $max_items_per_page);
$end = (($page_id - 1) * $max_items_per_page) + $max_items_per_page;

// Load the board.
$thread_id = stripinput($_REQUEST['thread_id']);
$thread = new BoardThread($db);
$thread = $thread->findOneByBoardThreadId($thread_id);

if($thread == null)
{
    $ERRORS[] = 'Invalid thread specified.';
}
else
{
    // Load the board info.
    $board = new Board($db);
    $board = $board->findOneByBoardId($thread->getBoardId());

    if($board == null)
    {
        $ERRORS[] = 'Invalid board.';
    }
    else
    {
        if($_REQUEST['board_slug'] != $board->getBoardShortName())
        {
            $ERRORS[] = "Invalid thread.";
        }

        if($board->hasAccess($User) == false)
        {
            $ERRORS[] = 'Invalid board.';
        }
    }
} // end thread is valid
    
if(sizeof($ERRORS) > 0)
{
    draw_errors($ERRORS);
}
else
{
    $BOARD_DATA = array(
        'category' => $board->getCategoryName(),
        'id' => $board->getBoardId(),
        'name' => $board->getBoardName(),
        'locked' => $board->getBoardLocked($User),
        'short_name' => $board->getBoardShortName(),
    );
    
    $THREAD_DATA = array(
        'id' => $thread->getBoardThreadId(),
        'name' => $thread->getThreadName(),
        'locked' => (($User instanceof User) ? $thread->getLocked() : false),
        'sticky' => $thread->getStickied(),
        'can_edit' => (($User instanceof User) ? ((($User->hasPermission('edit_post') == true)) ? true : false) : false),
    );
    
    // Generate the pagination. 
    $pagination = pagination("thread/{$thread->getBoardThreadId()}",$thread->grabPosts(null,true),$max_items_per_page,$page_id);
    
    $POST_LIST = array();
    $posts = $thread->grabPosts('ORDER BY board_thread_post.posted_datetime ASC',false,$start,$end);

    foreach($posts as $post)
    {
        $IMAGE = false;
        if($post->hasImage() == true)
        {
            $IMAGE = array(
                'height' => $post->getImageHeight(),
                'width' => $post->getImageWidth(),
                'size' => round(($post->getImageSizeBytes() / 1024),2),
                'original_name' => $post->getImageOriginalName(),
                'thumb_url' => $post->getImageThumbUrl(),
                'full_url' => $post->getImageUrl(),
            );
        } // end image exists

        $POST_LIST[] = array(
            'id' => $post->getBoardThreadPostId(),
            'posted_at' => (($User instanceof User) ? $User->formatDate($post->getPostedDatetime()) : date($APP_CONFIG['default_datetime_format'],strtotime($post->getPostedDatetime()))), 
            'text' => $post->getPostText(),
            'quote_text' => str_replace("'","&#145;",htmlentities(str_replace("\r\n",'\r\n> ','> '.$post->getPostText()))),
            'user_id' => $post->getUserId(), 
            'username' => $post->getUserName(),
            'user_title' => $post->getUserTitle(),
            'signature' => $post->getSignature(),
            'avatar_url' => $post->getAvatarUrl(),
            'avatar_name' => $post->getAvatarName(),
            'user_post_count' => $post->getPostCount(),
            'page' => $page_id,
            'image' => $IMAGE,
            'can_edit' => (($User instanceof User) ? ((($User->hasPermission('edit_post') == true)) ? true : false) : false),
        );
    } // end thread loop

    $ADMIN_ACTIONS = array('' => 'Moderation...');
    if($User instanceof User)
    {
        if($User->hasPermission('delete_post') == true)
        {
            $ADMIN_ACTIONS['delete_post'] = 'Delete Post';
            $ADMIN_ACTIONS['delete_thread'] = 'Delete Thread';
        }

        if($User->hasPermission('manage_thread') == true)
        {
            if($thread->getLocked() == 'N')
            {
                $ADMIN_ACTIONS['lock'] = 'Lock Thread'; 
            }
            else
            {
                $ADMIN_ACTIONS['lock'] = 'Unock Thread'; 
            }
             
            if($thread->getStickied() == 0)
            {
                $ADMIN_ACTIONS['stick'] = 'Stick Thread';
            }
            else
            {
                $ADMIN_ACTIONS['stick'] = 'Unstick Thread';
            }
        } // end thread management
    } // end logged in
        
    if(sizeof($ADMIN_ACTIONS) > 1)
    {
        $renderer->assign('actions',$ADMIN_ACTIONS);
    }

    if($_SESSION['board_notice'] != null)
    {
        $renderer->assign('board_notice',$_SESSION['board_notice']);
        unset($_SESSION['board_notice']);
    }
    
    $renderer->assign('post_as_options',$POST_AS);
    $renderer->assign('identity_preference',(($User instanceof User) ? $User->getDefaultPostAs() : '')); 
    $renderer->assign('board',$BOARD_DATA);    
    $renderer->assign('thread',$THREAD_DATA);    
    $renderer->assign('posts',$POST_LIST);
    $renderer->assign('page',$page_id);
    $renderer->assign('pagination',$pagination);
    $renderer->display('boards/post_list.tpl');
} // end board exists
?>
