require 'thread'
require 'ponder'
require 'pi_piper'
include PiPiper

def setupPin(pin_num=:pin_num)
	PiPiper::Pin.new(:pin => pin_num, :direction => :out)
end

nick = 'zurukea'
@highlight_msg = Queue.new
@semaphore = Mutex.new
puts 'queue init'
pins = {}
pins.merge! nick => setupPin(18)
pins[nick].on

@conn = Ponder::Thaum.new do |config|
	config.nick	= 'FlashWarn'
	config.server	= 'irc.freenode.net'
	config.port	= '6667'
	config.verbose	= true
end

@conn.on :connect do
	@conn.message 'NickServ', 'identify FlashWarn ##relae'
	@conn.join '##relae'
end

@conn.on :channel, // do |ed|
	puts ed
	msg = ed[:message]
	if msg.include? nick and @highlight_msg.empty? then
		@highlight_msg << 1
		Thread.new do
			until @highlight_msg.empty? do
				pins[nick].off
				puts "LED for #{nick} turned on."
				sleep 0.25
				pins[nick].on
				puts "LED for #{nick} turned off."
				sleep 0.25
			end
		end
	elsif ed[:nick] == nick
		@highlight_msg.pop if not @highlight_msg.empty?
	end
end

@conn.connect
