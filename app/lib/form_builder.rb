class FormBuilder < ActionView::Helpers::FormBuilder
  include ActionView::Helpers::TagHelper
  include ActionView::Context

  def errors?(method)
    return unless @object.respond_to?(:errors)

    @object.errors[method].present?
  end

  def errors_for(method)
    return unless errors?(method)

    content = []

    key = "activerecord.attributes.#{@object.class.name.underscore}.#{method}"
    content << I18n.t(key, default: method.to_s.humanize)
    content << @object.errors.messages[method].join(", ")

    content_tag :div, class: "invalid-feedback d-block" do
      content.join(" ")
    end
  end
end
