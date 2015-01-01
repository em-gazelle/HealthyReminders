scheduler = Rufus::Scheduler.new

# Twilio Information
account_sid = 'ACce2ac884ee78da5155fc87f7bbc0cb4a' 
auth_token = '40f5a6b6a24f8cae7760b7151563a18a' 
@client = Twilio::REST::Client.new account_sid, auth_token 

# Grabbing tasks and users for Phone Numbers + messages
@tasks = Task.all
@users = User.all

@task1 = Task.find(3)
puts "Task 1: #{@task1.inspect}"
@task2 = Task.find(11) 
puts "Task 2: #{@task2.inspect}"
puts "*************************************************************************************"

scheduler.in '20s' do
	puts @task1.message
	@client.account.messages.create({
	  :from => '+16087136449', 
	  :to => '+18155203817', 
	  :body => @task1.message
	})
end

scheduler.in '50s' do
	puts @task2.message
	@client.account.messages.create({
	  :from => '+16087136449', 
	  :to => '+18155203817', 
	  :body => @task2.message
	})
end