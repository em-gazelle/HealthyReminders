class Task < ActiveRecord::Base
  belongs_to :user
  has_many :records

  accepts_nested_attributes_for :records, allow_destroy: true
  accepts_nested_attributes_for :user
  attr_accessible :frequency, :message, :reminder_time, :reminder_type, :id, :user_id
end
