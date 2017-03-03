# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

book = Guestbook.create!(title: 'My Gala', archived: false, created_at: 3.day.ago, is_default: true, 
  description: "My test gala with sortable messages!");
book.messages.create([
  {content: 'Adam', approved: true, votes: 13},
  {content: 'Max', approved: true, created_at: 1.day.ago, votes: 24},
  {content: 'Richard', approved: true, created_at: 3.day.ago, votes: 17}
]);