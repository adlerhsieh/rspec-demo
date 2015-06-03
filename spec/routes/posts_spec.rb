require 'rails_helper'

RSpec.describe "posts", :type => :routing do
  it "#index" do
    expect(:get => "/posts").to route_to("posts#index")
      # :controller => "posts",
      # :action => "index"
      # )
  end

  it "#show" do
    expect(:get => "/posts/1").to route_to(
      :controller => "posts",
      :action => "show",
      :id => "1"
      )
  end

  it "#create" do
    expect(:post => "/posts").to route_to(
      :controller => "posts",
      :action => "create"
      )
  end

  it "#last_post" do
    expect(:get => "/posts/last_post").to route_to(
      :controller => "posts",
      :action => "last_post"
      )
  end

  it "root" do
    expect(:get => "/").to route_to(
      :controller => "posts",
      :action => "index"
      )
  end
end