# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
ActiveRecord::Base.connection.tables.each do |table|
  unless table == "schema_migrations" or table == "users"
  result = ActiveRecord::Base.connection.execute("SELECT id FROM #{table} ORDER BY id DESC LIMIT 1") rescue ( puts "Warning: not procesing table #{table}. Id is missing?" ; next )
  max_val = result.any? ? result.max['id'].to_i + 1 : 1
  puts "Resetting auto increment ID for #{table} to #{max_val}"
  ActiveRecord::Base.connection.execute("ALTER SEQUENCE #{table}_id_seq RESTART WITH #{max_val}")
  end
end