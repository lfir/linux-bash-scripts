# Linux-Bash-Scripts

This repository contains a collection of small and useful (at least to me :P) Bash scripts organized in
subdirectories of a central project, for easy referencing and usage as templates for other programs.

## Scripts

### 1. VSCode Tarball Updater

Automatically updates VSCode for Linux by downloading the latest release from the
official website and replacing the current installation.

**Features**
- Checks if the latest VSCode version available is newer than the existing one
- Clean and safe replacement of the application directory (preserves existing
installation as backup during update process)

**Files**
- `vscode-tarball-updater.sh`: Run as non-root, with env var _appParentDir_

**Notes**

- VSCode's current dir name (_appDir_ variable) == name of the dir
that comes within the downloadable tarballs (i.e. _VSCode-linux-x64_)

**Dependencies**
- `wget`

### 2. System resources monitor

Alerts via email if the system is overloaded; to be used as a cron job.

**Features**
- Checks if CPU, Memory and/or Disk usage is over a certain threshold
- Notifies via email if any resource is above alert levels

**Files**
- `monitor-resources`: Runs as root

**Dependencies**
- `postfix` (or some other SMTP server)
- `mail`

### 3. Rclone Backup

Cron job that creates a remote backup using `tar` and `rclone`.

**Features**
- Saves execution results in a standard log file
- Reads backup targets from an external config file

**Files**
- `rclone-backup`: Runs as root, needs env vars _backupTargets_, _username_ and _remotePath_
- `targets.txt`: Full path of directories and files to back up

**Dependencies**
- `rclone`

### 4. Rsync Backup

Backup script using rsync with exclusion patterns for efficient system backups.

**Features**
- Excludes cache files, temporary files, and other non-essential data in home dirs
- Keeps track of backup dates and errors

**Files**
- `rsync-backup.sh`: Run as root or non-root (depending on the permissions of files that need to be backed up),
passing env vars _scriptDirOnDest_ and _username_ 
- `excluded.txt`: Directories and files to exclude from backup, mainly the list from this [repo](https://github.com/rubo77/rsync-homedir-excludes)

**Notes**
- ACLs and Selinux context of files is preserved (but not hard links or extended attributes)

**Dependencies**
- `rsync`

### 5. Ngrok Agent Admin

Starts a ngrok agent for creating an HTTP tunnel, saving the public URL to a JSON file and committing it to a git repository.

**Features**
- Retrieves the public tunnel URL and saves it to a JSON file
- Commits and pushes the changes to a remote repository

**Files**
- `start-agent.sh`: Main script that manages the ngrok agent, run as non-root
- `tunnel-url.json`: JSON file containing the public URL

**Dependencies**
- `ngrok`
- `git`
