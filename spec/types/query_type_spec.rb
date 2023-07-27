require 'rails_helper'

RSpec.describe Types::QueryType do
  let(:schema) { FetchGithubSchema }
  let(:username) { 'svishvakarma' }
  
  context 'when calling the call field' do
    it 'calls the correct methods' do
      query_string = <<~GRAPHQL
        query($username: ID!) {
          getRepo(username: $username) {
            id
            title
            language
            watchers
            defaultBranch
            url
            cloneUrl
          }
        }
      GRAPHQL
      result = schema.execute(query_string, variables: { username: username })
      byebug
      expected_result2 =   
      {
        "id"=>"1", "title"=>"Blog-Article-TestCase", "language"=>"Ruby", "watchers"=>0, "defaultBranch"=>"main", "url"=>"https://github.com/svishvakarma/Blog-Article-TestCase", "cloneUrl"=>"https://github.com/svishvakarma/Blog-Article-TestCase.git"
      }
      expect(result['data']['getRepo'].first).to eq(expected_result2)
    end
  end
end