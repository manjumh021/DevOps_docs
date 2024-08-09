To check which service or application is consuming the most space on your Ubuntu system, you can use a combination of built-in commands and tools. Here's a step-by-step guide:

### 1. Check Disk Usage with `du`
The `du` (disk usage) command summarizes disk usage of each file and directory.

**Basic command:**
```sh
sudo du -sh /*
```
This command will show the disk usage of directories at the root level.

**Check a specific directory:**
```sh
sudo du -sh /var/*
```
This command will show the disk usage of directories within `/var`.

### 2. Check Disk Usage with `ncdu`
`ncdu` is an interactive command-line tool for exploring disk usage.

**Install `ncdu`:**
```sh
sudo apt-get install ncdu
```

**Run `ncdu`:**
```sh
sudo ncdu /
```
Use the arrow keys to navigate through the directories and see their sizes.

### 3. Check Disk Usage with `df`
The `df` (disk free) command displays the amount of disk space available on the filesystem.

**Basic command:**
```sh
df -h
```
This shows the disk usage of all mounted filesystems in a human-readable format.

### 4. Using `du` with Sorting
You can combine `du` with `sort` to find the largest directories/files.

**Find the top 10 largest directories in `/var`:**
```sh
sudo du -ah /var | sort -rh | head -n 10
```

### 5. Using `find` to Identify Large Files
To find the largest files, you can use the `find` command:

**Find files larger than 100MB:**
```sh
sudo find / -type f -size +100M -exec ls -lh {} \; | awk '{ print $NF ": " $5 }'
```

### 6. Using System Analysis Tools
Tools like `htop` can help you identify services that are consuming significant resources, although not disk space specifically.

**Install `htop`:**
```sh
sudo apt-get install htop
```

**Run `htop`:**
```sh
htop
```
In `htop`, you can see memory and CPU usage which can indirectly help you identify heavy applications.

### 7. Analyze Specific Directories
Common directories that might consume a lot of space include `/var`, `/home`, `/tmp`, and `/usr`.

**Analyze `/var`:**
```sh
sudo du -sh /var/*
```

**Analyze `/home`:**
```sh
sudo du -sh /home/*
```

By using these commands and tools, you can identify which services or applications are consuming the most space on your Ubuntu system.