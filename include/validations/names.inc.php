<?php
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

// {{{ class NamesReq

class NamesReq extends ProfileValidate
{
    // {{{ properties

    public $unique = true;

    public $sn_old;
    public $sn_new;
    public $display_names;
    public $old_alias;
    public $new_alias;
    public $sn_types;

    public $rules = "Refuser tout ce qui n'est visiblement pas un nom de famille (ce qui est extremement rare car à peu près n'importe quoi peut être un nom de famille).";

    // }}}
    // {{{ constructor

    public function __construct(User &$_user, Profile &$_profile, $_search_names, $_private_name_end)
    {
        parent::__construct($_user, $_profile, true, 'usage');
        require_once 'name.func.inc.php';

        $this->sn_types  = build_types();
        $this->sn_old    = build_sn_pub($this->profile->id());
        $this->sn_new    = $_search_names;
        $this->new_alias = true;
        $this->display_names = array();

        build_display_names($this->display_names, $_search_names,
                            $this->profile->isFemale(), $_private_name_end, $this->new_alias);
        foreach ($this->sn_new AS $key => &$sn) {
            if (!isset($sn['pub'])) {
                unset($this->sn_new[$key]);
            }
        }

        if (!is_null($this->profileOwner)) {
            $res = XDB::query("SELECT  alias
                                 FROM  aliases
                                WHERE  uid = {?} AND type = 'alias' AND FIND_IN_SET('usage', flags)",
                              $this->profileOwner->id());
            $this->old_alias  = $res->fetchOneCell();
            if ($this->old_alias != $this->new_alias) {
                $res = XDB::query("SELECT  uid
                                     FROM  aliases
                                    WHERE  alias = {?}",
                                  $this->new_alias);
                if ($res->fetchOneCell()) {
                    $this->new_alias = null;
                }
            }
        }
    }

    // }}}
    // {{{ function formu()

    public function formu()
    {
        return 'include/form.valid.names.tpl';
    }

    // }}}
    // {{{ function _mail_subj()

    protected function _mail_subj()
    {
        return "[Polytechnique.org/NOMS] Changement de noms";
    }

    // }}}
    // {{{ function _mail_body

    protected function _mail_body($isok)
    {
        global $globals;
        if ($isok) {
            $res = "  Le changement de nom que tu as demandé vient d'être effectué.";
            if (!is_null($this->profileOwner)) {
                if ($this->old_alias != $this->new_alias) {
                    if ($this->old_alias) {
                        $res .= "\n\n  Les alias {$this->old_alias}@{$globals->mail->domain} et @{$globals->mail->domain2} ont été supprimés.";
                    }
                    if ($this->new_alias) {
                        $res .= "\n\n  Les alias {$this->new_alias}@{$globals->mail->domain} et @{$globals->mail->domain2} sont maintenant à ta disposition !";
                    }
                }
                if ($globals->mailstorage->googleapps_domain) {
                    require_once 'googleapps.inc.php';
                    $account = new GoogleAppsAccount($this->profileOwner);
                    if ($account->active()) {
                        $res .= "\n\n  Si tu utilises Google Apps, tu peux changer ton nom d'usage sur https://mail.google.com/a/polytechnique.org/#settings/accounts.";
                    }
                }
            }
            return $res;
        } else {
            return "  La demande de changement de nom que tu avais faite a été refusée.";
        }
    }

    // }}}
    // {{{ function commit()

    public function commit()
    {
        require_once 'name.func.inc.php';

        set_profile_display($this->display_names, $this->profile);

        if (!is_null($this->profileOwner)) {
            set_alias_names($this->sn_new, $this->sn_old, $this->profile->id(),
                            $this->profileOwner->id(), true, $this->new_alias);

            // Update the local User object, to pick up the new bestalias.
            $this->profileOwner = User::getSilent($this->profileOwner->id());
        }

        return true;
    }

    // }}}
}
// }}}

// vim:set et sw=4 sts=4 sws=4 foldmethod=marker enc=utf-8:
?>