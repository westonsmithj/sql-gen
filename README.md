
# SQL Insert Script Generator

This script dynamically generates SQL `INSERT` statements based on a provided SQL template and a dataset. It's designed to streamline the process of creating bulk insert statements for database operations, enhancing productivity and reducing manual coding errors.

## Features

- Reads a multi-line SQL insert statement template.
- Processes a dataset with variable elements for insertion.
- Outputs a complete SQL file with ready-to-execute insert statements.

## Prerequisites

- Bash shell (Unix/Linux/macOS terminal or Windows Subsystem for Linux)
- Basic understanding of SQL and shell scripting

## Installation

No installation is required. Simply download the `insert-statements.sh` script to your local machine.

Ensure the script is executable:

```bash
chmod +x insert-statements.sh
```

## Usage

To use the script, you need two input files:

1. `statement.txt`: Contains your SQL insert statement template. Use placeholders `{0}`, `{1}`, etc., for dynamic content.
2. `data.txt`: Contains the data to insert, with values separated by commas. Each line corresponds to one insert statement.

Run the script with the following syntax:

```bash
./insert-statements.sh statement.txt data.txt -o output.sql
```

### Example

**statement.txt**

```sql
INSERT INTO dba.t_table 
(column1, column2, column3) 
VALUES 
('{0}', '{1}', now());
```

**data.txt**

```
JohnDoe,Admin
JaneDoe,User
```

**Command**

```bash
./insert-statements.sh statement.txt data.txt -o insertsql.sql
```

**insertsql.sql (Output)**

```sql
INSERT INTO dba.t_table (column1, column2, column3) VALUES ('JohnDoe', 'Admin', now());
INSERT INTO dba.t_table (column1, column2, column3) VALUES ('JaneDoe', 'User', now());
```

## Customization

You can customize the `statement.txt` file according to your database schema. The `data.txt` file should be modified to match the placeholders in your SQL template.

## License

This script is provided "as is", without warranty of any kind. You are free to use, modify, and distribute it as you see fit.
