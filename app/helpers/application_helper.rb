module ApplicationHelper

    def full_title(page_title)
        base_title = "tagfoto"
        if page_title.empty?
            base_title
        else
            "#{base_title} | #{page_title}"
        end
    end

    def embedded_svg(filename, options = {})
        file = File.read(Rails.root.join('app', 'assets', 'images', filename))
        doc = Nokogiri::HTML::DocumentFragment.parse file
        svg = doc.at_css 'svg'
        svg['class'] = options[:class] if options[:class].present?
        doc.to_html.html_safe
    end

end
