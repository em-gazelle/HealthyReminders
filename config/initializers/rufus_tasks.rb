# Setting up Twilio client and Rufus Scheduler instance
@client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
scheduler = Rufus::Scheduler.singleton

# Look for new tasks in the database to schedule to send out once a day
# Run scheduler every 30m? And then only let users choose hour/half hour blocks
scheduler.every '1m' do
	puts "**Rufus scheduler is firing**"

	# Rufus sends out texts through Twilio at designated time, daily
	Task.all.each do |task|
		next if task.reminder_time.nil?
		scheduler.cron cron_time(task.reminder_time) do
			send_text(task.user.phone_number, task.message)
		end
	end
end

def send_text(phone_number, message)
	puts "At #{Time.now}, Twilio sent out this message: #{message}"
	@client.account.messages.create({
		from: ENV['TWILIO_NUMBER'],
		to: phone_number,
		body: message
	})		
end

def cron_time(reminder_time)
	# Formats time for Rufus cron. Sends out daily at MM:HH
	"#{reminder_time.strftime('%M')} #{reminder_time.strftime('%H')} * * *"
end
