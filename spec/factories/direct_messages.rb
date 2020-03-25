FactoryBot.define do
  factory :direct_message do
    content { "MyString" }
    user_id { 1 }
    room_id { 1 }
  end
end
