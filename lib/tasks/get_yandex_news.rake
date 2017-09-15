desc 'Get yandex news'
namespace :news do
  task get_yandex_news: :environment do
    YandexNews.new.perform
  end
end
