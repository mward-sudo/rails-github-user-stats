require "octokit"

class GitHubUserStat
  include ActiveModel::Model

  attr_accessor :repos, :user, :stars, :errors

  def initialize(username)
    github_client = Octokit::Client.new(:access_token => Rails.application.credentials.github_api_key)

    begin
      @github_user = github_client.user username
      @repos = @github_user.rels[:repos].get.data
    rescue Octokit::NotFound
      @error = {
        :type => :NotFound,
        :title => "User does not exist",
        :message => "User '#{username}' does not exist",
      }
    end
  end

  def repos
    @repos
  end

  def user
    @github_user
  end

  def stars
    @repos.sum do |repo| repo.stargazers_count end
  end

  def error
    @error
  end
end
