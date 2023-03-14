FactoryBot.define do
  sequence :title do |n|
    "Post #{n}"
  end

  factory :post do
    title
    body { 'text text text' }
  end
end
