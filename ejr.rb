require 'mechanize'

class Ejr
  def initialize
    @agent = Mechanize.new
  end

  def search_word(string)
    @page = @agent.get("http://eow.alc.co.jp/search?q=#{string}&ref=sa")
    lis = @page/"div.mr_10"/"ul"/"li"   
  end
end



word = ARGV[0]
command = ARGV[1]
no = ARGV[2].to_i
ejr = Ejr.new


lis = ejr.search_word(ARGV[0])

if word == "-install"
  puts path = Dir.pwd + "/ejr.rb"
  File.open("#{ENV["HOME"]}/.bashrc","a"){|file|
    file.puts("alias ejr='ruby #{path}'")
  }
  puts "please restart your terminal!!"
else
  if command == "-a"
    lis.to_a.each_index{|li|
      puts lis[li].text if li != 0
    }
  elsif command == "-l"
    no ||= 5
    no.times{|li|
      puts lis[li].text if li != 0
    }
  else
    5.times{|li|
      puts lis[li].text if li != 0
    }
  end
end
