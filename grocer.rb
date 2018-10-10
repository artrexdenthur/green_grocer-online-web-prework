def consolidate_cart(cart)
  # code here
  # groups identical items
  cons_cart = cart.uniq { |item| item.keys[0] }
  cons_cart.each do |name, att_hash|
    cons_cart[name][:count] = cart.count { |item| item.keys[0] == name }
  end
  cons_cart
end

def apply_coupons(cart, coupons)
  # code here
  # applies coupons by separating out the appropriate number of 
  # target items 
end

def apply_clearance(cart)
  # code here
  # applies 20% discout to all of the items on clearance
end

def checkout(cart: [], coupons: [])
  # code here
  # call other methods and then calculate total cost
  consolidate_cart(cart)
  apply_coupons(cart, coupons)
  apply_clearance(cart)
  
end
