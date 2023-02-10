Gem::Specification.new do |s|
  s.name        = "xlsx2mysql"
  s.version     = "0.0.0"
  s.summary     = "A simple data migration gem"
  s.description = "A gem for inserting data to mysql from Excel(xlsx)"
  s.authors     = ["Cyan Yan"]
  s.email       = "cyan_cg@outlook.com"
  s.files       = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec)/})}.select { |f| f.match /\.rb$/}
  s.homepage    = "https://rubygems.org/gems/xlsx2mysql"
  s.license     = "MIT"
end