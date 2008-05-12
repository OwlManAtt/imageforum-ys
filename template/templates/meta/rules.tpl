<h1>The Rules</h1>

<p>In addition to the {kkkurl slug='terms-and-conditions' link_text='terms and conditions'} you agreed to upon joining the site, each board has additional rules that govern what may and may not be posted. To reiterate the Ts &amp; Cs, the site's global rules are:</p>
<ol>
    <li>Do not post anything that would be considered illegal in the United States, the state of Connecticut, or the state of Texas.</li> 
    <li>Spamming will not be tolerated. Shameless promotion of your website, products, services, or newsletter/quarterly will be purged mercilessly.</li>
    <li>Do not post pornographic images in the worksafe areas.</li>
</ol>

<p>Posts in violation of any of the global rules or board-specific rules may result in your post being moved or deleted, an angry letter from a moderator, or the banning of your account. We don't want any of that, now do we?</p>

<hr style='width: 80%;' />

{section name=index loop=$boards}
{assign var=board value=$boards[index]}
<div class='rule-box'>
    <h2>/{$board.short_name}/ - {$board.name}</h2>
    {$board.rules|markdown}
</div>
{/section}
