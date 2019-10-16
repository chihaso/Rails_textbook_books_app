module ApplicationHelper
  def create_language_links(language_code)
    if language_code == "ja"
      link_to_if params[:locale] != "ja", "日本語",   "#{request.domain.split("/")[2]}#{request.path}?locale=ja"
    elsif language_code == "en"
      link_to_if params[:locale] != "en", "English", "#{request.domain.split("/")[2]}#{request.path}?locale=en"
    else
      exit
    end
  end
end
