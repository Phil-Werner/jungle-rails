require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # validation tests/examples here

    it 'product with all four fiels set should save successfully' do
      @category = Category.new(name: 'some_category')
     # @category.save!
      @product = Product.new(category: @category, name: 'apple', price_cents: 100, quantity: 500)
      @product.save!

      expect(@product).to be_present

      puts @product.errors.full_messages

    end

    it 'validates that product has a name' do
      @category = Category.new(name: 'some_category')

      @product = Product.new(category: @category, name: nil, price_cents: 100, quantity: 500)
      expect(@product).to be_valid
    end

    it 'validates that product has a price' do
      @category = Category.new(name: 'some_category')

      @product = Product.new(category: @category, name: 'apple', price_cents: nil, quantity: 500)
      expect(@product).to be_valid
    end

    it 'validates that product has a quantity' do
      @category = Category.new(name: 'some_category')

      @product = Product.new(category: @category, name: 'apple', price_cents: 100, quantity: nil)
      expect(@product).to be_valid
    end

    it 'validates that product has a category' do
      @category = Category.new(name: 'some_category')

      @product = Product.new(category: nil, name: 'apple', price_cents: 100, quantity: 500)
      expect(@product).to be_valid
    end
  end
end


