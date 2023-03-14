require 'rails_helper'

RSpec.describe Post, type: :model do
  it { should have_many(:comments).dependent(:destroy) }

  it { should validate_presence_of :title }
  it { should validate_presence_of :body }

  it 'have many attached images' do
    expect(Post.new.images).to be_an_instance_of(ActiveStorage::Attached::Many)
  end
end
