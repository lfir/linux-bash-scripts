#!/usr/bin/env bash

# Env vars needed:
# username - Owner of the home directory being backed up
# scriptDirOnDest - Full path of the dir where the backup script resides in on the destination

set -o errexit
set -o nounset
set -o pipefail

# Expected home and root mountpoints
targets=("/mnt/h/$username" '/mnt/r/etc')
dest=/media/bkp
logfn=log.txt

rsync -Aah --info=progress2 --stats --delete --log-file="$logfn" --exclude-from=excluded.txt "${targets[@]}" "$dest"

lastrunfn=last-backup-date.txt
errlogfn=error-log.txt
# Save the date of the current run
date -I > "$lastrunfn"
# Keep only rsync errors in the final log
grep 'rsync error' "$logfn" >> "$errlogfn"
# Copy files created after rsync ran to the destination
cp "$lastrunfn" "$errlogfn" "$scriptDirOnDest"
rm "$logfn"
