wb_path = File.join(XlsxFilesPath, 'test.xlsx')

describe Xlsx2Mysql::XlsxController do
  res = relatives do 
    excel do 
      path wb_path
      worksheet 'Sheet2'
    end
  end

  it "cell's value" do  
    expect(res.xlsx_ref.at_cell('B3')).to eql('B3')  
  end
end