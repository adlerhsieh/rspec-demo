require 'rails_helper'

RSpec.describe PostsController, type: :controller do
	before(:all) do
		@post_1 = Post.create(title: "title_1", content: "content_1")
		@post_2 = Post.create(title: "title_2", content: "content_2")
	end

	it "#index" do
		get :index
		expect(response).to have_http_status(200)
		expect(response).to render_template(:index)
	end

	it "#new" do
		get :new
		expect(response).to have_http_status(200)
		expect(response).to render_template(:new)
	end

	it "#edit" do
		get :edit, id: @post_1[:id]
		expect(response).to have_http_status(200)
		expect(response).to render_template(:edit)
	end

	describe "#create" do
		before(:all) do
			@post_params = {title: "title", content: "content"}
		end

		it "creates record" do 
			expect{ post :create, post: @post_params }.to change{Post.all.size}.by(1)
		end

		it "redirect on success" do
			post :create, post: @post_params
			expect(response).not_to have_http_status(200)
			expect(response).to have_http_status(302)
			expect(response).to redirect_to(post_path(Post.last))
		end

		it "render :new on fail" do
			allow_any_instance_of(Post).to receive(:save).and_return(false)
			post :create, post: @post_params
			expect(response).not_to have_http_status(302)
			expect(response).to render_template(:new)
		end
	end

	describe "#update" do
		before(:all) do
			@post_params = {title: "title_3", content: "content"}
		end

		it "changes record" do 
			post :update, post: @post_params, id: @post_2[:id]
			expect(Post.find(@post_2[:id])[:title]).to eq("title_3")
		end

		it "redirect on success" do
			post :update, post: @post_params, id: @post_2[:id]
			expect(response).not_to have_http_status(200)
			expect(response).to have_http_status(302)
			expect(response).to redirect_to(post_path(Post.find(@post_2[:id])))
		end

		it "render :edit on fail" do
			allow_any_instance_of(Post).to receive(:update).and_return(false)
			post :update, post: @post_params, id: @post_2[:id]
			expect(response).not_to have_http_status(302)
			expect(response).to render_template(:edit)
		end
	end

	describe "#destroy" do
		before(:each) do
			@post_3 = @post_2 || Post.create(title: "title_3", content: "content_3")
		end

		it "destroy record" do
			expect{ delete :destroy, id: @post_3[:id] }.to change{Post.all.count}.by(-1)
		end 

		it "redirect_to index after destroy" do
			delete :destroy, id: @post_3[:id]
			expect(response).to have_http_status(302)
			expect(response).to redirect_to(posts_path)
		end
	end


end