# Clear existing data
Costume.destroy_all
User.destroy_all
Booking.destroy_all

User.create!(
  [
    {
      first_name: "John",
      last_name: "Doe",
      address: "123 Main St",
      email: "john.doe@example.com",
      encrypted_password: "encrypted_password1",
      reset_password_token: "reset_token1",
      reset_password_sent_at: Time.now - 3600,
      remember_created_at: Time.now - 7200
    },
    {
      first_name: "Jane",
      last_name: "Smith",
      address: "456 Elm St",
      email: "jane.smith@example.com",
      encrypted_password: "encrypted_password2",
      reset_password_token: "reset_token2",
      reset_password_sent_at: Time.now - 1800,
      remember_created_at: Time.now - 5400
    },
    {
      first_name: "Alice",
      last_name: "Johnson",
      address: "789 Oak St",
      email: "alice.johnson@example.com",
      encrypted_password: "encrypted_password3",
      reset_password_token: "reset_token3",
      reset_password_sent_at: Time.now - 900,
      remember_created_at: Time.now - 3600
    }
  ]
)

puts "#{User.count} users have been seeded."

Costume.create!([
  {
    name: "Superman Costume",
    category: "superhero",
    size: "M",
    description: "A superhero costume for Superman with a cape.",
    price_per_day: 50,
    photo_url: "/app/assets/images/seed_images/superman.jpg",
    user_id: 1
  },
  {
    name: "Medieval Knight",
    category: "historical",
    size: "L",
    description: "A historical knight costume with armor and a sword.",
    price_per_day: 70,
    photo_url: "/app/assets/images/seed_images/knight.webp",
    user_id: 1
  },
  {
    name: "Dinosaur Suit",
    category: "animal",
    size: "XL",
    description: "A fun dinosaur costume for parties.",
    price_per_day: 40,
    photo_url: "/app/assets/images/seed_images/dinosaur.jpg",
    user_id: 2
  },
  {
    name: "Elsa Dress",
    category: "movie",
    size: "S",
    description: "Become Elsa, the ice queen",
    price_per_day: 60,
    photo_url: "/app/assets/images/seed_images/Elsa.jpg",
    user_id: 2
  },
  {
    name: "Princess Leia",
    category: "movie",
    size: "M",
    description: "A costume of Princess Leia from Star Wars.",
    price_per_day: 55,
    photo_url: "/app/assets/images/seed_images/leia.jpg",
    user_id: 3
  },
  {
    name: "Pikachu",
    category: "tv show",
    size: "XXL",
    description: "A full cotton pikachu costume. Doesn't come with electric powers",
    price_per_day: 45,
    photo_url: "/app/assets/images/seed_images/pikachu.jpg",
    user_id: 3
  }
])

puts "Seeded #{Costume.count} costumes with photos."

Booking.create!([
  {
    user: users[0],
    costume: costume[0],
    start_date: DateTime.now + 1.day,
    end_date: DateTime.now + 5.days
  },
  {
    user: user[1],
    costume: costume[1],
    start_date: DateTime.now + 2.days,
    end_date: DateTime.now + 6.days
  }
]
)

puts "#{Booking.count} bookings have been seeded."
