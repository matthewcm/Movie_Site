module ApplicationHelper
    def sortable(column, title = nil)
          title ||= column.titleize
          css_class = column == sort_column ? "current #{sort_direction}" : nil
          direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
          link_to title, {:sort => column, :direction => direction}, {:class => css_class}
    end
    # def single_poster(movie)
    #       poster = movie['Poster']
    #       id = movie['imdbID']
    #       url = URI.parse(poster)

    #       if poster != 'N/A'
    #         if movie_service.url_pass("#{url.to_s}")
    #           poster = "#{url.to_s}"
    #         else
    #           url = URI.parse('http://img.omdbapi.com/')
    #          searcher = "?i=#{id}"
    #           if movie_service.url_pass("#{url.to_s}#{searcher}&apikey=40584c09")
    #             poster = "#{url.to_s}#{searcher}&apikey=40584c09"
    #           else
    #             poster = 'noposter.jpg'
    #           end
    #         end
    #       else
    #             poster = 'noposter.jpg'
    #       end
    #     poster
    # end

end
