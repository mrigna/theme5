namespace :db do
  desc "create 5000 random nodes"
  task :populate => :environment do
	require 'populator'
	require 'faker'
      
    @id = []
    Node.populate 5000 do |node|      
    @random_id = Faker::Number.number(5)  
    check_if_exist
    node.nodeID = @random_id 
    @id  << node.nodeID  
    node.url_label = Faker::Internet.domain_suffix
    node.hidden = [true, false].sample(1)
    node.dg  = ["DG-GS", "DG4", "DG5", "MEDEX", "SHC", "COM/PO"].sample(1)
    puts node.nodeID
	  end
    puts 'All Nodes done'  

    10.times do
    Theme.populate(10) do |theme| 
          @random_node = Node.all.sample(1).first.nodeID
          theme.nodeID = @random_node
          theme.contentID = Faker::Number.number(5) + ['', '_fr', '_nl', '_de', '_en'].sample(1).first
          generate_html
          theme.html_content = @random_html_content
          puts theme.contentID
        end
    sleep 30
    end
  Theme.create  
  puts 'All Themes done'
         
   Metadata.populate(100) do |meta| 
      @random_theme = Theme.all.sample(1).first.contentID
      meta.contentID = @random_theme
      meta.language = ['nl','fr','de','en'].sample(1)
      meta.title =  Faker::Lorem.sentence(word_count = 4, supplemental = false, random_words_to_add = 6)
      meta.description = Faker::Lorem.paragraphs(paragraph_count = 1, supplemental = false) 
      meta.keywords = Faker::Lorem.word + "; " + Faker::Lorem.word + "; " + Faker::Lorem.word
    end
    puts 'All Metadata done'
    
    Theme.create
   
    def check_if_exist      
       while @random_id.in? @id
           @random_id = Faker::Number.number(5)      
       end
    end

    def generate_html      
      resource = Net::HTTP.get_response(URI.parse("http://loripsum.net/api/10/short/headers/link"))
        @random_html_content = resource.body
    end
    
  end
end