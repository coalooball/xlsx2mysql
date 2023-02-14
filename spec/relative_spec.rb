describe Xlsx2Mysql::Relative do
  res = relatives do 
    mysql do 
      user 'core'
      password '123456'
      host 'xxx.xxx.xxx.80'
      port '3306'
      database 'xxxxxx'
      table 'xxxxx'
    end
  
    excel do 
      path 'xxxx.xlsx'
    end
  
    associate do 
      R_TYPE 1
    end
  end

  it "mysql configuration" do  
    expect(res.mysql_ref.host).to eql('xxx.xxx.xxx.80')  
  end

  it "excel configuration" do  
    expect(res.xlsx_ref.path).to eql('123.xlsx')  
  end
  
  it "excel configuration" do  
    expect(res.fields_hash['R_TYPE']).to eql(1)  
  end
end