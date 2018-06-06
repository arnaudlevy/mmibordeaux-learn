# == Schema Information
#
# Table name: students
#
#  id                                :integer          not null, primary key
#  firstname                         :string(255)
#  lastname                          :string(255)
#  codeschool                        :string(255)
#  codecademy                        :string(255)
#  promotion_id                      :integer
#  created_at                        :datetime
#  updated_at                        :datetime
#  codeschool_data                   :text
#  codecademy_data                   :text
#  codecademy_badges                 :text
#  note                              :float
#  email                             :string(255)      default(""), not null
#  encrypted_password                :string(255)      default(""), not null
#  reset_password_token              :string(255)
#  reset_password_sent_at            :datetime
#  remember_created_at               :datetime
#  sign_in_count                     :integer          default(0), not null
#  current_sign_in_at                :datetime
#  last_sign_in_at                   :datetime
#  current_sign_in_ip                :string(255)
#  last_sign_in_ip                   :string(255)
#  github_identifier                 :string(255)
#  github_repository                 :string(255)
#  heroku_app                        :string(255)
#  admin                             :boolean          default(FALSE)
#  pluralsight                       :string
#  pluralsight_data                  :text
#  pluralsight_uuid                  :string
#  pluralsight_data_completedcourses :text
#

require 'test_helper'

class StudentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
