#!/usr/bin/env ruby

require 'nokogiri'
require 'open-uri'

i = 0
p = 1

while true
  i += 1
  uri = "https://github.com/blog/category/hire?page=" + i.to_s()
  page = Nokogiri::HTML(open(uri))
  posts = page.css(".posts").css("div.hentry.blog-post")
  length = posts.length
  if length  < 1 then
    break
  end
  posts.each do |post| 
    if post.text.downcase.include? "support" then
      line = post.css("h2.blog-post-title").css('a').text
      begin
        twitter = post.css('a').select{|link| link.text == "Twitter"}.first['href'].split('/').last
        line += ' @' + twitter
      rescue
      end
      puts line
      p += 1
    end
  end
end

puts 'I found ' + p.to_s + ' support people at GitHub'

