#!/usr/bin/env ruby

require 'mail'

Mail.defaults do
  retriever_method :pop3, :address =>  'mails.pipgame.com', :port =>  110, :user_name =>  'your email', :password =>  'your password'
end


Mail.find(:what => :first, :count =>  100, :order => :asc ).each do |mail|
  sub = mail.subject.is_utf8? ? mail.subject : mail.subject.force_encoding("gbk").encode("utf-8")
  puts sub
  #binding.pry
  puts mail.date
  mail.parts.each do |part|
    if /账号/ =~ sub
      body =  part.body.decoded
      body = body.is_utf8? ? body : body.force_encoding('gbk').encode('utf-8')
      if /已付费/m =~ body
        File.open("./test","a") do |f|
          f.write("\n")
          f.write(Date.today.to_s)
          f.write(" #{sub} 已付费")
        end
        break
      end
    end

  end
end
