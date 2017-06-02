module ProducersHelper
  def display_producer_card(producer = nil)
    @producer = producer || Producer.first
    render partial: "shared/producer_card"
  end

# TO DO : nettoyer le test "producer" ci-dessous après nettoyage des guidelines ainsi que le else final

  def producer_img_path(producer = nil)
    if producer &&  producer.photos?
      cl_image_path producer.photos.first.path
    elsif producer && AUTHORIZED_CATEGORIES[producer.category]
      image_path("category/#{AUTHORIZED_CATEGORIES[producer.category][:cat_pic]}")
    else
      image_path('producer-card-image.jpg')
    end
  end
end
