class Mutations::CreateUser < Mutations::BaseMutation
  argument :username, String, required: true
  argument :repositories_count, Integer, required: true
  field :user, Types::UserType, null: false
  field :errors, [String], null: false

    def resolve(username:, repositories_count:)
      before_create(username:)
      user = User.new(username: username, repositories_count: repositories_count)
  
      if user.save
        { user: user, errors: [] }
      else
        { user: nil, errors: user.errors.full_messages }
      end
    end
  end
  
  def find_user_and_validate_github(username:)
    context = self.context
    url = "https://api.github.com/users/#{username}/repos"
    response = HTTParty.get(url)
    if response.code != 200
      raise GraphQL::ExecutionError, 'User not found on GitHub'
    end
end