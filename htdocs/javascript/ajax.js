/***************************************************************************
 *  Copyright (C) 2003-2010 Polytechnique.org                              *
 *  http://opensource.polytechnique.org/                                   *
 *                                                                         *
 *  This program is free software; you can redistribute it and/or modify   *
 *  it under the terms of the GNU General Public License as published by   *
 *  the Free Software Foundation; either version 2 of the License, or      *
 *  (at your option) any later version.                                    *
 *                                                                         *
 *  This program is distributed in the hope that it will be useful,        *
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of         *
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the          *
 *  GNU General Public License for more details.                           *
 *                                                                         *
 *  You should have received a copy of the GNU General Public License      *
 *  along with this program; if not, write to the Free Software            *
 *  Foundation, Inc.,                                                      *
 *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA                *
 ***************************************************************************/

function AjaxEngine()
{
    this.update_html = function(obj, src, func)
    {
        $.get(src,
            function(data, textStatus) {
                if (textStatus == "success") {
                    if (obj) {
                        $('#' + obj).html(data);
                    }
                    if (func) {
                        func(data);
                    }
                } else if (textStatus == "error") {
                    alert("Une erreur s'est produite lors du traitement de la requête.\n"
                         +"Ta session a peut-être expirée.");
                }
            }, 'text');
        return false;
    }
}

var Ajax = new AjaxEngine();

var currentTempMessage = 0;
function setOpacity(obj, opacity)
{
  opacity = (opacity == 100)?99:opacity;
  // IE
  obj.style.filter = "alpha(opacity:"+opacity+")";
  // Safari < 1.2, Konqueror
  obj.style.KHTMLOpacity = opacity/100;
  // Old Mozilla
  obj.style.MozOpacity = opacity/100;
  // Safari >= 1.2, Firefox and Mozilla, CSS3
  obj.style.opacity = opacity/100
}

function _showTempMessage(id, state, back)
{
    var obj = document.getElementById(id);
    if (currentTempMessage != state) {
        return;
    }
    setOpacity(obj, back * 4);
    if (back > 0) {
        setTimeout("_showTempMessage('" + id + "', " + currentTempMessage + "," + (back-1) + ")", 125);
    } else {
        obj.innerHTML = "";
    }
}

function showTempMessage(id, message, success)
{
    var obj = document.getElementById(id);
    obj.innerHTML = (success ? "<img src='images/icons/wand.gif' alt='' /> "
                             : "<img src='images/icons/error.gif' alt='' /> ") + message;
    obj.style.fontWeight = "bold";
    obj.style.color = (success ? "green" : "red");;
    currentTempMessage++;
    setOpacity(obj, 100);
    setTimeout("_showTempMessage('" + id + "', " + currentTempMessage + ", 25)", 1000);
}

function previewWiki(idFrom, idTo, withTitle, idShow)
{
    var text = document.getElementById(idFrom).value;
    if (text == "") {
        return false;
    }
    var url  = "wiki_preview";
    if (!withTitle) {
        url += "/notitle";
    }
    $.post(url, { text: text },
        function(data) {
            $("#" + idTo).html(data);
        },
        'text');
    if (idShow != null) {
        document.getElementById(idShow).style.display = "";
    }
}

function sendTestEmail(token, hruid)
{
    Ajax.update_html(null, 'emails/test' + (hruid == null ? '' : '/' + hruid) + '?token=' + token,
                     function() {
                        showTempMessage('mail_sent', "Un email a été envoyé avec succès"
                                        + (hruid == null ? " sur ton adresse." : " sur l'adresse de " + hruid),
                                        true); });
    return false;
}

// vim:set et sw=4 sts=4 sws=4 foldmethod=marker enc=utf-8: