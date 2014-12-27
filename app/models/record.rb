class Record < ActiveRecord::Base
  belongs_to :task
  accepts_nested_attributes_for :task, allow_destroy: true
  attr_accessible :completed, :weight, :id, :task_id, :created_at
end
