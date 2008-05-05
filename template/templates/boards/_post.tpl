<div id=post_{$post.id} class='board-post'>
    <div class='post-userinfo'>
        {if $post.user_id != 0}
        <ul>
            <li class='username'>{kkkurl link_text=$post.username slug='profile' args=$post.user_id}</li>
            <li>{$post.user_title}</li>
            <li><strong>Posts</strong>: {$post.user_post_count|number_format}</li>
        </ul>
        
        {if $post.avatar_url != ''} 
        <p align='center'>
            <img src='{$post.avatar_url}' alt='{$post.avatar_name}' border='1' />
        </p>
        {/if}
        {else}
        <ul>
            <li class='username'>{$post.username}</li>
        </ul>

        {/if}


        {if $actions != ''}<div align='center' style='padding-bottom: 1em;'>
            <form action='{$display_settings.public_dir}/forum-admin' method='post'>
                <input type='hidden' name='post[id]' value='{$post.id}' />
                <input type='hidden' name='post[page]' value='{$page}' />
                
                {html_options name='action' id="action_`$post.id`" options=$actions onChange="if(doForumAdminConfirms(this.form.action_`$post.id`[this.form.action_`$post.id`.selectedIndex].value) == true) this.form.submit();"}
            </form>
        </div>{/if}
    </div>
    <div class='post-content'>
        <p class='post-content-header'>Posted at {$post.posted_at} {if $locked == 'N'}&mdash; <a onClick="quotePlain('post-{$post.id}-message','post_text')">Quote</a>{/if} &mdash; {kkkurl link_text='Link' slug='threads' args=`$board.short_name`/`$thread.id`/`$page`#`$post.id` name=$post.id}{if $post.can_edit == 1} &mdash; {kkkurl link_text='Edit' slug='edit-post' args=$post.id}{/if}</p>
        <div id='post-{$post.id}-message'>{$post.text|markdown}</div>
        {if $post.user_id != 0}{if $post.signature != ''}<div class='post-signature'>{$post.signature|markdown}</div>{/if}{/if}
    </div>
    <br clear='all' />
</div>
