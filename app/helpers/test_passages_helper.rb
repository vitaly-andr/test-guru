module TestPassagesHelper
  def test_result_message(test_passage)
    success_percentage = test_passage.success_percentage.round

    if test_passage.success?
      message = t('test_passages.helper.success_message', success_percentage: success_percentage)
      color = "green"
    else
      message = t('test_passages.helper.failure_message', success_percentage: success_percentage)
      color = "red"
    end

    content_tag :span, message, style: "color: #{color};"
  end
end
