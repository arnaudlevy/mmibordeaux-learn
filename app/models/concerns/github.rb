module Github
  extend ActiveSupport::Concern

  def github_validated?(title)
    case title 
    when 'account_created'
      return false if github_identifier.nil? 
      return false if github_identifier.empty?
      # return false unless account_exists?
      true
    when 'rails_repository_created'
      return false if github_repository.nil? 
      return false if github_repository.empty?
      # return false unless repository_exists?
      # return false unless repository_is_ruby?
      true
    end
  end

  protected

  def account_exists?
    url_exists? "https://github.com/#{github_identifier}"
  end

  def repository_exists?
    url_exists? "https://github.com/#{github_identifier}/#{github_repository}"
  end

  def url_exists?(url)
    begin
      open url
      return true
    rescue
      return false
    end
  end

  def repository_is_ruby?
    url = "https://api.github.com/repos/#{github_identifier}/#{github_repository}/languages"
    begin
      file = open url
    rescue
      return false
    end
    string = file.read
    hash = JSON.parse string
    hash.include? 'Ruby'
  end
end