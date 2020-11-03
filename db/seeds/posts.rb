puts 'Start inserting seed "posts" ...'
# seedsファイルで「require './db/seeds/users'」を先に記載しているので、アソシエーションを使用してpostを作成できる。
User.limit(10).each do |user|
  post = user.posts.create!(
    body: Faker::Movies::StarWars.quote,
    # %wは配列を作成できる%記法。(これで2つの350×350の画像を作成できる)
    # /public/uploads配下に画像を保存をせず、web上の画像を表示させるには、remote_images_urlsカラムを使用する理解で良い？？
    remote_images_urls: %w[https://picsum.photos/350/350/?random https://picsum.photos/350/350/?random]
  )
  puts "post#{post.id} has created!"
end