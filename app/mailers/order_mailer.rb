class OrderMailer < ApplicationMailer
  default from: "no-reply@jungle.com"

  def order_email(order)
    @order = order
    @line_items = @order.line_items
    @products = []

    @line_items.each do |line_item|
      @products.push(line_item.product)
    end

    mail(to: @order.email, subject: 'Thanks for your order!')
  end

end
