class Task < ActiveRecord::Base
  belongs_to :user
  has_many :records
  attr_accessible :frequency, :message, :reminder_time, :reminder_type
end
