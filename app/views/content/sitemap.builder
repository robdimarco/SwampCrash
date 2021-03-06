xml.instruct!  
xml.urlset "xmlns" => "http://www.sitemaps.org/schemas/sitemap/0.9" do
  xml.url do
    xml.loc root_url
    xml.lastmod Date.today.to_s('%Y-%m-%d')
  end
  Quiz.released_publicly.each do |q|
    xml.url do  
      xml.loc quiz_url(q)  
      xml.lastmod q.updated_at.xmlschema
    end  
  end
  %w(about todos).each do |name|
    xml.url do
      xml.loc content_url(:action=>name)
      xml.lastmod Date.today.to_s('%Y-%m-%d')
    end
  end
end