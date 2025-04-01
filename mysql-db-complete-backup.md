# Complete MySQL Database Backup in Ubuntu Before Deletion

Before deleting your MySQL server, it's crucial to take a comprehensive backup that includes all databases, stored procedures, functions, triggers, and events. This guide provides the exact commands you need to perform a full MySQL backup in Ubuntu.

## The Complete Backup Command

The most thorough way to back up your entire MySQL installation is to use the following command:

```bash
mysqldump --all-databases --single-transaction --routines --triggers --events --hex-blob --default-character-set=utf8mb4 -u root -p > complete_mysql_backup.sql
```

When you run this command, you'll be prompted for your MySQL root password. This approach ensures you capture everything in your MySQL server, including:

- All database structures and data
- Stored procedures and functions
- Triggers
- Events
- With proper character encoding support[8][10][13]

## Understanding the Backup Parameters

Each parameter in the backup command serves a specific purpose:

- **--all-databases**: Backs up every database on your MySQL server[3][8]
- **--single-transaction**: Creates a consistent backup without locking tables (ideal for InnoDB)[8]
- **--routines**: Includes all stored procedures and functions (disabled by default)[2][4][13]
- **--triggers**: Includes all triggers (enabled by default, but explicitly included for clarity)[2][13]
- **--events**: Includes all scheduled events[10][13]
- **--hex-blob**: Handles binary data properly[10]
- **--default-character-set=utf8mb4**: Uses proper character encoding for international characters[10]

## Creating a Compressed Backup

If your databases are large, you might want to compress the backup to save space:

```bash
mysqldump --all-databases --single-transaction --routines --triggers --events -u root -p | gzip > complete_mysql_backup.sql.gz
```

This pipes the output through gzip to create a compressed file[3][11][13].

## Verifying Your Backup

Before proceeding with MySQL server deletion, it's prudent to verify that your backup contains all the necessary components:

```bash
head -n 50 complete_mysql_backup.sql
grep "CREATE PROCEDURE" complete_mysql_backup.sql | wc -l
grep "CREATE FUNCTION" complete_mysql_backup.sql | wc -l
grep "CREATE TRIGGER" complete_mysql_backup.sql | wc -l
```

These commands will show you the beginning of the backup file and count how many procedures, functions, and triggers were backed up[6].

## Restoring from Backup Later

When you need to restore your databases on a new MySQL installation, use:

```bash
mysql -u root -p < complete_mysql_backup.sql
```

For compressed backups:

```bash
gunzip < complete_mysql_backup.sql.gz | mysql -u root -p
```

These commands will recreate all your databases with their data and associated objects[1][3][9].

## Important Notes and Considerations

1. The backup process might take considerable time if you have large databases.
2. The mysqldump utility doesn't back up the INFORMATION_SCHEMA or performance_schema databases by default[8].
3. Ensure you have sufficient disk space for the backup file.
4. Store your backup in a secure location, preferably off the server you're about to delete.
5. The restoration process might be lengthy for large databases[3].

By following these steps, you'll have a complete backup of your MySQL environment that can be restored on any compatible MySQL server installation.

Citations:
[1] https://mycode.blog/lakshmi/how-backup-and-restore-mysql-databases-ubuntu
[2] https://sqlconjuror.com/mysql-backing-stored-procedures-functions-triggers/
[3] https://www.sqlshack.com/how-to-backup-and-restore-mysql-databases-using-the-mysqldump-command/
[4] https://stackoverflow.com/questions/5075198/export-mysql-database-with-triggers-and-procedures
[5] https://manpages.ubuntu.com/manpages/bionic/man1/mysqldump.1.html
[6] https://dba.stackexchange.com/questions/4086/dump-only-the-stored-procedures-in-mysql
[7] https://www.rosehosting.com/blog/how-to-create-a-backup-of-mysql-databases-using-mysqldump-on-ubuntu-20-04/
[8] https://dev.mysql.com/blog-archive/creating-and-restoring-database-backups-with-mysqldump-and-mysql-enterprise-backup-part-1-of-2/
[9] https://sectigostore.com/page/how-to-backup-mysql-database-on-linux-ubuntu/
[10] https://sqlbak.com/blog/mysql-from-dumps-to-restores/
[11] https://stackoverflow.com/questions/13484667/export-mysql-dump-from-command-line
[12] https://manpages.ubuntu.com/manpages/trusty/man1/mysqldump.1.html
[13] https://hostman.com/tutorials/mysql-backup/
[14] https://www.digitalocean.com/community/tutorials/how-to-backup-mysql-databases-on-an-ubuntu-vps
[15] https://dev.mysql.com/doc/en/mysqldump.html
[16] https://askubuntu.com/questions/43830/how-can-i-export-mysql-database-manually-without-phpmyadmin
[17] https://simplebackups.com/blog/the-complete-mysqldump-guide-with-examples/

---
Answer from Perplexity: pplx.ai/share
