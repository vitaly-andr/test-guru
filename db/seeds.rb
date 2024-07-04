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

def create_test(title, level, category_title, author_email)
  category = Category.find_by(title: category_title)
  author = User.find_by(email: author_email)
  unless category && author
    puts "Category with title '#{category_title}' or Author with email '#{author_email}' not found."
    return
  end
  Test.find_or_create_by!(title: title, level: level, category: category, author: author)
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

def create_user_test(user_email, test_title, status)
  user = User.find_by(email: user_email)
  test = Test.find_by(title: test_title)
  unless user && test
    puts "User with email '#{user_email}' or Test with title '#{test_title}' not found."
    return
  end
  UserTest.find_or_create_by!(user: user, test: test).update!(status: UserTest.statuses[status])
rescue ActiveRecord::RecordInvalid => e
  puts "UserTest creation failed: #{e.message}"
end

create_category('Backend')
create_category('Frontend')
create_category('DevOps')

create_user('Alice', 'alice@example.com')
create_user('Bob', 'bob@example.com')
create_user('Charlie', 'charlie@example.com')

create_test('Ruby Basics', 1, 'Backend', 'alice@example.com')
create_test('Ruby Advanced', 2, 'Backend', 'alice@example.com')
create_test('JavaScript Basics', 1, 'Frontend', 'bob@example.com')
create_test('JavaScript Advanced', 2, 'Frontend', 'bob@example.com')
create_test('Docker Basics', 1, 'DevOps', 'charlie@example.com')
create_test('Kubernetes Advanced', 2, 'DevOps', 'charlie@example.com')

create_question('What is Ruby?', 'Ruby Basics')
create_question('What is JavaScript?', 'JavaScript Basics')
create_question('What is Docker?', 'Docker Basics')

create_answer('A programming language.', true, 'What is Ruby?')
create_answer('A framework.', false, 'What is Ruby?')
create_answer('A programming language.', true, 'What is JavaScript?')
create_answer('A framework.', false, 'What is JavaScript?')
create_answer('A containerization tool.', true, 'What is Docker?')
create_answer('A programming language.', false, 'What is Docker?')

create_user_test('alice@example.com', 'Ruby Basics', 'completed')
create_user_test('bob@example.com', 'JavaScript Basics', 'in_progress')
create_user_test('charlie@example.com', 'Docker Basics', 'completed')

# Пример повторного прохождения теста
create_user_test('alice@example.com', 'Ruby Basics', 'in_progress')
