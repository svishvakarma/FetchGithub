# frozen_string_literal: true

module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :username, String
    field :repositories_count, Integer
    field :avatar, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :repositories, [Types::RepositoryType], null: false

    def repositories
      object.repositories
    end
  end
end
