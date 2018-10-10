require 'pry'

def consolidate_cart(cart)
  # code here
  # groups identical items
  cons_cart = {}
  cart.each do |item|
    cons_cart = cons_cart.merge(item)
  end
  
  cons_cart.each do |name, att_hash|
    cons_cart[name][:count] = cart.count { |item| item.keys[0] == name }
  end
  cons_cart
  
  
end

def apply_coupons(cart, coupons)
  # code here
  # applies coupons by separating out the appropriate number of 
  # target items 
  # coupon is an array of hashes:
  # [{ item: "AVOCADO", num: 3, cost: 5}]
  # binding.pry
  coupons.each do |coupon|
    item = coupon[:item]
    if cart.has_key?(item)
      coup_item = item + ' W/COUPON'
      cart[coup_item] ||= {
        clearance: cart[item][:clearance],
        price: coupon[:cost],
        count: 0
      }
      if cart[item][:count] >= coupon[:num]
        cart[coup_item][:count] += 1
        cart[item][:count] -= coupon[:num]
      end
    end
  end
  cart
end

def apply_clearance(cart)
  # code here
  # applies 20% discout to all of the items on clearance
  cart.each do |item, att_hash|
    if att_hash.fetch(:clearance)
      cart[item][:price] *= 0.8
      cart[item][:price] = cart[item][:price].round(1)
    end
  end
end

def calc_total(cart)
  total = 0
  cart.each_value { |v| total += v[:price] * v[:count] }
  
  # 10% discount for orders over 100
  total *= 0.9 if total > 100
  total
end
  

def checkout(cart = [], coupons = [])
  # code here
  # call other methods and then calculate total cost
  cart = consolidate_cart(cart)
  # binding.pry
  apply_coupons(cart, coupons)
  # binding.pry
  apply_clearance(cart)
  calc_total(cart)
  
end
