require 'mysql'
require 'yaml'

CONFIG_PATH = 'config'
DB_INFO_PATH = File.join(CONFIG_PATH, 'db_info.yml')

class MysqlController

  def initialize(env)
    yaml_data = YAML.load(File.open(DB_INFO_PATH))
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

  def generate_table_yaml(table, overwrite = false)
    table_yaml_path = File.join(CONFIG_PATH, "#{table}.yml")
    table_info_hash = {}
    describe_table(table).each do |record|
      field = record[0]
      type = record[1]
      null = record[2]
      key = record[3]
      default = record[4]
      extra = record[5]
      table_info_hash[field] = {}
      # table_info_hash[field]["type"] = type
      # table_info_hash[field]["default"] = default
      table_info_hash[field]["column"] = nil
      table_info_hash[field]["regexp"] = nil
    end
    unless overwrite
      if File.exist?(table_yaml_path)
        puts "#{table_yaml_path} exists."
        return nil
      end
    end
    File.open(table_yaml_path, 'w') do |f|
      f.write(table_info_hash.to_yaml)
    end
    nil
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

if __FILE__ == $0
  my = MysqlController.new('APB-DEV')
  # my.generate_table_yaml('dmtlnbcd', true)
  my.insert_one_record('dmtlnbcd', {'ROW' => '1'})
end