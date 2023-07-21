module Types
  class QueryType < Types::BaseObject

    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :create_repository, Types::RepositoryType, null: false do
      argument :username, ID, required: true
    end

    field :call, Types::RepositoryType, null: true do
      argument :username ,ID, required: true
    end
 
    BASE_URL = 'https://api.github.com'

    def call(username:)
      user_hash = { "username" => username }
      user_avatar_url = nil
      username = user_hash["username"]
      repo_hash = collect_repo_info(username:).map.with_index(1) do |repo, index|
        user_avatar_url = repo['owner']['avatar_url'] || repo['owner']['gravatar_url']
        {
          id: index,
          title: repo['name'],
          language: repo['language'],
          url: repo['html_url']
        }
      end
    
      repo_hash.each do |hash|
        hash["username"] = username
      end
    
      puts "repo_hash: #{repo_hash.inspect}"
      create_repository(repo_hash:)
      update_user_avatar(user_avatar_url:) if user_avatar_url
      repo_hash.each do |repo|
        id = repo[:id]
        title = repo[:title]
        language = repo[:language]
        url = repo[:url]

      puts "Repository ID: #{id}"
      puts "Title: #{title}"
      puts "Language: #{language}"
      puts "URL: #{url}"
      puts "-----------------------"
    end

    end
    

    def collect_repo_info(username:)
      url = BASE_URL + "/users/#{username}/repos"
      response = HTTParty.get(url)
      JSON.parse(response.body)
    end
 
    def create_repository(repo_hash:)
      @user = User.find_by(username: repo_hash.first['username'])
      repo_hash.each do |data|
        repo = @user.repositories.find_or_create_by(title: data[:title])
        repo.update(language: data[:language], url: data[:url])
        repo.save!
      end
    end

    def update_user_avatar(user_avatar_url:)
      @user.update(user_avatar_url: user_avatar_url)
    end

  end
end





