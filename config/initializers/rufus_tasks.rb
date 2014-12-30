scheduler = Rufus::Scheduler.new

scheduler.every('30s') do
	puts "**************************************************************************************"
	puts 'Hello... Rufus'
end