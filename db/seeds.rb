# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# User 1:
user = User.create(email: "7testing@gmail.com", password: "testing7", password_confirmation: "testing7", id: 7)
user.save!
  task = Task.create(:reminder_type => "Vitamin DD T1", :frequency => "Daily", user_id: 7, id: 5)
  task.save!
    record = Record.create(:completed => "true", :created_at => 2.week.ago.to_date, task_id: 5)
    record.save!
    record = Record.create(:completed => "false", :created_at => 3.week.ago.to_date, task_id: 5)
    record.save!
    record = Record.create(:completed => "true", :created_at => 4.week.ago.to_date, task_id: 5)
    record.save!

# User 2:
user = User.create(email: "6testing@gmail.com", password: "testing6", password_confirmation: "testing6", id: 6)
user.save!
  task = Task.create(:reminder_type => "EmergenC! T2", :frequency => "Daily", user_id: 6, id: 6)
  task.save!
    record = Record.create(:completed => "false", :created_at => 2.week.ago.to_date, task_id: 6)
    record.save!
    record = Record.create(:completed => "false", :created_at => 3.week.ago.to_date, task_id: 6)
    record.save!
    record = Record.create(:completed => "true", :created_at => 4.week.ago.to_date, task_id: 6)
    record.save!