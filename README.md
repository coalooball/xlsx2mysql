# xlsx2mysql
A gem for inserting data to mysql from Excel(xlsx)

### Example 
```ruby
require 'xlsx2mysql'

relatives do 
  mysql do 
    user 'xxxx'
    password '123456'
    host 'xxx.xxx.xxx.xxx'
    port '3306'
    database 'xxxx'
    table 'xxxxxx'
  end

  excel do 
    path 'xxxx.xlsx'
    worksheet 'Sheet1'
  end

  associate do 
    ROW A
    PRDCP B
  end
end
```