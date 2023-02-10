class XlsxParser
  
  def initialize(doc_name, worksheet_name)
    @worksheet_name = worksheet_name
    @doc = SimpleXlsxReader.open(doc_name)
    @worksheet = @doc.sheets[find_worksheet_index]
    @data = @worksheet.rows.slurp
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

  def cell_value(index)
    if /(?<col>[A-Z]+)(?<row>\d+)/.match(index)
      col = $1
      row = $2.to_i
    else
      raise IndexError, 'Unsupported format of index of cell'
    end
    return nil unless @data[row - 1]
    @data[row - 1][letter_to_number(col)]
  end

  def letter_to_number(letter)
    number = -1
    ('A'..letter).each{number += 1}
    number
  end

end

if __FILE__ == $0
  wb_name = 'doc/xlsx_parser.xlsx'
  ws_name = 'nil'
  ws = XlsxParser.new(wb_name, ws_name)
end