#!/usr/bin/env python
from __future__ import print_function

from CondDBUI import CondDB

db = CondDB('sqlite_file:/afs/cern.ch/lhcb/software/releases/SQLite/SQLDDDB_Upgrade/db/DDDB.db/DDDB')
for tag in db.getTagList('/'):
    if tag.name.startswith('dddb'):
        print(tag.name)
