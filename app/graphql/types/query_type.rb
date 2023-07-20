module Types
  
  class QueryType < Types::BaseObject

    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :find_user_and_validate_github,
          String,
          null: false,
    description: "Find a user in the database and validate their GitHub profile" do 
          argument :username, String, required: true
        end

    def find_user_and_validate_github(username:)
      context = self.context
      errors = context.errors
      url = "https://api.github.com/users/#{username}/repos"
      response = HTTParty.get(url)
      if response.code != 200
        raise GraphQL::ExecutionError, 'User not found on GitHub'
      end
      "User found on GitHub"
      true
    end
  end
end
