# Clear existing data
Costume.destroy_all

# Define sample data with placeholder photo URLs
costumes = [
  {
    name: "Superman Costume",
    category: "superhero",
    size: "M",
    description: "A superhero costume for Superman with a cape.",
    price_per_day: 50,
    photo_url: "https://via.placeholder.com/300"
  },
  {
    name: "Medieval Knight",
    category: "historical",
    size: "L",
    description: "A historical knight costume with armor and a sword.",
    price_per_day: 70,
    photo_url: "https://via.placeholder.com/300"
  },
  {
    name: "Dinosaur Suit",
    category: "animal",
    size: "XL",
    description: "A fun dinosaur costume for parties.",
    price_per_day: 40,
    photo_url: "https://via.placeholder.com/300"
  },
  {
    name: "Sherlock Holmes",
    category: "tv show",
    size: "S",
    description: "A classic Sherlock Holmes detective costume.",
    price_per_day: 60,
    photo_url: "https://via.placeholder.com/300"
  },
  {
    name: "Princess Leia",
    category: "movie",
    size: "M",
    description: "A costume of Princess Leia from Star Wars.",
    price_per_day: 55,
    photo_url: "https://via.placeholder.com/300"
  },
  {
    name: "Custom Sci-fi",
    category: "other",
    size: "XXL",
    description: "A custom sci-fi costume for various events.",
    price_per_day: 45,
    photo_url: "https://via.placeholder.com/300"
  }
]

# Seed the database with sample data
costumes.each do |costume_data|
  Costume.create!(costume_data)
end

puts "Seeded #{Costume.count} costumes with photos."