namespace :db do
  desc "create 30 nodes => 5 by DG"
  task :node_populate => :environment do
	require 'populator'
	require 'faker'
    
  @id = []
  @i = 0  
    Node.populate 30 do |node|      
    @random_id = Faker::Number.number(5)  
    check_if_exist
    node.nodeID = @random_id 
    @id  << node.nodeID  
    node.url_label = Faker::Commerce.product_name
    node.hidden = [true, false].sample(1)
    get_dg
    node.dg = @dg
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

def get_dg
  if @i < 6  
      @dg  = ["dg-gs", "dg4", "dg5", "medex", "shc", "com-po"][@i]
      @i += 1
      else
      @i = 0
      get_dg
  end
  
end    