#!/usr/bin/env bash
set -e
shopt -s expand_aliases

# Redirect stdout and stderr ( > ) into a named pipe ( >() ) running "tee"
exec > >(tee -i $(date +"%Y-%m-%d_%H-%M").log)
exec 2>&1

source /cvmfs/lhcb.cern.ch/lib/LbLogin.sh

SetupProject LHCb

for tag in $(./get-list-of-tags.py); do
    cd DDDB
    if [ `git tag | grep "$tag"` ]; then
        echo "Skipping \"$tag\", tag already exists"
    else
        echo "Adding tag: \"$tag\""
        git rm -q -r ./*
        dump_db_to_files.py -c sqlite_file:$SQLITEUPGRADEDBPATH/DDDB.db/DDDB -T "$tag"  -t $(date +"%s000000000") -d .
        git add .
        git commit -m "Added $tag"
        git tag "$tag"
    fi
    cd ..
done

cd DDDB
git push --tags
cd ..
