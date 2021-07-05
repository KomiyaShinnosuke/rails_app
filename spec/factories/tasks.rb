FactoryBot.define do
  factory :task do
    name { 'テストを書く' }
    description { 'Rspecとか' }
    user
  end
end
