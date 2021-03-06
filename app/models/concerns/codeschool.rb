module Codeschool
  extend ActiveSupport::Concern

  def codeschool_badges
    codeschool_results['badges'] if codeschool_results?
  end

  def codeschool_score
    if is_a? Student
      if codeschool_results?
        codeschool_results['user']['total_score'].to_i
      else
        0
      end
    elsif is_a? Promotion
      score = 0
      students.each do |s| 
        score += s.codeschool_score
      end
      score
    end 
  end

  def codeschool_validated?(title)
    return false if codeschool_data.nil? or codeschool_data.empty?
    codeschool_data.include? title
  end

  def codeschool_results?
    not codeschool_results.nil?
  end

  def codeschool_results
    begin
      @codeschool_results ||= JSON.parse(codeschool_data) unless codeschool_data.nil?
    rescue
      nil
    end
  end

  def codeschool_url
    "https://www.codeschool.com/users/#{codeschool}" unless codeschool.nil?
  end

  def codeschool_json_url
    "#{codeschool_url}.json"
  end

  def codeschool_sync!
    begin
      require 'open-uri'
      require 'json'
      data = open(codeschool_json_url).read
      update_column :codeschool_data, data
    rescue
    end
  end  
end
