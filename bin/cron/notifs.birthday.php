#!/usr/bin/php5 -q
<?php
/***************************************************************************
 *  Copyright (C) 2003-2009 Polytechnique.org                              *
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

require('./connect.db.inc.php');

$date  = date('Y-m-d', time() + 7 * 24*60*60);
$stamp = date('Ymd000000');
$like  = date('%-m-d', time() + 7 * 24*60*60);

XDB::execute("DELETE FROM  watch_ops
                    WHERE  cid = 4 AND date < CURDATE()");

XDB::execute("INSERT INTO  watch_ops (uid, cid, known, date)
                   SELECT  user_id, 4, $stamp, '$date'
                     FROM  auth_user_md5
                    WHERE  naissance LIKE '$like' AND deces=0");


// vim:set et sw=4 sts=4 sws=4 foldmethod=marker enc=utf-8:
?>