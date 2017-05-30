
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Assets/Models/Scrapper/...

ProducerAward.destroy_all
Producer.destroy_all

year = 2016
scrapper = Scrapper::ConcoursAgricoleScrapper.new(year: year.to_s)
scrapper.scrap.each do |data|

  producer = Producer.create!(
    name: data[:name],
    address: data[:address],
    zipcode: data[:zipcode],
    city: data[:city],
    description: data[:description],
    phone: data[:phone],
    company_email: data[:company_email],
    category: data[:category]
  )

  ProducerAward.create!(
    producer: producer,
    name: data[:medaille],
    year: year
  )

end

