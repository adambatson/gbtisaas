# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

book = Guestbook.create!(title: 'Test Gala', archived: false, created_at: 3.day.ago);
book.messages.create([
	{content: 'Hello World', approved: true},
	{content: 'AAARGH', approved: true, created_at: 1.day.ago},
	{content: 'Should not show', approved: false, created_at: 1.day.ago}
]);

book = Guestbook.create!(title: 'Experimental Ball', archived: false, created_at: 14.day.ago);
book.messages.create([
	{content: 'Hello World', approved: true},
	{content: 'AAARGH', approved: true, created_at: 1.day.ago},
	{content: 'Should not show', approved: false, created_at: 1.day.ago}
]);
book.write_attribute(:archived, true);
book.save

book = Guestbook.create!(title: 'Science Thing', archived: false, created_at: 22.day.ago);
book.messages.create([
	{content: 'Hello World', approved: true},
	{content: 'AAARGH', approved: true, created_at: 1.day.ago},
	{content: 'Should not show', approved: false, created_at: 1.day.ago}
]);
book.write_attribute(:archived, true);
book.save