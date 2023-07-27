class Mutations::UpdateUser < Mutations::BaseMutation
    argument :username, String, required: true
    argument :repositories_count, Integer, required: true
    field :user, Types::UserType, null: false
    field :errors, [String], null: false
    field :update_user,Types::UserType , null: false do
      argument :username, ID, String, required: true
    end
  

    def resolve(username:, repositories_count:)
      user =  User.find_by(username: username)
      user.update(username: username, repositories_count: repositories_count)
      if user.present?
        { user: user, errors: [] }
      else
        { user: nil, errors: user.errors.full_messages }
      end
    end
end