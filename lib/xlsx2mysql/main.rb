module Xlsx2Mysql
  class << self
    def mysql
      @mysql ||= MysqlController.new
    end

    def configure_mysql
      yield mysql
    end

    def xlsx
      @xlsx ||= XlsxController.new
    end

    def configure_xlsx
      yield xlsx
    end

    def relatives(&block)
      instance_eval(&block)
    end
  end
end