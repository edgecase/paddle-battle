module ApplicationHelper
  def link_to_with_current(name, url)
    options = (current_page? url) ? { class: "current" } : {}
    link_to name, url, options
  end

  def format_game_scores(scores)
    spans = scores.map do |w, l, status|
      content_tag 'span', "#{w}-#{l}", class: status
    end.join

    raw(spans)
  end
end
