FactoryBot.define do
  factory :label do
    name { "test_label_1" }
  end
  factory :second_label, class: Label do
    name { "test_label_2" }
  end
  factory :third_label, class: Label do
    name { "test_label_3" }
  end
  factory :fourth_label, class: Label do
    name { "test_label_4" }
  end

  # trait :task_labels do
  #   after(:create)do |label|
  #   task = FactoryBot.create(:task)
  #   create_list(:task_label,1, [label], task: task)
  #   end
  # end
  # after(:build) do |label|
  #   task = create(:task)
  #   label.task_labels << build(:task_label, label: label, task: task)
end
