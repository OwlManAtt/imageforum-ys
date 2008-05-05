<div id='breadcrumb-trail'>{$board.category} &raquo; /{$board.short_name}/ &mdash; {$board.name}</div>

{if $board_notice != ''}<p align='center' id='board_notice' class='{$fat} notice-box'>{$board_notice}</p>{/if}

<div align='center'>
    <table class='dataTable' width='85%'>
        <tr>
            <td class='dataTableSubhead' align='center' width='60%'>Topic</td>
            <td class='dataTableSubhead' align='center'>Poster</td>
            <td class='dataTableSubhead' align='center'>Last Post</td>
            <td class='dataTableSubhead' align='right'>Replies</td>
        </tr>
        {section name=index loop=$threads}
        {assign var='thread' value=$threads[index]}
        {cycle values='dataTableRow,dataTableRowAlt' assign=class}
        <tr>
            <td class='{$class}' align='center'>{if $thread.locked == 'Y'}<img src='{$display_settings.public_dir}/resources/images/lock.png' alt='(L)' border='0' /> {/if}{if $thread.sticky == 1}Sticky: {/if}{kkkurl link_text=$thread.topic slug='threads' args="`$board.short_name`/`$thread.id`"}{if $thread.last_page > 1} <small>({kkkurl link_text='Last Page' slug='threads' args=`$board.short_name`/`$thread.id`/`$thread.last_page`})</small>{/if}</td>
            <td class='{$class}' align='center'>{if $thread.poster_id != 0}{kkkurl link_text=$thread.poster_username slug='profile' args=$thread.poster_id}{else}<span style='poster-anon'>{$thread.poster_username}</span>{/if}</td>
            <td class='{$class}' align='center'>{$thread.last_post_at}</td>
            <td class='{$class}' align='right'>{$thread.posts}</td>
        </tr>
        {sectionelse}
        <tr>
            <td align='center' colspan='4' class='dataTableRow'><em>There are no threads.</em></td>
        </tr>
        {/section}
    </table>
</div>

{if $board.locked != 1}<br clear='all' />
<div id='new-post'>
    <form action='{$display_settings.public_dir}/new-thread/' method='get'>
        <input type='hidden' name='board_id' value='{$board.id}' />
        <input type='submit' value='Create Thread' />
    </form>
</div>{/if}

<br clear='all' />
<div class='pages'>{$pagination}</div>
