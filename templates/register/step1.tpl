{**************************************************************************}
{*                                                                        *}
{*  Copyright (C) 2003-2018 Polytechnique.org                             *}
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

{include file="register/breadcrumb.tpl"}

<h1>Identification</h1>

<form action="register" method="post">
  <p>
    Avant toute chose, il te faut nous donner ta «&nbsp;promotion d'annuaire&nbsp;»&nbsp;:
    <ul>
      <li>pour les polytechniciens (cursus ingénieur) il s'agit de la promotion habituelle (année d'admission)&nbsp;;</li>
      <li>pour les masters, doctorants et docteurs, il s'agit de l'année théorique d'obtention du diplôme (année d'entrée + 2 ou 3)&nbsp;;</li>
      <li>pour les cursus de Bachelor, Graduate Degree, Executive Education et Master Spécialisé, il s'agit de l'année d'entrée à l'École polytechnique.</li>
    </ul>
  </p>
  <table class="tinybicol">
    <tr>
      <th colspan="2">
        Promotion
      </th>
    </tr>
    <tr>
      <td>
        Donne ta promotion sur 4 chiffres&nbsp;:
      </td>
      <td>
        <input type="text" size="4" maxlength="4" name="yearpromo" value="{$smarty.post.yearpromo}" />
      </td>
    </tr>
    <tr>
      <td>
        Formation suivie&nbsp;:
      </td>
      <td>
        <select name="edu_type">
          <option value="{#Profile::DEGREE_X#}" selected="selected">polytechnicienne</option>
          <option value="{#Profile::DEGREE_M#}">master</option>
          <option value="{#Profile::DEGREE_D#}">doctorat</option>
          <option value="{#Profile::DEGREE_B#}">bachelor</option>
          <option value="{#Profile::DEGREE_E#}">executive education</option>
          <option value="{#Profile::DEGREE_G#}">graduate degree</option>
          <option value="{#Profile::DEGREE_S#}">master spécialisé</option>
        </select>
      </td>
    </tr>
    <tr>
      <td class="center" colspan="2">
        <input type="submit" value="Valider" />
      </td>
    </tr>
  </table>
</form>

{* vim:set et sw=2 sts=2 sws=2 fenc=utf-8: *}
