module TestsHelper
  def test_level(test)
    case test.level
    when 1
      'easy'
    when 2
      'elementary'
    when 3
      'hard'
    else
      'hero'
    end
  end
end
