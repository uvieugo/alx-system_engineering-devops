#!/usr/bin/env ruby
# A comment
puts ARGV[0].scan(/(?<=from:|to:|flags:).+?(?=\])/).join(',')
