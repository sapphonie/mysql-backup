#!/bin/bash
# written by sapphonie

bakloc="/mnt/sql"
rootpw="whatevr"

# sync filesystem
echo "syncing"
sync
# remove all sql files older than 30 days
echo "rm-ing old backups"
find "${bakloc}" -iname '*.sql' -mmin +10080 -exec rm -v {} +
# grab date
ymd=$(date +%Y/%m/%d)
# make directory with parents
echo "mkdiring ${bakloc}${ymd}"
mkdir -p "${bakloc}${ymd}"
# do the dump with pv
echo "dumping to /mnt/sql/${ymd}/daily.sql"
mysqldump -u root -p${rootpw} --all-databases | pv > "/mnt/sql/${ymd}/daily.sql"
