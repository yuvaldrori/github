#!/usr/bin/env ruby

require 'nokogiri'
require 'open-uri'

i = 0

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
    if post.text.downcase.include? "supportocat" then
      puts post.css("h2.blog-post-title").css('a').text
    end
  end
end

