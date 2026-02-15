Author.create!([
  { name: 'Jane Austen', bio: 'English novelist known primarily for her six major novels, which interpret, critique and comment upon the British landed gentry at the end of the 18th century.' },
  { name: 'George Orwell', bio: 'English novelist and essayist, journalist and critic. His work is characterised by lucid prose, awareness of social injustice, and opposition to totalitarianism.' },
  { name: 'J.R.R. Tolkien', bio: 'English writer, poet, philologist, and academic who is best known as the author of the classic high fantasy works The Hobbit and The Lord of the Rings.' },
  { name: 'Virginia Woolf', bio: 'English writer considered one of the most important modernist 20th century authors and a pioneer in the use of stream of consciousness as a narrative device.' },
  { name: 'Ernest Hemingway', bio: 'American novelist, short-story writer, and journalist. His economical and understated style had a strong influence on 20th-century fiction.' }
])

authors = Author.all

books_data = [
  { title: 'Pride and Prejudice', isbn: '978-0141439518', description: 'The story follows the main character, Elizabeth Bennet, as she deals with issues of manners, upbringing, morality, education, and marriage in the society of the landed gentry of the British Regency.', status: :completed },
  { title: '1984', isbn: '978-0451524935', description: 'A dystopian social science fiction novel and cautionary tale about the dangers of totalitarianism. The story takes place in an imagined future, the year 1984, when much of the world is in perpetual war.', status: :reading },
  { title: 'The Hobbit', isbn: '978-0547928227', description: 'Set in Middle-earth, the story follows the quest of home-loving hobbit Bilbo Baggins to win a share of the treasure guarded by Smaug the dragon.', status: :want_to_read },
  { title: 'Mrs Dalloway', isbn: '978-0156628709', description: 'A novel by Virginia Woolf that details a day in the life of Clarissa Dalloway, a fictional high-society woman in post-World War I England.', status: :completed },
  { title: 'The Old Man and the Sea', isbn: '978-0684801223', description: 'The story of a battle between an aging, experienced fisherman, Santiago, and a large marlin. It was the last major work of fiction written by Hemingway.', status: :reading },
  { title: 'Sense and Sensibility', isbn: '978-0141439662', description: 'The story follows the Dashwood sisters, Elinor and Marianne, as they move to a new home and experience both romance and heartbreak.', status: :want_to_read },
  { title: 'Animal Farm', isbn: '978-0451526342', description: 'An allegorical novella that tells the story of a group of farm animals who rebel against their human farmer, hoping to create a society where the animals can be equal, free, and happy.', status: :completed },
  { title: 'The Fellowship of the Ring', isbn: '978-0547928210', description: 'The first volume of J.R.R. Tolkien\'s epic fantasy trilogy, The Lord of the Rings. It tells the story of the journey of Frodo Baggins and his companions as they set out to destroy the One Ring.', status: :reading }
]

books_data.each_with_index do |book_attrs, idx|
  author = authors[idx % authors.length]
  Book.create!(book_attrs.merge(author_id: author.id))
end

books = Book.all

user = User.create!(
  name: 'Demo User',
  email: 'demo@example.com',
  password: 'password',
  password_confirmation: 'password'
)

User.create!(
  name: 'Jane Reader',
  email: 'jane@example.com',
  password: 'password123',
  password_confirmation: 'password123'
)

books.each_with_index do |book, idx|
  Review.create!(
    user: user,
    book: book,
    rating: rand(3..5),
    content: "This is a sample review for #{book.title}. It's a great book that I would recommend to anyone interested in #{book.author.name}'s work. The writing is excellent and the story is engaging from start to finish."
  )
end

shelf1 = Shelf.create!(name: 'Favorites', user: user)
shelf2 = Shelf.create!(name: 'To Read', user: user)
shelf3 = Shelf.create!(name: 'Classics', user: user)

[books[0], books[3], books[6]].each { |book| shelf1.books << book }
[books[2], books[5]].each { |book| shelf2.books << book }
[books[0], books[1], books[3], books[6]].each { |book| shelf3.books << book }

10.times do |i|
  ReadingSession.create!(
    user: user,
    book: books.sample,
    pages_read: rand(20..100),
    duration_minutes: rand(15..90),
    date: Date.current - i.days
  )
end

puts "Seed data created successfully!"
puts "- #{Author.count} authors"
puts "- #{Book.count} books"
puts "- #{User.count} users"
puts "- #{Review.count} reviews"
puts "- #{Shelf.count} shelves"
puts "- #{ReadingSession.count} reading sessions"