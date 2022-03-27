require "octokit"

class GitHubUserStat
  include ActiveModel::Model

  attr_accessor :repos, :repos_total, :username, :stars

  def initialize(username)
    github_client = Octokit::Client.new(:access_token => Rails.application.credentials.github_api_key)

    @github_user = github_client.user username
    @repos = @github_user.rels[:repos].get.data
  end

  def repos
    @repos
  end

  def username
    @github_user.login
  end

  def stars
    @repos.sum do |repo| repo.stargazers_count end
  end
end
