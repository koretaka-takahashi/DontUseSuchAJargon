149.times do |n|
  name = Faker::Name.name
  email = Faker::Internet.email
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               )
end

User.create!(name: "管理者A", email: "AAAAA@AAAAA.com",password: "aaaaaaaa", password_confirmation: "aaaaaaaa", admin: true )


Genre.create!(name: "IT")
Genre.create!(name: "音楽")
Genre.create!(name: "スポーツ")
Genre.create!(name: "教育")

# Term.create!(name: "シンコペーション", user_id: 1, genre_id: 2)
# Term.create!(name: "デッド", user_id: 2, genre_id: 2)
# Term.create!(name: "プリプロ", user_id: 3, genre_id: 2)
# Term.create!(name: "マスタリング", user_id: 1, genre_id: 2)


200.times do |i|
  name = Faker::Food.dish
  user_id = User.find(rand(149)+1).id
  genre_id = Genre.find(rand(3)+1).id
  Term.create!(name: name,
               user_id: user_id,
               genre_id: genre_id,
               )
end

500.times do |i|
  content = Faker::Food.description
  user_id = User.find(rand(149)+1).id
  term_id = Term.find(rand(199)+1).id
  Description.create!(content: content,
               user_id: user_id,
               term_id: term_id,
               )
end

500.times do |i|
  content = Faker::Food.description
  user_id = User.find(rand(149)+1).id
  description_id = Description.find(i+1).id
  Comment.create!(content: content,
               user_id: user_id,
               description_id: description_id,
               )
end

80.times do |i|
  name = Faker::Food.fruits
  user_id = User.find(rand(149)+1).id
  genre_id = Genre.find(rand(3)+1).id
  Tag.create!(name: name,
               user_id: user_id,
               genre_id: genre_id,
               )
end

100.times do |i|
  term_id = Term.find(rand(199)+1).id
  tag_id = Tag.find(rand(79)+1).id
  Tagging.create!(term_id: term_id,
               tag_id: tag_id,
               )
end

150.times do |i|
  user_id = User.find(rand(149)+1).id
  description_id = Description.find(i+1).id
  Like.create!(user_id: user_id,
               description_id: description_id,
               )
end

150.times do |i|
  user_id = User.find(rand(149)+1).id
  term_id = Term.find(rand(199)+1).id
  Keep.create!(user_id: user_id,
               term_id: term_id,
               )
end




# Tag.create!(name: "ITタグ1", user_id: 1, genre_id: 1)
# Tag.create!(name: "ITタグ2", user_id: 2, genre_id: 1)
# Tag.create!(name: "ITタグ3", user_id: 3, genre_id: 1)
# Tag.create!(name: "ITタグ4", user_id: 5, genre_id: 1)
# Tag.create!(name: "ITタグ5", user_id: 5, genre_id: 1)
# Tag.create!(name: "音楽タグ1", user_id: 1, genre_id: 2)
# Tag.create!(name: "音楽タグ2", user_id: 2, genre_id: 2)
# Tag.create!(name: "音楽タグ3", user_id: 3, genre_id: 2)
# Tag.create!(name: "音楽タグ4", user_id: 5, genre_id: 2)
# Tag.create!(name: "音楽タグ5", user_id: 2, genre_id: 2)
# Tag.create!(name: "スポーツタグ1", user_id: 1, genre_id: 3)
# Tag.create!(name: "スポーツタグ2", user_id: 2, genre_id: 3)
# Tag.create!(name: "スポーツタグ3", user_id: 3, genre_id: 3)
# Tag.create!(name: "スポーツタグ4", user_id: 5, genre_id: 3)
# Tag.create!(name: "スポーツタグ5", user_id: 1, genre_id: 3)
# Tag.create!(name: "教育タグ1", user_id: 1, genre_id: 4)
# Tag.create!(name: "教育タグ2", user_id: 2, genre_id: 4)
# Tag.create!(name: "教育タグ3", user_id: 3, genre_id: 4)
# Tag.create!(name: "教育タグ4", user_id: 5, genre_id: 4)
# Tag.create!(name: "教育タグ5", user_id: 1, genre_id: 4)
