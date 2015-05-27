require 'rails_helper'

RSpec.describe Post, type: :model do
	it "is accessible" do
		post = Post.create!(:title => "title")
		expect(post).to eq(Post.last)
	end

	it "has title and content columns" do
		columns = Post.column_names
		expect(columns).to include("id")
		expect(columns).to include("title")
		expect(columns).to include("content")
		expect(columns).not_to include("user_id")
	end

	it "validates title" do
    expect(Post.new).not_to be_valid
    expect(Post.new(:title => "title")).to be_valid
	end

	it ".no_content" do
    post_with_content = Post.create(:title => "title", :content => "content")
		post_without_content = Post.create(:title => "title", :content => nil)    
	  expect(Post.no_content).to include post_without_content
	  expect(Post.no_content).not_to include post_with_content
	end

	it "#abstract" do
		post = Post.create(:title => "title", :content => "12345678901234567890_not_abstract")
		expect(post.abstract).to include("12345678901234567890")
		expect(post.abstract).not_to include("not_abstract")
	end

	it "has_many comments" do
    post = Post.create(:title => "title", :content => "content")
    comment = Comment.create(:content => "content", :post_id => post.id)
    expect(post.comments).to include(comment)
	end
end
