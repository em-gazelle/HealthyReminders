scheduler = Rufus::Scheduler.new

# Twilio Information
account_sid = 'ACce2ac884ee78da5155fc87f7bbc0cb4a' 
auth_token = '40f5a6b6a24f8cae7760b7151563a18a' 
@client = Twilio::REST::Client.new account_sid, auth_token 

# Grabbing tasks and users for Phone Numbers + messages
@tasks = Task.all
@users = User.all

@users.last.tasks.each do |task|
	# Texts should be sent at HH:MM. Time entered by users, in Tasks database
	@cron_time = "#{task.reminder_time.strftime('%M')} #{task.reminder_time.strftime('%H')} * * *"
	# Scheduling Texts to go out at designated time, daily
	scheduler.cron @cron_time do
		puts "Sending out this message: #{task.message} at: #{task.reminder_time}, aka #{Time.now}"
		puts "-------"
		@client.account.messages.create({
		  :from => '+16087136449', 
		  :to => @users.last.phone_number, 
		  :body => task.message
		})
	end
end