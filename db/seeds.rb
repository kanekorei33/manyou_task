User.create!([name:"kaneko", email:"25nikoniko@gmail.com", password: "123456", admin:"true"])

User.create([
  { name:"青野", email:"test_1@example.com", password: "123456" },
  { name:"遠藤", email:"test_2@example.com", password: "123456" },
  { name:"門脇", email:"test_3@example.com", password: "123456" },
  { name:"金子", email:"test_4@example.com", password: "123456" },
  { name:"齋藤", email:"test_5@example.com", password: "123456" },
  { name:"佐藤", email:"test_6@example.com", password: "123456" },
  { name:"鈴木", email:"test_7@example.com", password: "123456" },
  { name:"中村", email:"test_8@example.com", password: "123456" },
  { name:"西川", email:"test_9@example.com", password: "123456" },
  { name:"丸岡", email:"test_10@example.com", password: "123456" },
  { name:"森塚", email:"test_11@example.com", password: "123456" },
  { name:"山田", email:"test_12@example.com", password: "123456" },
  { name:"吉田", email:"test_13@example.com", password: "123456" },
])

User.all.each do |user|
  user.tasks.create(title:"タイトルだよ", content:"#{user.name}のタスクの内容だよ")
end

10.times do |num|
  Label.create(name: "label#{num + 1}" )
end
