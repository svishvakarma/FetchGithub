class Mutations::CreateRepository < Mutations::BaseMutation
  # argument :title, String, required: true
  # argument :language, String, required: true
  # argument :url, String, required: true
  # argument :user_id, Integer, required: true

  # field :repository, Types::PepositoryType, null: false
  # field :errors, [String], null: false



  # def resolve(title:, language:, url:, user_id:)
  #   repository = User.new(title: title, language: language, url: url, user_id: user_id)

  #   if repository.save
     
  #     { repository: repository, errors: [] }
  #   else
  #     { repository: nil, errors: repository.errors.full_messages }
  #   end
  # end
 
end