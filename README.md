# README

# TestGuru

## Список сущностей

- Пользователь
- Администратор
- Тест
- Вопрос
- Ответ
- Категория
- Результат

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
  ruby 3.3.0
* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


Чтобы запустить production локально
RAILS_ENV=production_local ./bin/render-build.sh

config.assets.digest = false Надо проверить с этим может быть проблема
или с этим

# config/importmap.rb

def pin_all_relative(dir_name)
  pin_all_from "app/javascript/#{dir_name}",
    under: "#{Rails.application.config.assets.prefix}/#{dir_name}",
    to: dir_name
end

pin_all_relative "controllers"
# etc

То есть можно попробовать вообще не использовать относительный импорт с точками


