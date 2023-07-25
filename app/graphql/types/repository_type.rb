# frozen_string_literal: true

module Types
  class RepositoryType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :language, String
    field :url, String
    field :user_id, Integer
    field :user, Types::UserType, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

  end
end




