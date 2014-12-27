class Record < ActiveRecord::Base
  belongs_to :task
  attr_accessible :completed, :weight
end
