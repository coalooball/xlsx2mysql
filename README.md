# xlsx2mysql
A gem for inserting data to mysql from Excel(xlsx)

### Example 
```ruby
require 'xlsx2mysql'

# A relatives block have three blocks whick setup infomations of MySQL & Excel and relationship between Table(MySQL DB) and Sheet(Excel).
relatives do 
  mysql do # Configure MySQL information to specify the Table you want to insert.
    user 'xxxx'
    password '123456'
    host 'xxx.xxx.xxx.xxx'
    port '3306'
    database 'xxxx'
    table 'xxxxxx'
  end

  excel do # Configure Excel information to specify the worksheet inserting data to the MySQL's Table.
    path 'xxxx.xlsx'
    worksheet 'Sheet1'
  end

  associate do # Configure relationships of Table and Sheet. Lefts are fields(used uppercase) of Table, rights are column index of Sheet.
    FIELD0 A /^(\d+)/                     # Use RegExp to group values. And the default pattern is /(.*)/.
    FIELD1 B, C                           # Specify multiple columns inserted in one field. 
    FIELD2 B, C, D(/^(\d+)/)              # Specify multiple columns inserted in one field, meanwhile using RegExp. 
    DESC   D(/^(\d+)/), '-', E, '-', F    # Plain String is treated as delimiter.
  end
end
```