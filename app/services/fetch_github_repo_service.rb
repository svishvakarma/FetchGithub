class FetchGithubRepoService #< ApplicationService 
  attr_accessor :username
  def initialize (username:)
    @username = username
  end

end
