require 'rails_helper'

RSpec.describe Post, type: :model do
	it "is accessible" do
		post = Post.create!
		expect(post).to eq(Post.last)
	end

	it "has title and content columns" do
		columns = Post.column_names
		expect(columns).to include("id")
		expect(columns).to include("title")
		expect(columns).to include("content")
		expect(columns).not_to include("user_id")
	end
end
