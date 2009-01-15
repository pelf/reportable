module Kvlr #:nodoc:

  module ReportsAsSparkline #:nodoc:

    module SparklineTagHelper

      # Renders a sparkline with the given data.
      #
      # ==== Parameters
      #
      # * <tt>data</tt> - The data to render the sparkline for
      #
      # ==== Options
      #
      # * <tt>width</tt> - The width of the generated image
      # * <tt>height</tt> - The height of the generated image
      # * <tt>line_color</tt> - The line color of the sparkline (hex code)
      # * <tt>fill_color</tt> - The color to fill the area below the sparkline with (hex code)
      # * <tt>labes</tt> - The axes to render lables for (Array of :x, :y, :r, :t; this is x axis, y axis, right, top)
      #
      # ==== Example
      # <%= sparkline_tag(User.registrations_report, :width => 200, :height => 100, :color => '000') %>
      def sparkline_tag(data, options = {})
        options.reverse_merge!({ :width => 300, :height => 34, :line_color => '0077cc', :fill_color => 'e6f2fa', :labels => [] })
        data = data.collect { |d| d[1] }
        labels = ""
        unless options[:labels].empty?
          labels = "&chxt=#{options[:labels].map(&:to_s).join(',')}&chxr=0,0,#{data.length}|1,0,#{data.max}|2,0,#{data.max}|3,0,#{data.length}"
        end
        image_tag(
          "http://chart.apis.google.com/chart?cht=ls&chs=#{options[:width]}x#{options[:height]}&chd=t:#{data.join(',')}&chco=#{options[:line_color]}&chm=B,#{options[:fill_color]},0,0,0&chls=1,0,0&chds=#{data.min},#{data.max}#{labels}"
        )
      end

    end

  end

end
