module Xlsx2Mysql
  class XlsxController
    include Configurable.with(:path, :worksheet)
  end
end