
ProducerAward.destroy_all
# ProducerReview.destroy_all
Product.destroy_all
# Producer.destroy_all
# User.destroy_all


# # --------------SCRAPER PRODUCER without PHOTOS--------------------

# year = 2016
# scrapper = Scrapper::ConcoursAgricoleScrapper.new(year: year.to_s)
# scrapper.scrap.each do |data|

#   user = User.create(
#     email: data[:company_email],
#     first_name: data[:name],
#     last_name: data[:zipcode],
#     password: "password"
#   )


#   producer = Producer.create(
#     name: data[:name],
#     address: data[:address],
#     zipcode: data[:zipcode],
#     city: data[:city],
#     description: data[:description],
#     phone: data[:phone],
#     company_email: data[:company_email],
#     category: data[:category],
#     user: user
#   )

#   ProducerAward.create(
#     producer: producer,
#     name: data[:medaille],
#     year: year
#   )

#   # sleep(3)
# end

# --------------ADD 3 products to PRODUCER without PHOTOS--------------------
# url = "http://lorempixel.com/800/600/city/"


Producer.all.each do |producer|
  rand(1..4).times do

    if AUTHORIZED_CATEGORIES[producer.category].present?
      name = AUTHORIZED_CATEGORIES[producer.category][:keywords].sample
    else
       name = Faker::Commerce.product_name
    end
    product = Product.create(
      name: name,
      description: Faker::Lorem.paragraph,
      price: Faker::Commerce.price,
      producer: producer
      )
  end
end

Product.all.each do |product|
  puts product.name
  ProductAward.create(name: ["gold", "silver", "bronze", "n"].sample, year:"2017", product: product)
  puts product.product_awards.first.name
end

# --------------ADD main photo to PRODUCER --------------------
# Producer.all.each do |producer|
#   if AUTHORIZED_CATEGORIES.key?(producer.category) # useful for partial seeds
#     urls = [AUTHORIZED_CATEGORIES[producer.category][:cat_pic_url]]
#     producer.photo_urls = urls
#   end
# end
