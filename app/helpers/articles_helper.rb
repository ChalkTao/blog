module ArticlesHelper
	def disques_count(article) 
		article_path(article) + "#disqus_thread"
	end
end
