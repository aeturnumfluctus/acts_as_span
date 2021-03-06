module ActsAsSpan
  class SpanInstance
    module Status
      extend ActiveSupport::Concern

      def span_status(query_date = Date.today)
        if future?(query_date)
          :future
        elsif expired?(query_date)
          :expired
        elsif current?(query_date)
          :current
        else
          :unknown
        end
      end

      alias_method :span_status_on, :span_status

      def span_status_to_s(query_date = Date.today)
        case span_status(query_date)
        when :future
          "Future"
        when :expired
          "Expired"
        when :current
          "Current"
        when :unknown
          "Unknown"
        end
      end

      alias_method :span_status_to_s_on, :span_status_to_s

      def current?(query_date = Date.today)
        !future?(query_date) && !expired?(query_date)
      end

      alias_method :current_on?, :current?

      def future?(query_date = Date.today)
        start_date && start_date > query_date
      end

      alias_method :future_on?, :future?

      def expired?(query_date = Date.today)
        end_date && end_date < query_date
      end

      alias_method :expired_on?, :expired?
    end
  end
end
