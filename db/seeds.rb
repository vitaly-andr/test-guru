def create_category(title)
  Category.find_or_create_by!(title: title)
rescue ActiveRecord::RecordInvalid => e
  puts "Category creation failed: #{e.message}"
end

def create_user(name, email, password)
  User.find_or_create_by!(name: name, email: email) do |user|
    user.password = password
    user.password_confirmation = password
  end
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

create_category('Backend')
create_category('Frontend')
create_category('DevOps')

User.create!(
  name: 'Alice',
  email: 'alice@example.com',
  password: 'password1',
  password_confirmation: 'password1',
  admin: true,
  confirmed_at: Time.now,
  confirmation_sent_at: Time.now
)

User.create!(
  name: 'Bob',
  email: 'bob@example.com',
  password: 'password2',
  password_confirmation: 'password2',
  confirmed_at: Time.now,
  confirmation_sent_at: Time.now
)

User.create!(
  name: 'Charlie',
  email: 'charlie@example.com',
  password: 'password3',
  password_confirmation: 'password3',
  confirmed_at: Time.now,
  confirmation_sent_at: Time.now
)

create_test('Ruby Basics', 1, 'Backend', 'alice@example.com')
create_test('Ruby Advanced', 2, 'Backend', 'alice@example.com')
create_test('JavaScript Basics', 1, 'Frontend', 'bob@example.com')
create_test('JavaScript Advanced', 2, 'Frontend', 'bob@example.com')
create_test('Docker Basics', 1, 'DevOps', 'charlie@example.com')
create_test('Kubernetes Advanced', 2, 'DevOps', 'charlie@example.com')

# Вопросы и ответы для Ruby Basics
create_question('What is Ruby?', 'Ruby Basics')
create_answer('A programming language.', true, 'What is Ruby?')
create_answer('A type of gemstone.', false, 'What is Ruby?')
create_answer('A framework for building web applications.', false, 'What is Ruby?')
create_answer('A database management system.', false, 'What is Ruby?')

create_question('Who developed Ruby?', 'Ruby Basics')
create_answer('Yukihiro Matsumoto', true, 'Who developed Ruby?')
create_answer('Guido van Rossum', false, 'Who developed Ruby?')
create_answer('Dennis Ritchie', false, 'Who developed Ruby?')
create_answer('James Gosling', false, 'Who developed Ruby?')

create_question('Which of the following is a Ruby web framework?', 'Ruby Basics')
create_answer('Ruby on Rails', true, 'Which of the following is a Ruby web framework?')
create_answer('Django', false, 'Which of the following is a Ruby web framework?')
create_answer('Spring', false, 'Which of the following is a Ruby web framework?')
create_answer('Laravel', false, 'Which of the following is a Ruby web framework?')

# Вопросы и ответы для Ruby Advanced
create_question('What is a Ruby gem?', 'Ruby Advanced')
create_answer('A package of Ruby code that can be distributed and installed.', true, 'What is a Ruby gem?')
create_answer('A type of gemstone.', false, 'What is a Ruby gem?')
create_answer('A configuration file for Ruby.', false, 'What is a Ruby gem?')
create_answer('A web server for Ruby applications.', false, 'What is a Ruby gem?')

create_question('What does the `attr_accessor` method do?', 'Ruby Advanced')
create_answer('Creates getter and setter methods for instance variables.', true, 'What does the `attr_accessor` method do?')
create_answer('Creates only getter methods for instance variables.', false, 'What does the `attr_accessor` method do?')
create_answer('Creates only setter methods for instance variables.', false, 'What does the `attr_accessor` method do?')
create_answer('Creates a constant variable.', false, 'What does the `attr_accessor` method do?')

create_question('What is the purpose of the `super` keyword in Ruby?', 'Ruby Advanced')
create_answer('Calls the same method from the superclass.', true, 'What is the purpose of the `super` keyword in Ruby?')
create_answer('Creates a superclass.', false, 'What is the purpose of the `super` keyword in Ruby?')
create_answer('Initializes an instance variable.', false, 'What is the purpose of the `super` keyword in Ruby?')
create_answer('Defines a class method.', false, 'What is the purpose of the `super` keyword in Ruby?')

# Вопросы и ответы для JavaScript Basics
create_question('What is JavaScript?', 'JavaScript Basics')
create_answer('A programming language.', true, 'What is JavaScript?')
create_answer('A type of coffee.', false, 'What is JavaScript?')
create_answer('A web server.', false, 'What is JavaScript?')
create_answer('A database management system.', false, 'What is JavaScript?')

