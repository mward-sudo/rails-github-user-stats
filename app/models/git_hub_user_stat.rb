require "octokit"

class GitHubUserStat
  include ActiveModel::Model

  attr_accessor :repos, :user, :stars, :errors, :commits_total

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

  def commits_total
    @repos.sum { |repo|
      repo.rels[:commits].get.data.count
    }
  end

  # Function to build an array showing the number of GitHub commits per week for the last 52 weeks
  def commits_per_week
    commits_per_week = Array.new(52, 0)
    @repos.each { |repo|
      repo.rels[:commits].get.data.each { |commit|
        # Convert date to a date object
        puts commit.commit.author.date
        date = commit.commit.author.date.to_date

        # Convert date to a week number
        week_number = date.cweek

        # Add one to the commits for the week
        commits_per_week[week_number - 1] += 1
      }
    }

    commits_per_week
  end

  def user
    @github_user
  end

  def stars
    @repos.sum { |repo| repo.stargazers_count }
  end

  def error
    @error
  end
end
