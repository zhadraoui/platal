{**************************************************************************}
{*                                                                        *}
{*  Copyright (C) 2003-2010 Polytechnique.org                             *}
{*  http://opensource.polytechnique.org/                                  *}
{*                                                                        *}
{*  This program is free software; you can redistribute it and/or modify  *}
{*  it under the terms of the GNU General Public License as published by  *}
{*  the Free Software Foundation; either version 2 of the License, or     *}
{*  (at your option) any later version.                                   *}
{*                                                                        *}
{*  This program is distributed in the hope that it will be useful,       *}
{*  but WITHOUT ANY WARRANTY; without even the implied warranty of        *}
{*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *}
{*  GNU General Public License for more details.                          *}
{*                                                                        *}
{*  You should have received a copy of the GNU General Public License     *}
{*  along with this program; if not, write to the Free Software           *}
{*  Foundation, Inc.,                                                     *}
{*  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA               *}
{*                                                                        *}
{**************************************************************************}

<h1>Gestion de mes emails</h1>

{javascript name=ajax}
{literal}
<script type="text/javascript">
  function bestaliasUpdated() {
    showTempMessage('bestalias-msg', "Le changement a bien été effectué.", true);
  }
</script>
{/literal}

<fieldset>
  <legend>{icon name="email"} Mes adresses polytechniciennes à vie</legend>

  <div>
    Tes adresses polytechniciennes sont&nbsp;:<br />
    <div>
      {iterate from=$aliases item=a}
      <label><input type='radio' {if $a.best}checked="checked"{/if} name='best' value='{$a.alias}' onclick='Ajax.update_html(null,"{$globals->baseurl}/emails/best/{$a.alias}?token={xsrf_token}",bestaliasUpdated)' />
      {if $a.a_vie}(**){/if}{if $a.cent_ans}(*){/if} <strong>{$a.alias}</strong>@{#globals.mail.domain#} et
      @{#globals.mail.domain2#}</label>
      {if $a.expire}<span class='erreur'>(expire le {$a.expire|date_format})</span>{/if}
      <br />
      {/iterate}
    </div>
    <p class="smaller">
    L'adresse cochée est celle que tu utilises le plus (et qui sera donc affichée sur ta carte de visite, ta fiche&hellip;).
    <br />Coche une autre case pour en changer&nbsp;!
    </p>

    <div id="bestalias-msg" style="position:absolute;"></div>
    {if $melix}
    <br />
    <div>
    Tu dispose également de l'alias&nbsp;: <strong>{$melix}</strong>
    (<a href="email/alias">changer ou supprimer mon alias melix</a>)
    </div>
    {/if}
  </div>
  <hr />
  <div>
    (M4X signifie <em>mail for X</em>, son intérêt est de te doter d'une adresse à vie
    moins "voyante" que l'adresse @{#globals.mail.domain#}).
    {if !$melix}
    Tu peux ouvrir en supplément une adresse synonyme de ton adresse @{#globals.mail.domain#},
    sur les domaines @{#globals.mail.alias_dom#} et @{#globals.mail.alias_dom2#} (melix = Mél X).<br />
    <div class="center"><a href="email/alias">Créer un alias melix</a></div>
    {/if}
  </div>
</fieldset>

<p class="smaller">
(*) cette adresse email t'est réservée pour une période 100 ans après ton entrée à l'X (dans ton cas, jusqu'en
{$smarty.session.promo+100}).
</p>
<p class="smaller">
(**) cette adresse email t'est réservée à vie.
</p>
<p class="smaller">
{if $homonyme}
Tu as un homonyme X donc tu ne peux pas profiter de l'alias {$homonyme}@{#globals.mail.domain#}. Si quelqu'un essaie
d'envoyer un email à cette adresse par mégarde il recevra une réponse d'un robot lui expliquant l'ambiguité et lui
proposant les adresses des différents homonymes.
{else}
Si tu venais à avoir un homonyme X, l'alias «prenom.nom»@{#globals.mail.domain#} sera désactivé. Si bien que
ton homonyme et toi-même ne disposeraient plus que des adresses de la forme «prenom.nom.promo»@{#globals.mail.domain#}.
{/if}
</p>

<br />

<fieldset>
  <legend>{icon name="email_go"} Où est-ce que je reçois les emails qui m'y sont adressés&nbsp;?</legend>

  <div>
    {if count($mails) eq 0}
    <p class="erreur">
      Tu n'as actuellement aucune adresse de redirection. Tout email qui t'est envoyé sur tes
      adresses polytechniciennes génère une erreur. Modifie au plus vite ta liste de redirection.<br/>
    </p>
    {else}
    Actuellement, tout email qui t'y est adressé, est envoyé
    {if count($mails) eq 1} à l'adresse{else} aux adresses{/if}&nbsp;:
    <ul>
      {foreach from=$mails item=m}
      <li><strong>{$m->display_email}</strong></li>
      {/foreach}
    </ul>
    {/if}
    {test_email}
    Si tu souhaites <strong>modifier ce reroutage de tes emails,</strong>
    <a href="emails/redirect">il te suffit de te rendre ici&nbsp;!</a>
  </div>
</fieldset>

<br />

<fieldset>
  <legend>{icon name="bug_delete" text="Antivirus, antispam"} Antivirus, antispam</legend>

  <p>
    Tous les emails qui te sont envoyés sur tes adresses polytechniciennes sont
    <strong>filtrés par un logiciel antivirus</strong> très performant. Il te protège de ces
    vers très gênants, qui se propagent souvent par email.
  </p>
  <p>
    De même, un <strong>service antispam évolué</strong> est en place. Tu peux lui demander
    de te débarrasser des spams que tu reçois. Pour en savoir plus, et l'activer,
    <a href="emails/antispam">c'est très simple, suis ce lien</a>&nbsp;!
  </p>
</fieldset>

{* vim:set et sw=2 sts=2 sws=2 enc=utf-8: *}