module ProducersHelper
  def display_producer_card(producer = nil)
    @producer = producer
    render partial: "shared/producer_card"
  end

  def producer_image(producer = nil)
    if producer &&  producer.photos?
      cl_image_path producer.photos.first.path
    else
      image_path('producer-card-image.jpg')
    end
  end
end
