#!/bin/bash -x

# ReachView code is placed under the GPL license.
# Written by Egor Fedorov (egor.fedorov@emlid.com)
# Copyright (c) 2015, Emlid Limited
# All rights reserved.

# If you are interested in using ReachView code as a part of a
# closed source project, please contact Emlid Limited (info@emlid.com).

# This file is part of ReachView.

# ReachView is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# ReachView is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with ReachView.  If not, see <http://www.gnu.org/licenses/>.

sleep 1

cd /home/pi/ReachView
git fetch

if [[ $? -eq 0 ]];
then
    echo "Successfully updated remote repo info, resetting to master..."
    git checkout master
    git reset --hard origin/master

    echo "Copying default configs to RTKLIB directory"
    cp /home/pi/ReachView/rtklib_configs/*.conf /home/pi/RTKLIB/app/rtkrcv/
    cp /home/pi/ReachView/rtklib_configs/*.cmd /home/pi/RTKLIB/app/rtkrcv/

    cp /home/pi/ReachView/rtklib_configs/rtkrcv /home/pi/RTKLIB/app/rtkrcv/gcc/
    cp /home/pi/ReachView/rtklib_configs/str2str /home/pi/RTKLIB/app/str2str/gcc/
    cp /home/pi/ReachView/rtklib_configs/convbin /home/pi/RTKLIB/app/convbin/gcc/
fi

/home/pi/ReachView/install_packages.sh
chown -R reach:users /home/pi
/home/pi/ReachView/server.py
