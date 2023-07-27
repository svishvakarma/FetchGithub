require 'rails_helper'

RSpec.describe Types::QueryType do
  let(:schema) { FetchGithubSchema }
  let(:username) { 'svishvakarma' }
  
	it 'has a create_repository field' do
    expect(schema.query.fields['createRepository']).not_to be_nil
  end

  it 'has a call field' do
    expect(schema.query.fields['call']).not_to be_nil
  end

  context 'when calling the call field' do
    it 'calls the correct methods' do
      query_string = <<~GRAPHQL
        query($username: ID!) {
          call(username: $username) {
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

			expected_result2 =   
			{
				"id"=>"1", "title"=>"Blog-Article-TestCase", "language"=>"Ruby", "watchers"=>0, "defaultBranch"=>"main", "url"=>"https://github.com/svishvakarma/Blog-Article-TestCase", "cloneUrl"=>"https://github.com/svishvakarma/Blog-Article-TestCase.git"
			}
			expect(result['data']['call'].first).to eq(expected_result2)
    end
  end
end
