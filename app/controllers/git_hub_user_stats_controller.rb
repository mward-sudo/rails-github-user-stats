class GitHubUserStatsController < ApplicationController
  def index
    gitHubUser = GitHubUserStat.new params[:username]

    if gitHubUser.error.nil?
      @user = gitHubUser.user
      @repos = gitHubUser.repos
      @stars = gitHubUser.stars
      @commits_total = gitHubUser.commits_total
      @commits_per_week = gitHubUser.commits_per_week
    end
    @error = gitHubUser.error
  end
end
