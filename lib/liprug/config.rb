module Liprug
  class Config
    def self.[] index
      ENV[index]
    end
  end
end
