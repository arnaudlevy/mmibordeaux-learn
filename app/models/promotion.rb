# == Schema Information
#
# Table name: promotions
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  year       :integer
#

class Promotion < ApplicationRecord
  has_many :students
  validates :name, presence: true
  has_and_belongs_to_many :events
  has_many :courses

  default_scope { order :name }

  include Codeschool
  include Codecademy

  def students_csv
  end

  def students_csv=(value)
    require 'csv'
    value = value.gsub(';', ',')
    CSV.parse(value).each do |row|
      firstname = row[0]
      lastname = row[1]
      email = row[2]
      password = row[3]
      unless Student.where(email: email).exists?
        Student.create( email: email,
                        firstname: firstname,
                        lastname: lastname,
                        password: password,
                        promotion_id: id)
      end
    end
  end

  def average_note
    students.average(:note)
  end

  def sync_courses!
    uri = URI teach_api_url
    response = Net::HTTP.get uri
    data = JSON.parse response
    data['projects'].each do |project|
      project_id = project['id'].to_i
      course = Course.where(teach_project_id: project_id, promotion_id: id).first_or_initialize
      course.name = project['label']
      course.description = project['description']
      course.starting_at = project['start_date']
      course.save
    end
  end

  def to_s
    "#{name}"
  end

  protected

  def teach_api_url
    "http://teach.mmibordeaux.com/api/promotions/#{year}"
  end
end
