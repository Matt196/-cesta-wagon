
ProducerAward.destroy_all
ProducerReview.destroy_all
Product.destroy_all
Producer.destroy_all
User.destroy_all


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

  sleep(3)
end


# # --------------SCRAPER PRODUCER without PHOTOS--------------------

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

--------------ADD main photo to PRODUCER --------------------
Producer.all.each do |producer|
  if AUTHORIZED_CATEGORIES.key?(producer.category) # useful for partial seeds
    urls = [AUTHORIZED_CATEGORIES[producer.category][:cat_pic_url]]
    producer.photo_urls = urls
  end
end

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


