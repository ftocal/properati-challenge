class Repository

    def initialize()
        @data = Hash.new
        @index = 1
      end

    def save(url)
        key = @index
        @index += 1
        @data.store(key,url)
        key
    end

    def get(key)
        url = @data[key]
      end
end