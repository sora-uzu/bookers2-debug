FactoryBot.define do
  factory :book_comment do
    comment { "MyText" }
    user_id { 1 }
    book_id { 1 }
  end
end
