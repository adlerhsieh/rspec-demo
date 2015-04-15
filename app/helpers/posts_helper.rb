module PostsHelper
	def render_content
		if not @post.content.nil?
    		@post.content
  		else
    		content_tag(:p, "No Content")
  		end
	end
end
