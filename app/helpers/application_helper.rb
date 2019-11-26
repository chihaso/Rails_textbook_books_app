# frozen_string_literal: true

module ApplicationHelper
  def create_language_links(language_code, request_path)
    if language_code == "ja"
      link_to_if params[:locale] != "ja", "日本語",   "#{request_path}?locale=ja"
    elsif language_code == "en"
      link_to_if params[:locale] != "en", "English", "#{request_path}?locale=en"
    else
      t("applicationhelper.create_language_links.unsupported_language")
    end
  end

  def set_comment_destination(book_id:, report_id:)
    if book_id
      hidden_field_tag :book_id, book_id
    elsif report_id
      hidden_field_tag :report_id, report_id
    else
      flash[:notice] = t("errors.messages.unknown_comment_destination")
    end
  end
end
