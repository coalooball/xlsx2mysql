class MysqlController
  attr_accessor :host, :port, :user, :password, :database, :charset

  def connect(db_info_path, env)
    mysql_url = "mysql://#{user}:#{password}@#{host}:#{port}/#{database}?charset=#{charset}"
    @my = Mysql.connect(mysql_url)
  end

  def describe_table(table)
    @my.query("DESCRIBE #{table}").entries
  end

  def insert_one_record(table, key_values)
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