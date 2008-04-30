{foreach from=$board_menu item=category}<span title='{$category.name}'>[</span>{section loop=$category.boards name=board_index}{assign var=board value=$category.boards[board_index]}{kkkurl link_text=$board.short_name slug='board' args=$board.short_name title=$board.name}{if $smarty.section.board_index.last == 0}&nbsp;/&nbsp;{/if}{/section}]
{/foreach}
