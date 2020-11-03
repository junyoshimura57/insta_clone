# おそらくターミナルで見やすいようにputsでコメントを表示
puts 'Start inserting seed "users" ...'
10.times do
  # seedsの場合はcreate!のが失敗した時に例外で気付きやすいという記事を見たので使用
  user = User.create!(
      # 「::」はおそらく名前空間を使用している。
      email: Faker::Internet.unique.email,
      # スターウォーズのキャラクターを使用
      username: Faker::Movies::StarWars.unique.character,
      password: 'password',
      password_confirmation: 'password'
      )
  puts "\"#{user.username}\" has created!"
end