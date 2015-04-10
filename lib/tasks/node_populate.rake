namespace :db do
  desc "create 5000 random nodes"
  task :node_populate => :environment do
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
	  puts 'All done'
  end
end

def check_if_exist      
   while @random_id.in? @id
       @random_id = Faker::Number.number(5)      
   end   
end