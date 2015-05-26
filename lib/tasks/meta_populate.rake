namespace :db do
  desc "Create 20 metadata associated with theme.contentID"
  task :meta_populate => :environment do
    require 'populator'
    require 'faker'

    count = 1 
    n = 1
    t = 0
    Metadata.populate(120) do |meta| 
      if count > n * 4
            n += 1
            t = 0
      end  
      
      @theme = Theme.where(node_id: n) 
        meta.theme_id = @theme[t].id          
          if @theme[t].is_original == false
              meta.language = @theme[t].contentID[-2..-1]            
          else
              find_lang
              meta.language = @lang
          end
      meta.title =  Faker::Lorem.sentence(word_count = 4, supplemental = false, random_words_to_add = 6)
      meta.description = Faker::Lorem.paragraphs(paragraph_count = 1, supplemental = false) 
      meta.keywords = Faker::Lorem.word + "; " + Faker::Lorem.word + "; " + Faker::Lorem.word
      t += 1     
      count += 1
      puts meta.id
    end
   
    puts 'All Metadata done'
       
    end
end

def find_lang
  lang = []
  @theme.each do |t|
    if t.contentID[-3] == "_"
      lang <<  t.contentID[-2..-1]
    end
  end
  test = ['nl','fr','de','en'] - lang
  @lang = test.first
end