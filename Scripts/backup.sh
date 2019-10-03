#!/bin/bash

# A simple script to perform postgres db backup.

DATABASE="bd_sig"
DATE=$(date +"%d-%m-%Y_%H:%M:%S")
FILE="/root/Desktop/SIG/SIG-Clinica/Scripts/backups/$DATABASE_$DATE.sql"
PGPASSWORD="admin123"


cd /root/Desktop/SIG/SIG-Clinica/Scripts/backups
pg_dump -U clinica_user -h localhost -d bd_sig --no-password > bd_sig_$DATE.sql

createdb temporal -U postgres

psql -U postgres -d temporal<bd_sig_$DATE.sql -q >/dev/null

dropdb temporal -U postgres
echo "done"
exit