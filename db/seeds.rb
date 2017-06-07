# ProducerAward.destroy_all
ProducerReview.destroy_all
# Product.destroy_all
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

# --------------ADD main photo to PRODUCER --------------------
# Producer.all.each do |producer|
#   if AUTHORIZED_CATEGORIES.key?(producer.category) # useful for partial seeds
#     urls = [AUTHORIZED_CATEGORIES[producer.category][:cat_pic_url]]
#     producer.photo_urls = urls
#   end
# end

# --------------ADD 3 random rewiew to PRODUCER ----------------
nice_user = User.create(
  email: "nice_user1@cesta.top",
  first_name: 'Brice',
  last_name: 'De Nice',
  password: "password"
)

avg_user = User.create(
  email: "avg_user1@cesta.top",
  first_name: 'Jean',
  last_name: 'Dupont',
  password: "password"
)

bad_user = User.create(
  email: "nice_user1@cesta.top",
  first_name: 'Docteur',
  last_name: 'House',
  password: "password"
)

users = [nice_user, avg_user, bad_user]

reviews = [
  {
    content: "Super producteur local. Les spécialités sont faites maison par la grand-mère du patron. Expérience incroyable.",
    mark: 5
  },
  {
    content: "Certains produits sont bons, d'autres produits ne sont pas bons. Le producteur est parfois sympa, parfois non.",
    mark: 3
  },
  {
    content:   "Une expérience intéressante qui m'a un peu laissé sur ma faim. Et un peu nostalgique de la cuisine de ma grand mère",
    mark: 1
  }
]

Producer.all.each do |prod|
  users.each do |user|
    random_review = reviews.sample
    ProducerReview.create(
      user: user,
      producer: prod,
      content: random_review[:content],
      mark: random_review[:mark]
    )
  end
end


# --------------ADD 3 products to PRODUCER without PHOTOS--------------------
# url = "http://lorempixel.com/800/600/city/"


# Producer.all.each do |elem|
#   3.times do
#     product = Product.create(
#       name: Faker::Commerce.product_name,
#       description: Faker::Lorem.paragraph,
#       price: Faker::Commerce.price,
#       producer: elem
#       )
#   end
# end

# Product.all.each do |product|
#   ProductAward.new(name: ["gold", "silver", "bronze"].sample, year:"2017", product: product)
# end


