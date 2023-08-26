# 何人ユーザー作るか
user_count = 4
users = []

# サンプルユーザーの設定
user_count.times do |i|
  user = User.find_or_create_by(name: "sample#{i+1}",email: "sample#{i+1}@example.com")
  user.password = "sample#{i+1}"
  user.save
  users << user
end

# 処理
user_count.times do |i|
  
  secret_phrase = SecretPhrase.find_or_create_by(user_id: users[i].id)
  secret_phrase.password = "secret#{i+1}"
  secret_phrase.save

  (user_count-1).times do |j|
    ApprovedUser.find_or_create_by(user_id: users[i].id, approved_user_id: users[i-1-j].id)
  end

  unless Post.exists?(user_id: users[i].id)
    post = Post.new(user_id: users[i].id) 
    post.images.attach(io: File.open(Rails.root.join('app/assets/images/sample.jpg')),filename: 'sample.jpg')
    post.save
  end
  
  3.times do |j|
    Tag.find_or_create_by(user_id: users[i].id, tag:"タグ#{j+1}")
  end

  3.times do |j|
    Taggroup.find_or_create_by(user_id: users[i].id, group:"グループ#{j+1}")
  end

end

puts "#{user_count} users have been created!"
