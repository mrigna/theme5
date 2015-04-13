namespace :db do
  desc "Create 20 metadata associated with theme.contentID"
  task :meta_populate => :environment do
    require 'populator'
    require 'faker'
        
    Metadata.populate(20) do |meta| 
      @random_theme = Theme.all.sample(1).first.contentID
      meta.contentID = @random_theme
      meta.language = ['nl','fr','de','en'].sample(1)
      meta.title =  Faker::Lorem.sentence(word_count = 4, supplemental = false, random_words_to_add = 6)
      meta.description = Faker::Lorem.paragraphs(paragraph_count = 1, supplemental = false) 
      meta.keywords = Faker::Lorem.word + "; " + Faker::Lorem.word + "; " + Faker::Lorem.word
    end
     puts 'All done'
   end

end