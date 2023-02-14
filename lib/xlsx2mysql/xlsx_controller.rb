module Xlsx2Mysql
  class XlsxController
    include Configurable.with(:path, :worksheet, :row_begin, :row_end)

    def at_cell index
      load unless @ws
      @ws[index]
    end

    private

    def load
      wb = OpenXML::SpreadsheetML::open path
      @ws = wb[worksheet]
    end
  end
end