#!/usr/bin/env ruby

require 'mail'

Mail.defaults do
  retriever_method :pop3, :address =>  'mails.pipgame.com', :port =>  110, :user_name =>  'your email with pipgame.com tailing', :password =>  'your password'
end

Mail.find(:count =>  10).each do |mail|
  sub = mail.subject.is_utf8? ? mail.subject : mail.subject.force_encoding("gbk").encode("utf-8")
  puts sub
  body =  /^utf/ =~ mail.body.encoding ? mail.body : mail.body.raw_source.force_encoding('gbk').encode('utf-8')
  puts body
end
