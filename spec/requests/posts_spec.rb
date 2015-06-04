require "rails_helper"

RSpec.describe "posts", :type => :request do
  before(:all) do
    @post = Post.create(:title => "post from request spec")
  end

  it "#index" do
    get "/posts"
    expect(response).to have_http_status(200)
    expect(response).to render_template(:index)
    expect(response.body).to include("Title")
    expect(response.body).to include("Content")
    expect(response.body).to include("post from request spec")
  end

  it "#show" do
    get "/posts/#{@post.id}"
    expect(response).to have_http_status(200)
    expect(response).to render_template(:show)    
    expect(response.body).to include("Title:")
    expect(response.body).to include("Content:")
    expect(response.body).to include("post from request spec")
  end

  it "#create" do
    params = {title: "create title", content: "create content"}
    post "/posts", post: params
    expect(response).to have_http_status(302)
    expect(Post.last.title).to eq(params[:title])
  end
end