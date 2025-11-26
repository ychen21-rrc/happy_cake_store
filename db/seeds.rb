require "bigdecimal/util"

OrderItem.destroy_all if defined?(OrderItem)
Order.destroy_all if defined?(Order)
Address.destroy_all if defined?(Address)
User.destroy_all if defined?(User)

CategoryProduct.destroy_all if defined?(CategoryProduct)
Product.destroy_all
Category.destroy_all

Page.destroy_all if defined?(Page)
Province.destroy_all

AdminUser.destroy_all if defined?(AdminUser)

puts "== Seeding Provinces / Territories (GST/PST/HST) =="

# Tax rates updated as of Apr 1, 2025 (CRA + Retail Council)
# - HST provinces: store total HST in hst, gst/pst = 0
# - GST+PST provinces: store 5% GST in gst, PST/QST in pst, hst=0
# - Territories / Alberta / Yukon: GST only
provinces = [
  { name: "Alberta",                  gst: 0.05, pst: 0.0,     hst: 0.0 },
  { name: "British Columbia",         gst: 0.05, pst: 0.07,    hst: 0.0 },
  { name: "Manitoba",                 gst: 0.05, pst: 0.07,    hst: 0.0 },
  { name: "Saskatchewan",             gst: 0.05, pst: 0.06,    hst: 0.0 },
  { name: "Quebec",                   gst: 0.05, pst: 0.09975, hst: 0.0 }, # QST stored in pst
  { name: "Ontario",                  gst: 0.0,  pst: 0.0,     hst: 0.13 },
  { name: "New Brunswick",            gst: 0.0,  pst: 0.0,     hst: 0.15 },
  { name: "Newfoundland and Labrador",gst: 0.0,  pst: 0.0,     hst: 0.15 },
  { name: "Nova Scotia",              gst: 0.0,  pst: 0.0,     hst: 0.14 }, # HST reduced to 14% Apr 1, 2025
  { name: "Prince Edward Island",     gst: 0.0,  pst: 0.0,     hst: 0.15 },

  { name: "Northwest Territories",    gst: 0.05, pst: 0.0,     hst: 0.0 },
  { name: "Nunavut",                  gst: 0.05, pst: 0.0,     hst: 0.0 },
  { name: "Yukon",                    gst: 0.05, pst: 0.0,     hst: 0.0 }
]

Province.create!(provinces)
puts "   -> Provinces seeded: #{Province.count}"

puts "== Seeding Categories =="

cakes     = Category.create!(name: "Cakes")
cookies   = Category.create!(name: "Cookies")
pastries  = Category.create!(name: "Pastries")
seasonal  = Category.create!(name: "Seasonal Specials")

puts "   -> Categories seeded: #{Category.count}"

puts "== Seeding Products (real names + descriptions) =="

products_data = [
  {
    name: "Chocolate Lava Cake",
    description: "Warm dark chocolate cake with a gooey molten center, served with a light dusting of cocoa.",
    price: 8.99, is_new: true, is_on_sale: false, categories: [cakes]
  },
  {
    name: "Strawberry Shortcake Slice",
    description: "Soft vanilla sponge layered with fresh strawberries and whipped cream. Light and fruity.",
    price: 6.50, is_new: false, is_on_sale: true, categories: [cakes]
  },
  {
    name: "Red Velvet Cupcakes (Box of 4)",
    description: "Classic red velvet cupcakes topped with smooth cream cheese frosting.",
    price: 12.00, is_new: true, is_on_sale: false, categories: [cakes]
  },
  {
    name: "Classic Cheesecake",
    description: "Rich baked cheesecake with a buttery graham crust and a hint of vanilla.",
    price: 7.50, is_new: false, is_on_sale: false, categories: [cakes]
  },
  {
    name: "Matcha Swiss Roll",
    description: "Fluffy green tea sponge rolled with lightly sweetened cream. Not too heavy.",
    price: 6.99, is_new: false, is_on_sale: false, categories: [cakes, seasonal]
  },
  {
    name: "Butter Croissant",
    description: "Hand-laminated croissant with crisp layers and a soft buttery center.",
    price: 3.25, is_new: false, is_on_sale: false, categories: [pastries]
  },
  {
    name: "Almond Danish",
    description: "Golden pastry filled with almond cream and topped with toasted sliced almonds.",
    price: 4.25, is_new: false, is_on_sale: true, categories: [pastries]
  },
  {
    name: "Cinnamon Roll",
    description: "Soft spiral bun with cinnamon-sugar filling and vanilla glaze.",
    price: 4.50, is_new: true, is_on_sale: false, categories: [pastries]
  },
  {
    name: "Chocolate Chip Cookies (6 pcs)",
    description: "Chewy cookies loaded with semi-sweet chocolate chips, baked fresh daily.",
    price: 5.99, is_new: false, is_on_sale: false, categories: [cookies]
  },
  {
    name: "Oatmeal Raisin Cookies (6 pcs)",
    description: "Hearty oats with plump raisins and a touch of cinnamon.",
    price: 5.50, is_new: false, is_on_sale: false, categories: [cookies]
  },
  {
    name: "Salted Caramel Brownie",
    description: "Fudgy chocolate brownie swirled with salted caramel and finished with sea salt.",
    price: 4.75, is_new: false, is_on_sale: true, categories: [cookies, seasonal]
  },
  {
    name: "Pumpkin Spice Mini Cake",
    description: "Moist pumpkin cake with warm spices and maple cream topping. Limited seasonal item.",
    price: 6.25, is_new: true, is_on_sale: false, categories: [seasonal, cakes]
  }
]

products_data.each do |p|
  Product.create!(
    name: p[:name],
    description: p[:description],
    price: p[:price].to_d,
    is_new: p[:is_new],
    is_on_sale: p[:is_on_sale],
    categories: p[:categories]
  )
end

puts "   -> Products seeded: #{Product.count}"

puts "== Seeding Pages (About / Contact) =="

Page.create!(
  title: "About",
  slug: "about",
  content: <<~TEXT
    Happy Cake Store is a local bakery in Winnipeg, Manitoba, known for handmade cakes, pastries, cookies, and seasonal desserts.
    We have served the community for 7 years and now offer online ordering for quick pickup and special occasions.
  TEXT
)

Page.create!(
  title: "Contact",
  slug: "contact",
  content: <<~TEXT
    Happy Cake Store
    123 Portage Ave, Winnipeg, MB
    Phone: (204) 555-8888
    Hours: Mon–Sat 9:00am–7:00pm, Sun 10:00am–5:00pm
    Email: hello@happycakestore.ca
  TEXT
)

puts "   -> Pages seeded: #{Page.count}"

puts "== (Recommended) Seeding Admin User for ActiveAdmin =="

if defined?(AdminUser)
  AdminUser.create!(
    email: "admin@happycakestore.ca",
    password: "password",
    password_confirmation: "password"
  )
  puts "   -> AdminUser seeded: admin@happycakestore.ca / password"
end

puts "== Done! Seed completed successfully =="
