module Types
  class QueryType < Types::BaseObject
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :create_repo, Types::RepositoryType, null: false do
      argument :username, ID, required: true
    end

    field :getRepo, [Types::RepositoryType], null: false do
      argument :username ,ID, required: true
    end
 
    BASE_URL = 'https://api.github.com'

    def getRepo(username:)
      user_hash = { "username" => username }
      user_avatar_url = nil
      username = user_hash["username"]
      repo_hash = fetch_information(username:).map.with_index(1) do |repo, index|
        user_avatar_url = repo['owner']['avatar_url'] || repo['owner']['gravatar_url']
        {
          id: index,
          title: repo['name'],
          language: repo['language'],
          url: repo['html_url'],
          username: repo['username'],
          watchers: repo['watchers'],
          clone_url: repo['clone_url'],
          default_branch: repo['default_branch']
        }
      end
    
      repo_hash.each do |hash|
        hash["username"] = username
      end
    
      puts "repo_hash: #{repo_hash.inspect}"
      create_repo(repo_hash:)
      update_user_avatar(user_avatar_url:) if user_avatar_url
      puts find_repo_count(repo_hash:)
      repo_hash
    end
    
    def fetch_information(username:)
      url = BASE_URL + "/users/#{username}/repos"
      response = HTTParty.get(url)
      JSON.parse(response.body)
    end
 
    def create_repo(repo_hash:)
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

    def find_repo_count(repo_hash:)
       repo_hash.size 
    end 

  end
end





