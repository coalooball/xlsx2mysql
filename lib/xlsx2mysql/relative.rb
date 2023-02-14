module Xlsx2Mysql
  class Relative
    def initialize(name = nil, &block)
      instance_eval(&block)
    end

    def mysql_ref
      @mysql_ref ||= MysqlController.new
    end

    def mysql(&block)
      mysql_ref.configure(&block)
    end

    def xlsx_ref
      @xlsx_ref ||= XlsxController.new
    end

    def xlsx(&block)
      xlsx_ref.configure(&block)
    end

    alias excel xlsx

    def associate(&block)
      instance_eval(&block)
    end
  end
end