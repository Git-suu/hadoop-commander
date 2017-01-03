#!/usr/bin/env ruby 
require "date"
thirty_days_ago = Date.parse(Time.now.to_s) - 30
IO.popen("hadoop fs -ls -R /tmp/hive").each_line do |line|  
  permissions,replication,user,group,size,mod_date,mod_time,path = *line.split(/\s+/)
  if (mod_date)
    if Date.parse(mod_date.to_s) < thirty_days_ago
      puts line
      if permissions.split('')[0] == 'd'
        puts "deleting #{path}"
        `hadoop fs -rm -r -skipTrash #{path}`
        dirname = path
        next
      end 
      next if path.start_with? dirname
      `hadoop fs -rm -skipTrash #{path}`
    end
  end
end
