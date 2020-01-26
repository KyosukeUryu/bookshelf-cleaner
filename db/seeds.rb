30.times do |i|
  UnreadBook.create!(
    title: "hoge#{i}",
    author: "test#{i}",
    status: 0,
    reading_expired: Time.now,
    user_id: User.last.id
  )
end
