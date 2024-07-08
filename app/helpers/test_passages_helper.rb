module TestPassagesHelper
  def test_result_message(test_passage)
    success_percentage = test_passage.success_percentage
    message = if success_percentage >= 85
                "Congratulations! You passed the test with #{success_percentage.round}% success!"
              else
                "Unfortunately, you did not pass the test. Your success rate is #{success_percentage.round}%."
              end

    color = success_percentage >= 85 ? "green" : "red"
    content_tag :span, message, style: "color: #{color};"
  end
end

