## The Offline Windows Password Editor

© 2023 jpz4085, 2021 Mina Her, 1997-2014 Petter Nordahl-Hagen

This is free software, licensed under the following:

[GNU General Public License, version 2](https://www.gnu.org/licenses/gpl-2.0.html)  
**chntpw** _(the password reset / registry editor frontend)_  
**reged** _(registry editor, export and import tool)_  
**sampasswd** _(password reset command line program)_  
**samusrgrp** _(user and group command line program)_  

[GNU Lesser General Public License, version 2.1](https://www.gnu.org/licenses/lgpl-2.1.html)  
**ntreg** _(the registry library)_  
**libsam** _(SAM manipulation library, user, groups etc)_

Historical information is installed at: _/opt/local/share/doc/chntpw_

Install/Uninstall
-----------------
```
make
sudo make install
sudo make uninstall
```

Requirements
------------
**OpenSSL 1.1**

- Install using Homebrew or MacPorts.
- Makefile library and include paths may need adjusted.
