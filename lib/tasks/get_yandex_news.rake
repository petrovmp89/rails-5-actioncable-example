desc 'Get yandex news'
namespace :news do
  task get_yandex_news: :environment do
    tries = 3
    begin
      xml_content = Net::HTTP.get(URI.parse('https://news.yandex.ru/index.rss'))
      data = Hash.from_xml(xml_content)
      item = data['rss']['channel']['item'].first
      news_item = News.new(header: item['title'],
                   annotation: item['description'],
                   date: item['pubDate'],
                   expired_at: Time.now + 1.hour)
      Rails.logger.info 'News recieved!' if news_item.save
    rescue => e
     tries -= 1
     if tries > 0
       retry
     else
       Rails.logger.info "Can't get news from yandex. Something goes wrong."
     end
   end
  end
end
