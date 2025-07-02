# db/seeds.rb
# Create admin user
admin = User.create!(
  name: 'Admin User',
  email: 'admin@example.com',
  password: 'password123',
  role: 'admin'
)

# Create regular user
user = User.create!(
  name: 'Regular User',
  email: 'user@example.com',
  password: 'password123',
  role: 'user'
)

puts "Created admin: #{admin.email}"
puts "Created user: #{user.email}"
