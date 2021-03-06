module CustomerHelper
  def customer_sign_up_error_messages!
    return "" if @customer.errors.blank?
    messages = @customer.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t("errors.messages.not_saved",
                      :count => @customer.errors.count,
                      :resource => @customer.class.model_name.human.downcase)

    html = <<-HTML
    <div id="error_explanation">
      <h2>#{sentence}</h2>
      <ul>#{messages}</ul>
    </div>
    HTML

    html.html_safe
  end
end
