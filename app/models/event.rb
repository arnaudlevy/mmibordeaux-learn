# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  date        :date
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#  course_id   :integer
#

class Event < ApplicationRecord
  belongs_to :course
  has_and_belongs_to_many :promotions
  has_and_belongs_to_many :teachers, class_name: 'Student'

  default_scope { order(:date) }

  def past?
    date < Date.today
  end

  def to_s
    "#{name}"
  end
end
