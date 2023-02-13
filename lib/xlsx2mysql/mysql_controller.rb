module Xlsx2Mysql
  class MysqlController
    attr_accessor :host, :port, :user, :password, :database, :charset
    def initialize
      @my = nil
    end

    def connect(db_info_path, env)
      mysql_url = "mysql://#{user}:#{password}@#{host}:#{port}/#{database}?charset=#{charset}"
      @my = Mysql.connect(mysql_url)
    end

    def describe_table(table)
      raise "MySQL is not connected!" unless @my
      @my.query("DESCRIBE #{table}").entries
    end
    
    def insert_one_record(table, key_values)
      raise "MySQL is not connected!" unless @my
      keys = []
      values = []
      question_marks = []
      key_values.each do |key, value|
        keys << key
        question_marks << '?'
        values << value
      end
      sql =<<SQL
INSERT INTO #{table}
(#{keys.join(',')})
VALUES
(#{question_marks.join(',')});
SQL
      @my.prepare(sql).execute(*values)
    end
  end
end