FactoryBot.define do
  factory :task do
    title { 'test_title' }
    content { 'test_content' }
    deadline { Date.today }
    created_at { Date.today }
    #association :user ,factory::admin_user
  end
  factory :second_task, class: Task do
    title { 'Factoryで作ったデフォルトのタイトル2' }
    content { 'Factoryで作ったデフォルトのコンテント2' }
    deadline { Date.today+1 }
    created_at { Date.today+1}
  end
  factory :third_task, class: Task do
    title { 'Factoryで作ったデフォルトのタイトル3' }
    content { 'Factoryで作ったデフォルトのコンテント3' }
    deadline { Date.today+2 }
    created_at { Date.today+2}
  end
end
