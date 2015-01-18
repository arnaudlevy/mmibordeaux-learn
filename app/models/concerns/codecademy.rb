module Codecademy
  extend ActiveSupport::Concern

  def codecademy_url
    "http://www.codecademy.com/fr/#{codecademy}"
  end

  def codecademy_badges_url
    "http://www.codecademy.com/fr/users/#{codecademy}/achievements"
  end

  def codecademy_html
    Nokogiri::HTML(codecademy_data) 
  end

  def codecademy_badges_html
    Nokogiri::HTML(self.codecademy_badges) # TODO codecademy_badges_data
  end

  def codecademy_score
    if is_a? Student
      if codecademy_data.nil?
        0
      else
        score_object = codecademy_html.css('h3.padding-right--quarter').first
        if score_object.nil?
          0
        else
          score_object.text.to_i
        end
      end
    elsif is_a? Promotion
      score = 0
      students.each do |s| 
        score += s.codecademy_score
      end
      score
    end
  end

  def codecademy_skills
    codecademy_html.css('#completed h5') unless codecademy_data.nil?
  end

  # TODO rename the db field badges_data
  def codecademy_badges_list
    codecademy_badges_html.css('.achievements h5') unless codecademy_data.nil?
  end

  def codecademy_note
    if codecademy_score.nil?
      0
    else
      Note.make(codecademy_score, [[8000, 8], [7000, 14], [20000, 20]])
    end
  end

  def codecademy_sync!
    begin
      require 'open-uri'
      self.codecademy_data = open(codecademy_url).read.html_safe
      self.codecademy_badges = open(codecademy_badges_url).read.html_safe
      self.save
    rescue
    end
  end
  
end