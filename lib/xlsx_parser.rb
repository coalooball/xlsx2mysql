require 'simple_xlsx_reader'

class XlsxParser
  
  def initialize(doc_name, worksheet_name)
    @worksheet_name = worksheet_name
    @doc = SimpleXlsxReader.open(doc_name)
    @worksheet = @doc.sheets[find_worksheet_index]
    p @worksheet.rows.slurp
  end

  def find_worksheet_index
    index = 0
    @doc.sheets.each do |sheet|
      break if sheet.name =~ /^#{@worksheet_name}$/
      index += 1
    end
    raise RangeError, 'not found Excel sheets' if index + 1 > @doc.sheets.size
    index
  end

end

if __FILE__ == $0
  wb_name = 'spec.xlsx'
  ws_name = 'nil'
  ws = XlsxParser.new(wb_name, ws_name)
end