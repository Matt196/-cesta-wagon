
ProducerAward.destroy_all
Producer.destroy_all
User.destroy_all
Product.destroy_all

# --------------SCRAPER PRODUCER without PHOTOS--------------------

year = 2016
scrapper = Scrapper::ConcoursAgricoleScrapper.new(year: year.to_s)
scrapper.scrap.each do |data|

  user = User.create(
    email: data[:company_email],
    first_name: data[:name],
    last_name: data[:zipcode],
    password: "password"
  )


  producer = Producer.create(
    name: data[:name],
    address: data[:address],
    zipcode: data[:zipcode],
    city: data[:city],
    description: data[:description],
    phone: data[:phone],
    company_email: data[:company_email],
    category: data[:category],
    user: user
  )

  ProducerAward.create(
    producer: producer,
    name: data[:medaille],
    year: year
  )
end

# --------------ADD 3 products to PRODUCER without PHOTOS--------------------
# url = "http://lorempixel.com/800/600/city/"


  Producer.all.each do |elem|
    3.times do
      product = Product.create(
        name: Faker::Commerce.product_name,
        description: Faker::Lorem.paragraph,
        price: Faker::Commerce.price,
        producer: elem
        )
    end
  end
