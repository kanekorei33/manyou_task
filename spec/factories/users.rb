FactoryBot.define do
  factory :user do
    name { "紅茶花伝" }
    email { "kocha@gmail.com" }
    password { "123456" }
    admin { "true" }
  end

  factory :user_second,class: User do
    name { "ウーパールーパー" }
    email { "upaupa@gmail.com" }
    password { "123456" }
    admin { "false" }
  end

  factory :admin_user,class: User do
    name { "テスト管理者" }
    email { "admin_2@gmail.com" }
    password { "123456" }
    admin { "true" }
  end
end
