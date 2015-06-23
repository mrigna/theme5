namespace :db do
  desc "create 5000 random nodes"
  task :theme_populate => :environment do
    require 'populator'
    require 'faker'

      @i = 1
      @count = 0
      30.times do
        Theme.populate(4) do |theme|
           get_node
           theme.node_id = @i
           get_content
           theme.contentID = @content
           @count += 1
           generate_html
           theme.html_content = @random_html_content
           theme.is_original = @original
           theme.more_about = false
           puts theme.contentID
        end


        sleep(3)
      end
     puts 'All Themes done'
    end
end

     def get_node
        if @count >= 4 
          @count = 0
          @i += 1
          get_node
        end
      end 

     def get_content    
        if @count == 0
             @base = Faker::Number.number(5)
             @original = true
             @content = @base.to_s
             @lang = ['_fr', '_nl', '_de', '_en'].shuffle! 
         else
          @original = false
          @content = @base  
           if @lang.length == 0
           @lang = ['_fr', '_nl', '_de', '_en'] 
           else
           @content += @lang.pop
           @lang.shuffle!
           end
         end
      end

       def generate_html      
            resource = Net::HTTP.get_response(URI.parse("http://loripsum.net/api/10/short/headers/link"))
            @random_html_content = resource.body.to_s
       end