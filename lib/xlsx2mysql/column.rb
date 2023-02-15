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

    def retrieve_value row_index, ws
      index = name.to_s + row_index.to_s
      regexp.match(ws[index])
      $1
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

    def retrieve_value row_index, ws
      res_array = []
      columns.each do |x|
        if x.is_a?(Column)
          res_array << x.retrieve_value(row_index, ws)
        elsif x.is_a?(String)
          res_array << x
        else
        end
      end
      res_array.join
    end
  end
end