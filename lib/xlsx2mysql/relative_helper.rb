def relatives(name = nil, &block)
  Xlsx2Mysql::Relative.new(name, &block)
end