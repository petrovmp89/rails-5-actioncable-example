class YandexNews

  def perform
    begin
      xml_content = Net::HTTP.get(URI.parse('https://news.yandex.ru/index.rss'))
      data = Hash.from_xml(xml_content)
      item = data['rss']['channel']['item'].first
      news_item = News.new(header: item['title'],
                           annotation: item['description'],
                           date: item['pubDate'])
      Rails.logger.info 'News recieved!' if news_item.save
    rescue => e
       Rails.logger.error e.message
       Rails.logger.error e.backtrace.join("\n")
    end
  end

end
