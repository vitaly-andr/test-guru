module TestPassagesHelper
  def test_result_message(test_passage)
    success_percentage = test_passage.success_percentage

    if test_passage.success?
      message = "Congratulations! You passed the test with #{success_percentage.round}% success!"
      color = "green"
    else
      message = "Unfortunately, you did not pass the test. Your success rate is #{success_percentage.round}%."
      color = "red"
    end

    content_tag :span, message, style: "color: #{color};"
  end
end
