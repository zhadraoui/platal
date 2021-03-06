#!/usr/bin/perl
#***************************************************************************
#*  Copyright (C) 2003-2018 Polytechnique.org                              *
#*  http://opensource.polytechnique.org/                                   *
#*                                                                         *
#*  This program is free software; you can redistribute it and/or modify   *
#*  it under the terms of the GNU General Public License as published by   *
#*  the Free Software Foundation; either version 2 of the License, or      *
#*  (at your option) any later version.                                    *
#*                                                                         *
#*  This program is distributed in the hope that it will be useful,        *
#*  but WITHOUT ANY WARRANTY; without even the implied warranty of         *
#*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the          *
#*  GNU General Public License for more details.                           *
#*                                                                         *
#*  You should have received a copy of the GNU General Public License      *
#*  along with this program; if not, write to the Free Software            *
#*  Foundation, Inc.,                                                      *
#*  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA                *
#***************************************************************************/

use LWP::UserAgent;
use HTTP::Request::Common 'POST';

print LWP::UserAgent
  ->new
  ->request(
            POST 'http://murphy.polytechnique.org/w3c-markup-validator/check',
            Content_Type => 'form-data',
            Content      => [
                             output => 'xml',
                             uploaded_file => [$ARGV[0]],
                            ]
           )->as_string;

