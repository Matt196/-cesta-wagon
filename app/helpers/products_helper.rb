module ProductsHelper
  def product_img_path(product)
    if product.photos?
      cl_image_path product.photos.first.path
    else
      image_path('default_product.jpg')
    end
  end

  def display_products_list_item(product)
    @product = product
    render partial: "shared/products_list_item"
  end
end
