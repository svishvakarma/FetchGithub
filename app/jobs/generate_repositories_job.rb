class GenerateRepositoriesJob < ApplicationJob 
  queue_as :default

  def perform(username)
    GenerateRepositoriesService.new(username[:username]).call
  end
end 