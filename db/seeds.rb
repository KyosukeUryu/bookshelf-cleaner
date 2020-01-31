User.create!(
  name: "test_admin",
  email: "test@admin.com",
  password: "password",
  admin: true,
  confirmed_at: DateTime.now
)
10.times do |i|
  UnreadBook.create!(
    title: "hoge#{i}",
    author: "test#{i}",
    status: 0,
    user_id: User.last.id
  )
end
10.times do |i|
  FinishedBook.create!(
    title: "fuga#{i}",
    author: "example#{i}",
    status: 0,
    user_id: User.last.id
  )
end
User.create!(
  name: "other_user",
  email: "other@test.com",
  password: "password",
  confirmed_at: DateTime.now
)
10.times do |i|
  UnreadBook.create!(
    title: "other_hoge#{i}",
    author: "other_test#{i}",
    status: 0,
    user_id: User.last.id
  )
end
10.times do |i|
  FinishedBook.create!(
    title: "other_fuga#{i}",
    author: "other_example#{i}",
    status: 0,
    user_id: User.last.id
  )
end
