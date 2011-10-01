module Rack
  class Firelogger
    class Logger
      DEBUG = 0
      INFO = 1
      WARN = 2
      ERROR = 3
      FATAL = CRITICAL = 4

      attr_accessor :level

      def initialize
        @logs = []
        @errors = []
        @profile = nil
        @extension_data = nil
        @level = INFO
      end

      def add(severity, entry)
        entry = case entry.class.name
        when 'Hash', 'OrderedHash'
          if entry['template'] || entry['args']
            entry
          else
            {'args' => [entry]}
          end
        else
          {'args' => [entry]}
        end

        entry['template'] ||= '%s'
        entry['message'] ||= 'Object'
        entry['name'] ||= 'general'
        time = Time.now
        entry['timestamp'] ||= time.to_f
        entry['time'] ||= time.to_s
        file, line = caller[0].split(':')
        if file == __FILE__
          file, line = caller[1].split(':')
        end
        entry['pathname'] = file
        entry['lineno'] = line.to_i
        entry['level'] = case severity
                         when INFO
                           'info'
                         when WARN
                           'warning'
                         when FATAL
                           'critical'
                         else
                           'debug'
                         end

        entry['level'] ||= severity || INFO
        @logs << entry
      end

      def add_error(exception)
        @errors << exception
      end

      def debug(entry)
        add DEBUG, entry
      end

      def info(entry)
        add INFO, entry
      end

      def warn(entry)
        add WARN, entry
      end

      def fatal(entry)
        add FATAL, entry
      end


      def encode
        data = {}
        if @logs.length > 0
          data['logs'] = @logs.map{|l| prepare_log_entry(l) }
        end
        if @errors.length > 0
          data['errors'] = @errors.map{|e| prepare_error_entry(e) }
        end
        data['profile'] = @profile if @profiles
        data['extension_data'] = @extension_data if @extension_data

        pp data
        Base64.strict_encode64(data.to_json).scan(/.{0,76}/)
      end


      private

      def prepare_log_entry(entry)
        entry
      end

      def prepare_error_entry(e)
        error = {}
        error['message'] = e.message
        error['exc_info'] = [
          e.class.name,
          e.message,
          e.backtrace.map do |s|
            file, line, method = s.split(':')
            line = line.gsub(/^in `/, '').gsub(/'$/, '').to_i
            text = ::File.readlines(file)[line - 1].chomp
            [file, line, method, text]
          end
        ]
        time = Time.now
        error['timestamp'] ||= time.to_f
        error['time'] ||= time.to_s
        error['pathname'], error['lineno'] = error['exc_info'][0][0..1]

        error
      end
    end
  end
end
