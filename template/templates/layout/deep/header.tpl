<?xml version="1.0"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
    <head>
        <title>{if $page_title eq ''}{$site_name} | Welcome{else}{$site_name} | {$page_title}{/if}</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <link href="{$display_settings.public_dir}/resources/styles/style.css" media="screen" rel="stylesheet" type="text/css" />
        <script type='text/javascript' src='{$display_settings.public_dir}/resources/script/fat.js'></script>
        <script type='text/javascript' src='{$display_settings.public_dir}/resources/script/yasashii.js'></script>
    </head>
    <body>
        <div id='mainmenu'>
            {include file='layout/deep/board_menu.tpl'}
            {if $logged_in == true}{include file="layout/user_box.tpl"}{else}{include file="layout/nonuser.tpl"}{/if}
            <span title='Meta'>[</span>{kkkurl slug='news' link_text='news' title='Site News'} / {kkkurl slug='rules' link_text='rules' title='Posting Rules'}]
        </div>
        <hr id='top-divider' />
        <!-- Page beging here. -->

