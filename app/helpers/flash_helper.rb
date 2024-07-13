module FlashHelper
  def flash_messages
    flash.map do |key, message|
      alert_class = case key.to_sym
                    when :notice then "alert-success"
                    when :alert then "alert-danger"
                    else "alert-#{key}"
                    end

      content_tag :div, class: "alert #{alert_class} alert-dismissible fade show", role: "alert" do
        concat content_tag(:button, '', class: "btn-close", data: { bs_dismiss: "alert" }, aria: { label: "Close" })
        concat message
      end
    end.join.html_safe
  end
end
