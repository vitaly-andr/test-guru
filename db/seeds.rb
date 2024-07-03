# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

def create_category(title)
  Category.find_or_create_by!(title: title)
rescue ActiveRecord::RecordInvalid => e
  puts "Category creation failed: #{e.message}"
end

def create_user(name, email)
  User.find_or_create_by!(name: name, email: email)
rescue ActiveRecord::RecordInvalid => e
  puts "User creation failed: #{e.message}"
end

def create_test(title, level, category_title)
  category = Category.find_by(title: category_title)
  Test.find_or_create_by!(title: title, level: level, category: category)
rescue ActiveRecord::RecordInvalid => e
  puts "Test creation failed: #{e.message}"
end

def create_question(body, test_title)
  test = Test.find_by(title: test_title)
  Question.find_or_create_by!(body: body, test: test)
rescue ActiveRecord::RecordInvalid => e
  puts "Question creation failed: #{e.message}"
end

def create_answer(body, correct, question_body)
  question = Question.find_by(body: question_body)
  Answer.find_or_create_by!(body: body, correct: correct, question: question)
rescue ActiveRecord::RecordInvalid => e
  puts "Answer creation failed: #{e.message}"
end

create_category('Backend')
create_category('Frontend')
create_category('DevOps')

create_user('Alice', 'alice@example.com')
create_user('Bob', 'bob@example.com')
create_user('Charlie', 'charlie@example.com')

create_test('Ruby Basics', 1, 'Backend')
create_test('Ruby Advanced', 2, 'Backend')
create_test('JavaScript Basics', 1, 'Frontend')
create_test('JavaScript Advanced', 2, 'Frontend')
create_test('Docker Basics', 1, 'DevOps')
create_test('Kubernetes Advanced', 2, 'DevOps')

create_question('What is Ruby?', 'Ruby Basics')
create_question('What is JavaScript?', 'JavaScript Basics')
create_question('What is Docker?', 'Docker Basics')

create_answer('A programming language.', true, 'What is Ruby?')
create_answer('A framework.', false, 'What is Ruby?')
create_answer('A programming language.', true, 'What is JavaScript?')
create_answer('A framework.', false, 'What is JavaScript?')
create_answer('A containerization tool.', true, 'What is Docker?')
create_answer('A programming language.', false, 'What is Docker?')

puts 'Жопа'
