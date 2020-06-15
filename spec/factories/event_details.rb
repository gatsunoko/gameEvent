FactoryBot.define do
  factory :event_detail do
    game_id { 1 }
    owner { "MyString" }
    title { "MyString" }
    date { "2020-06-15 14:11:54" }
    latest { "MyString" }
    boolean { "MyString" }
    user_id { 1 }
    event_id { 1 }
  end
end
