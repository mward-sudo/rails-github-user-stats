class GitHubUserStatsController < ApplicationController
  def index
    gitHubUser = GitHubUserStat.new "michaelward82"

    @username = gitHubUser.username
    @repos = gitHubUser.repos
    @stars = gitHubUser.stars
  end
end
