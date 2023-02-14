module Xlsx2Mysql
  class Relative
    attr_accessor :fields_hash

    def initialize(name = nil, &block)
      @fields_hash = {}
      instance_eval(&block)
    end

    def mysql_ref
      @mysql_ref ||= MysqlController.new
    end

    def mysql(&block)
      mysql_ref.configure(&block)
      define_methods_with_field_name
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

    def method_missing(name, *args)
      if name =~ /[A-Z]+/
        Column.new(name, args[0])
      else
        super
      end
    end

    def Object.const_missing(name)
      if name =~ /[A-Z]+/
        Column.new(name)
      else
        super
      end
    end

    private

    def define_methods_with_field_name
      mysql_ref.acquire_table_fields.each do |field|
        define_singleton_method field do |column|
          fields_hash[field] = column
        end
      end
    end
  end
end