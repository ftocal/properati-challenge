class GetTokenAction

    def initialize(repository,formatter)
        @repository = repository
        @formatter = formatter
     end

    def execute(url)
        if !self.isValid(url)
            raise ArgumentError.new('Invalid url: ' + url)
        end
        id = @repository.save(url)
        token = @formatter.format(id)
    end

    def isValid(url)
        uri = URI.parse(url)
        uri.is_a?(URI::HTTP) && !uri.host.nil?
      rescue URI::InvalidURIError
        false
    end
end