# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

book = Guestbook.create!(title: 'Poster Fair 2017', archived: false, created_at: 3.day.ago, is_default: true, auto_approve: true, 
  description: "An engineering or design education culminates in a capstone project that draws on a student's undergraduate skills and knowledge. The theory, practice and skills learned in the previous years come together, culminating in the fourth-year design project that develops professional-level experience, integrates and extends previously acquired knowledge, and fosters solid team work.");
book.messages.create([
  {content: 'Adam', approved: true, votes: 13},
  {content: 'Max', approved: true, created_at: 1.day.ago, votes: 24},
  {content: 'Richard', approved: true, created_at: 3.day.ago, votes: 17},
  {content: 'James', approved: true, created_at: 3.day.ago, votes: 17, votes_cast: 34}
]);

user = User.create!(email: 'admin@example.com', password: 'admin')
key = AccessKey.create!(label: 'Default Key', key: 'bb6a37a6de7b6fe19d6e8b12246764f3', guestbook: book)