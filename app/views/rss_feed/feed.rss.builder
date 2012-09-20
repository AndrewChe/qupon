xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Posts"
    xml.description "Lots of posts"
    xml.link rss_feed_feed_url(:rss)

    @posts.each do |article|
        xml.title article.title
        xml.description article.body
        xml.pubDate article.created_at.to_s(:rfc822)
        xml.link post_url(article, :rss)
        xml.guid post_url(article, :rss)
      end

  end
end
