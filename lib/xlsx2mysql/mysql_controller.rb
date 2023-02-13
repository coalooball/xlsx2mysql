class MysqlController

  def initialize(db_info_path, env)
    yaml_data = YAML.load(File.open(db_info_path))
    host = yaml_data[env]["host"]
    port = yaml_data[env]["port"] || 3306
    user = yaml_data[env]["user"]
    password = yaml_data[env]["password"]
    database = yaml_data[env]["database"]
    charset = yaml_data[env]["charset"] || 'utf8mb4'
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