module ProducersHelper
  def display_producer_card(producer = nil)
    @producer = producer || Producer.first
    @medals_sorted = Medal.new(@producer.products).single_medals_for_producer_card(@producer)
    render partial: "shared/producer_card"
  end

# TO DO : NETTOYER APRES DISCUSSION POUR IDENTIFIER LES IMPACTS

  def producer_img_path(producer = nil)
    if producer &&  producer.photos?
      cl_image_path producer.photos.first.path, height: 150, crop: :fill
    elsif producer && AUTHORIZED_CATEGORIES[producer.category]
      image_path("category/#{AUTHORIZED_CATEGORIES[producer.category][:cat_pic]}")
    else
      image_path('producer-card-image.jpg')
    end
  end

  def producer_lg_img_path(producer = nil)
    if producer &&  producer.photos?
      cl_image_path producer.photos.first.path
    elsif producer && AUTHORIZED_CATEGORIES[producer.category]
      image_path("category/#{AUTHORIZED_CATEGORIES[producer.category][:cat_pic]}")
    else
      image_path('producer-card-image.jpg')
    end
  end
end
