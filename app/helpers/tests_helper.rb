module TestsHelper

  TEST_LEVELS = { 1 => :easy, 2 => :elementary, 3 => :hard }.freeze
  def test_level(test)
    t("test_levels.#{TEST_LEVELS[test.level] || :hero}")  end
end
