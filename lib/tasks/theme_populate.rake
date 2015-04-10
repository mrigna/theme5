namespace :db do
  desc "Create 100 themes html code"
  task :theme_populate => :environment do
    require 'populator'
    require 'faker'
        
    Theme.populate(20) do |theme| 
      @random_node = Node.all.sample(1).first.nodeID
      theme.nodeID = @random_node
      theme.contentID = Faker::Number.number(5) + ['', '_fr', '_nl', '_de', '_en'].sample(1).first
      generate_html
      theme.html_content = @random_html_content
      puts theme.contentID
    end
     puts 'All done'
     Theme.create
  end

  def generate_html      
    resource = Net::HTTP.get_response(URI.parse("http://www.randomtext.me/api/lorem/p-4/20-42"))
    result = resource.body
    json = JSON.parse(result)
    @random_html_content = json["text_out"]   
  end

end