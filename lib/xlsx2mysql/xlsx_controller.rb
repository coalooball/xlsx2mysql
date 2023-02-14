module Xlsx2Mysql
  class XlsxController
    include Configurable.with(:path, :worksheet, :row_begin, :row_end)

    def at_cell index
      load unless @ws
      @ws[index]
    end

    def max_row
      load unless @ws
      @ws.max_row.to_i
    end
    
    def ws
      load unless @ws
      @ws
    end

    private

    def load
      wb = OpenXML::SpreadsheetML::open path
      @ws = wb[worksheet]
    end
  end
end