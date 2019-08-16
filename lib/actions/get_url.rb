class GetUrlAction

    def initialize(repository,formatter)
        @repository = repository
        @formatter = formatter
     end

    def execute(token)
        id = @formatter.parse(token)
        url = @repository.get(id)
    end

end