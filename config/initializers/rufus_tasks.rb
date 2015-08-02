# Rufus_Tasks will be used to send out text messages to remind users to take their medication/supps/etc at users' desired time
# This job will have to run daily to grab new tasks, or new tasks should be added after being created
scheduler = Rufus::Scheduler.new
puts "*********************************************Rufus Tasks booted************************************************************"
# Twilio Information -- should be relocated to .env file...
account_sid = 'ACce2ac884ee78da5155fc87f7bbc0cb4a'  
auth_token = '4080f63106e48ffa5112cf750578caea' 
@client = Twilio::REST::Client.new account_sid, auth_token 

# Look for new tasks in the database to schedule to send out once a day
# scheduler.every '24h' do
	# Grabbing tasks and users for Phone Numbers + messages
	@tasks = Task.all
	# Refactor: Grab only relevant information (Phone + ID)
	@users = User.all
	puts "All information = obtained for Rufus Scheduler******************************************************************************"

	@users.each do |user|
		# Phone number to send texts
		@send_to = user.phone_number
		puts "******************************************USer phone number: #{@send_to}"
		# Temporary: Twilio can only send texts to users with a phone number and tasks with reminder times + messages. Will be unnecessary after adding more info into the seed file and validations
		if user.phone_number.blank? == false
		puts "******************************************USer phone number is not empty..."
			# For each user, send out all reminder messages
			user.tasks.each do |task|
				# Texts should be sent at HH:MM. Time entered by users, in Tasks database
				@cron_time = "#{task.reminder_time.strftime('%M')} #{task.reminder_time.strftime('%H')} * * *"
				puts "**************************************** #{task.reminder_type} is being evaluated.........."
				puts "***************************************************** and is to be sent out: #{@cron_time}"
				# Using Rufus_Scheduler to send out texts through Twilio at designated time, daily
				scheduler.cron @cron_time do
					puts "Sending out this message: #{task.message} at: #{task.reminder_time}, aka #{Time.now}"
					puts "-------******************************************************"
					# Using Twilio to send messages
					@client.account.messages.create({
					  :from => '+14159368708', 
					  :to => @send_to,
					  :body => task.message
					})
				end
			end
		end
	end
# end