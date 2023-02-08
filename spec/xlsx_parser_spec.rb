$: << File.expand_path('../../lib', __FILE__)

doc_path = File.expand_path('../../doc', __FILE__)

xlsx_parser_path = File.join(doc_path, 'xlsx_parser.xlsx')

require 'rspec/autorun'
require 'xlsx_parser'

describe XlsxParser do

  it "finds the index of worksheet Sheet2" do  
    doc = XlsxParser.new(xlsx_parser_path, 'Sheet2')
    expect(doc.find_worksheet_index).to eq(1)
  end

  xit "raise Error when not found index of worksheet" do
    doc = XlsxParser.new(xlsx_parser_path, 'NULL')
    expect{doc.find_worksheet_index}.to raise_error(RangeError)
  end

end