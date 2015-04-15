prawn_document(:layout => :portrait) do |pdf|
	pdf.text "Hello World"
	@posts.each do |post|
		pdf.text post.title
	end
end