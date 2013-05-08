require 'rubygems'
require "thread"
require "timeout"
require 'nokogiri'
require "open-uri"

#if ARGV.length < 1
# puts "USAGE: ruby vote_by_agent.rb 'agentfile' "
# exit
#end
#agent_file = ARGV[0]
#if !FileTest.exist?(agent_file)
# puts "File #{agent_file} was not found! "
# exit
#end
@uri = "http://zgnhzx.com:82/vote.asp?VoteOption=1&VoteType=Single&Action=Vote&ID=28"
@vote_count = 0


#IO.read(agent_file).scan(/\d+\.\d+\.\d+\.\d+\W\d+/){|proxy_ip| @proxys << proxy_ip.gsub(/\t|\s/,":")}
#@proxys = @proxys.last(ARGV[1].to_i) if ARGV[1]
#@proxys =["118.174.15.234:3128","124.248.34.51:3128"]


def create_thread
  @vote_count += 1
  #print "#{Time.now},thread count is #{Thread.list.size},proxy is: #{proxy} and vote count is: #{@vote_count} and proxys left : #{@proxys.length}\n"
  Thread.new do
    begin
      timeout(15) do
        open(@uri) do |f|
          print "#{f} #{Time.now.strftime("%y-%m-%d %H:%M:%S")} \n"
        end
      end
    rescue Exception => ex
      puts "ex==========#{ex}============= exit"
    end
  end
end
loop do
    if Thread.list.size < 5
        #当线程只有主线程，代理数组为空且投票次数为19时退出程序
        puts @vote_count

        create_thread
    else
        Thread.pass
    end
end
