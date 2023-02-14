module Xlsx2Mysql
  class Column
    attr_accessor :name, :regexp

    def initialize(name, regexp = /(.*)/)
      @name = name
      @regexp = regexp
    end

    def + other_column
      Columns.new(self, other_column)
    end
  end

  class Columns
    attr_accessor :columns

    def initialize *args
      @columns = args
    end

    def + x
      columns << x
      self
    end
  end
end