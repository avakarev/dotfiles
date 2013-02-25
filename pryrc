# format prompt to be <Rails version>@<ruby version>(<object>)>
Pry.config.prompt = proc do |obj, level, _|
  prompt = ""
  prompt << "#{Rails.version} \e[0;32m| \e[2;32m" if defined?(Rails)
  prompt << "#{RUBY_VERSION}p#{RUBY_PATCHLEVEL}"
  "\e[2;32m#{prompt} \e[2;37m(#{obj})> \e[0m"
end

# use awesome print for all objects in pry
begin
  require 'awesome_print'
  AwesomePrint.pry!
rescue
  puts "=> Unable to load awesome_print, please type 'gem install awesome_print' or 'sudo gem install awesome_print'."
end