create_question('Who developed JavaScript?', 'JavaScript Basics')
create_answer('Brendan Eich', true, 'Who developed JavaScript?')
create_answer('Tim Berners-Lee', false, 'Who developed JavaScript?')
create_answer('Mark Zuckerberg', false, 'Who developed JavaScript?')
create_answer('Larry Page', false, 'Who developed JavaScript?')

create_question('Which company first implemented JavaScript?', 'JavaScript Basics')
create_answer('Netscape', true, 'Which company first implemented JavaScript?')
create_answer('Microsoft', false, 'Which company first implemented JavaScript?')
create_answer('Google', false, 'Which company first implemented JavaScript?')
create_answer('Apple', false, 'Which company first implemented JavaScript?')

# Вопросы и ответы для JavaScript Advanced
create_question('What is a closure in JavaScript?', 'JavaScript Advanced')
create_answer('A function that has access to its own scope, the scope of the outer function, and the global scope.', true, 'What is a closure in JavaScript?')
create_answer('A method to close the browser window.', false, 'What is a closure in JavaScript?')
create_answer('An object that closes over its properties.', false, 'What is a closure in JavaScript?')
create_answer('A design pattern in JavaScript.', false, 'What is a closure in JavaScript?')

create_question('What does the `this` keyword refer to in JavaScript?', 'JavaScript Advanced')
create_answer('The object that is executing the current function.', true, 'What does the `this` keyword refer to in JavaScript?')
create_answer('The global object.', false, 'What does the `this` keyword refer to in JavaScript?')
create_answer('The current function.', false, 'What does the `this` keyword refer to in JavaScript?')
create_answer('A reference to the previous function.', false, 'What does the `this` keyword refer to in JavaScript?')

create_question('What is the purpose of the `let` keyword in JavaScript?', 'JavaScript Advanced')
create_answer('Declares a block-scoped local variable.', true, 'What is the purpose of the `let` keyword in JavaScript?')
create_answer('Declares a global variable.', false, 'What is the purpose of the `let` keyword in JavaScript?')
create_answer('Defines a constant variable.', false, 'What is the purpose of the `let` keyword in JavaScript?')
create_answer('Creates a new object.', false, 'What is the purpose of the `let` keyword in JavaScript?')

# Вопросы и ответы для Docker Basics
create_question('What is Docker?', 'Docker Basics')
create_answer('A platform for developing, shipping, and running applications in containers.', true, 'What is Docker?')
create_answer('A programming language.', false, 'What is Docker?')
create_answer('A web framework.', false, 'What is Docker?')
create_answer('A database management system.', false, 'What is Docker?')

create_question('What is a Docker container?', 'Docker Basics')
create_answer('A lightweight, standalone, and executable package of software.', true, 'What is a Docker container?')
create_answer('A virtual machine.', false, 'What is a Docker container?')
create_answer('A type of database.', false, 'What is a Docker container?')
create_answer('A networking protocol.', false, 'What is a Docker container?')

create_question('Which of the following is a command to build a Docker image?', 'Docker Basics')
create_answer('docker build', true, 'Which of the following is a command to build a Docker image?')
create_answer('docker run', false, 'Which of the following is a command to build a Docker image?')
create_answer('docker start', false, 'Which of the following is a command to build a Docker image?')
create_answer('docker stop', false, 'Which of the following is a command to build a Docker image?')

# Вопросы и ответы для Kubernetes Advanced
create_question('What is Kubernetes?', 'Kubernetes Advanced')
create_answer('An open-source platform for automating deployment, scaling, and operations of application containers.', true, 'What is Kubernetes?')
create_answer('A programming language.', false, 'What is Kubernetes?')
create_answer('A web framework.', false, 'What is Kubernetes?')
create_answer('A type of database.', false, 'What is Kubernetes?')

create_question('What is a Kubernetes pod?', 'Kubernetes Advanced')
create_answer('The smallest deployable unit in Kubernetes, which can contain one or more containers.', true, 'What is a Kubernetes pod?')
create_answer('A virtual machine.', false, 'What is a Kubernetes pod?')
create_answer('A networking protocol.', false, 'What is a Kubernetes pod?')
create_answer('A type of database.', false, 'What is a Kubernetes pod?')

create_question('Which command is used to create a new pod in Kubernetes?', 'Kubernetes Advanced')
create_answer('kubectl create pod', true, 'Which command is used to create a new pod in Kubernetes?')
create_answer('kubectl run', false, 'Which command is used to create a new pod in Kubernetes?')
create_answer('kubectl start', false, 'Which command is used to create a new pod in Kubernetes?')
create_answer('kubectl deploy', false, 'Which command is used to create a new pod in Kubernetes?')
