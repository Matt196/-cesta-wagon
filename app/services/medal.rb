class Medal
  attr_accessor :products

  def initialize(products)
    @products = products
  end

  def check_medals(products = [])
    #This method needs the medal files names in assets/images to remain unchanged
    medal =[]
    if products.present?
      product_array_to_use = products
    else
      product_array_to_use = @products
    end
    product_array_to_use.each do |product|
        image = ""
        hidden = ""
      if product.product_awards.present?
        if product.product_awards[0].name.include? "gold"
          award = "gold_medal.png"
          hidden = ""
        elsif product.product_awards[0].name.include? "silver"
          award = "silver_medal.png"
          hidden = ""
        else
          award = "bronze_medal.png"
          hidden = ""
        end
      else
        award = "no-medal.png"
        hidden = "hidden"
      end
      medal << [award, hidden]
    end
    medal
  end

  def single_medals_for_producer_card(producer)
    products = producer.products
    @medals = check_medals(products)
    @medals = @medals.uniq.flatten
    @medals_sorted = []

    if @medals.include?("gold_medal.png")
      @medals_sorted << ["gold_medal.png", ""]
    end
    if @medals.include?("silver_medal.png")
      @medals_sorted << ["silver_medal.png", ""]
    end
    if @medals.include?("bronze_medal.png")
      @medals_sorted << ["bronze_medal.png", ""]
    end
    if @medals.include?("no-medal.png")
      @medals_sorted << ["no-medal.png", "hidden"]
    end

    @medals_sorted
  end

end
