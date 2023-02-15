module Xlsx2Mysql
  class MysqlController
    include Configurable.with(
      :host, :port, :user, :password, :database, :charset, :table
    )
    
    def initialize
      @charset = 'utf8mb4'
      @port = '3306'
    end

    def acquire_table_fields
      describe_table.map {|x| x[0]}
    end
    
    def insert_one_record(key_values)
      connect unless @my
      raise "MySQL is not connected!" unless @my
      keys = []
      values = []
      question_marks = []
      key_values.each do |key, value|
        keys << key
        question_marks << '?'
        values << value
      end
      keys.map! {|x| '`'+ x + '`'}
      sql =<<SQL
INSERT INTO #{table}
(#{keys.join(',')})
VALUES
(#{question_marks.join(',')});
SQL
@my.prepare(sql).execute(*values)
    end

    private

    def describe_table
      connect unless @my
      raise "MySQL is not connected!" unless @my
      @my.query("DESCRIBE #{table}").entries
    end

    def connect
      mysql_url = "mysql://#{user}:#{password}@#{host}:#{port}/#{database}?charset=#{charset}"
      @my = Mysql.connect(mysql_url)
    end
  end
end