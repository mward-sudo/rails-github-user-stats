class GitHubUserStatsController < ApplicationController
  def index
    gitHubUser = GitHubUserStat.new "michaelward82"

    if gitHubUser.error.nil?
      @user = gitHubUser.user
      @repos = gitHubUser.repos
      @stars = gitHubUser.stars
    end
    @error = gitHubUser.error
  end
end
