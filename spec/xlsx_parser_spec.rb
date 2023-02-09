$: << File.expand_path('../../lib', __FILE__)

doc_path = File.expand_path('../../doc', __FILE__)

xlsx_parser_path = File.join(doc_path, 'xlsx_parser.xlsx')

require 'rspec/autorun'
require 'xlsx_parser'

describe XlsxParser do

  let(:sheet2) { XlsxParser.new(xlsx_parser_path, 'Sheet2') }

  it "finds the index of worksheet Sheet2" do  
    expect(sheet2.find_worksheet_index).to eq(1)
  end

  xit "raise Error when not found index of worksheet" do
    doc = XlsxParser.new(xlsx_parser_path, 'NULL')
    expect{doc.find_worksheet_index}.to raise_error(RangeError)
  end

  it "Find cell's value according index" do
    expect(sheet2.cell_value("A1")).to eq("123")
    expect(sheet2.cell_value("C3")).to eq("xlsx")
    expect(sheet2.cell_value("I3")).to eq("eudaimonia")
    expect(sheet2.cell_value("B10")).to eq("B10")
    expect(sheet2.cell_value("C117")).to eq("C117")
    expect(sheet2.cell_value("L73")).to eq("L73")
    expect(sheet2.cell_value("BI110")).to eq("BI110")
  end

  it "Convert Excel column letter to number" do 
    expect(sheet2.letter_to_number("A")).to eq(0)
    expect(sheet2.letter_to_number("AA")).to eq(26)
  end

end