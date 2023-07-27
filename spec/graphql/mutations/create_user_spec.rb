require 'rails_helper'

RSpec.describe Mutations::CreateUser do
 let(:username) { 'svishwakarma' }
 let(:repositories_count) { 10 }

  it 'creates a new user with valid credentials' do
    context = { object: nil, context: { current_user: nil }, field: nil }
    result = Mutations::CreateUser.new(object: nil, field: nil, context: context).resolve(username: username, repositories_count: repositories_count)
    expect(result[:user].username).to eq(username)
    expect(result[:user].repositories_count).to eq(repositories_count)
    expect(result[:errors]).to be_empty
  end
end




