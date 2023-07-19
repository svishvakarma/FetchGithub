class Mutations::CreateUser < Mutations::BaseMutation
    argument :username, String, required: true
    argument :repositories_count, Integer, required: true
  
    field :user, Types::UserType, null: false
    field :errors, [String], null: false
  
    def resolve(username:, repositories_count:)
      user = User.new(username: username, repositories_count: repositories_count)
  
      if user.save
        { user: user, errors: [] }
      else
        { user: nil, errors: user.errors.full_messages }
      end
    end
  end