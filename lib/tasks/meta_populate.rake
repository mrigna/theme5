namespace :db do
  desc "Create 20 metadata associated with theme.contentID"
  task :meta_populate => :environment do
    require 'populator'
    require 'faker'
        
    @id = []
      Metadata.populate(100) do |meta| 
      @random_meta = Theme.all.sample(1).first.id  
      checkit
      meta.theme_id = @random_meta
      puts meta.id
      @id  << @random_meta  
      meta.language = ['nl','fr','de','en'].sample(1)
      meta.title =  Faker::Lorem.sentence(word_count = 4, supplemental = false, random_words_to_add = 6)
      meta.description = Faker::Lorem.paragraphs(paragraph_count = 1, supplemental = false) 
      meta.keywords = Faker::Lorem.word + "; " + Faker::Lorem.word + "; " + Faker::Lorem.word
    end
   
    puts 'All Metadata done'
       
    end

end


def checkit
    while @random_meta.in? @id
        @random_meta = Theme.all.sample(1).first.id
    end
end