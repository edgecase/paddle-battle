module ApplicationHelper
  def link_to_with_current(name, url, opts={})
    if current_page? url
      if opts[:class].blank?
        opts[:class] = 'active'
      else
        opts[:class] += ' active'
      end
    end
    link_to name, url, opts
  end

  def format_game_scores(scores)
    spans = scores.map do |w, l, status|
      content_tag 'span', "#{w}-#{l}", class: status
    end.join

    raw(spans)
  end

  def distribution_data(rankings, top_n)
    i = 0
    rankings.map do |ranking|
      i += 1
      [i, ranking.rating, "#{i}. #{ranking.player.display_name} - #{ranking.rating}"]
    end
  end
end
