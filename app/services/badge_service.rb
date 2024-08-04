class BadgeService
  def initialize(test_passage)
    @test_passage = test_passage
    @user = test_passage.user
    @badges = Badge.all
  end

  def call
    @badges.each do |badge|
      award_badge(badge) if send("satisfies_#{badge.rule}?", badge)
    end
  end

  def new_tests_to_complete(badge)
    category_tests_ids = Test.by_category_title(badge.rule_value).published.pluck(:id)

    last_badge_award_date = @user.user_badges.joins(:badge)
                                 .where(badges: { rule_value: badge.rule_value, id: badge.id })
                                 .maximum(:created_at)
    Test.where(id: category_tests_ids)
                          .where('created_at > ?', last_badge_award_date)
  end

  private

  def award_badge(badge)
    @user.user_badges.create(badge: badge)
  end

  def satisfies_badge_condition?(badge)
    case badge.rule
    when 'Complete category'
      satisfies_complete_category?(badge)
    when 'First try'
      satisfies_first_try?
    when 'Complete level'
      satisfies_complete_level?(badge)
    when 'All tests passed'
      satisfies_all_tests_passed?
    else
      false
    end
  end

  # Правило: успешное прохождение всех тестов из категории
  def satisfies_complete_category?(badge)
    # Нам не важно получить список всех тестов в категории,
    # а нужно только тесты в категории с момента выдачи беджа
    # или все если бэдж еще не выдавался
    category_tests_ids = new_tests_to_complete(badge).pluck(:id)
    return false if category_tests_ids.empty?

    passed_tests_ids = @user.test_passages.passed.where(test_id: category_tests_ids).pluck(:test_id).uniq
    all_tests_completed = (category_tests_ids - passed_tests_ids).empty?
    badge_already_awarded = @user.user_badges.where(badge: badge).exists?
    new_tests_exist = category_tests_ids.exists?

    if all_tests_completed
      :award_badge
    elsif badge_already_awarded && new_tests_exist
      :confirm_badge
    else
      false
    end
  end





  # Правило: успешное прохождение теста с первой попытки
  def satisfies_first_try?(_rule_value)
    test_passages = @user.test_passages.where(test: @test_passage.test)
    @test_passage.passed && test_passages.where(passed: false).none?
  end

  # Правило: успешное прохождение всех тестов определенного уровня
  def satisfies_complete_level?(level)
    level = level.to_i
    level_tests_ids = Test.published.where(level: level).pluck(:id)
    passed_tests_ids = @user.test_passages.passed.where(test_id: level_tests_ids).pluck(:test_id).uniq

    (level_tests_ids - passed_tests_ids).empty?
  end

  # Правило: успешное прохождение всех тестов
  def satisfies_all_tests_passed?(_rule_value)
    all_tests_ids = Test.published.pluck(:id)
    passed_tests_ids = @user.test_passages.passed.pluck(:test_id).uniq

    (all_tests_ids - passed_tests_ids).empty?
  end
end
