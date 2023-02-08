require 'simple_xlsx_reader'

class XlsxParser
  
  def initialize(doc_name, worksheet_name)
    doc = SimpleXlsxReader.open(doc_name)
    @worksheet = doc.sheets[find_worksheet_index(doc.sheets, worksheet_name)]
    p @worksheet.rows.slurp
  end

  def find_worksheet_index(doc_sheets, ws_name)
    index = 0
    doc_sheets.each do |sheet|
      break if sheet.name =~ /^#{ws_name}$/
      index += 1
    end
    raise 'Excel sheets name not found' if index + 1 > doc_sheets.size
    index
  end

end


if __FILE__ == $0
  wb_name = 'spec.xlsx'
  ws_name = 'Sheet1'
  ws = XlsxParser.new(wb_name, ws_name)
end