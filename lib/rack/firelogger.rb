require 'rack'
require 'json'
require 'base64'
require 'pp'

module Rack
  class Firelogger
    autoload :VERSION, 'rack/firelogger/version'
    autoload :Logger, 'rack/firelogger/logger'

    attr_reader :password

    def initialize(app, options={})
      @app = app

      yield self if block_given?
    end

    # The Rack call interface. The receiver acts as a prototype and runs
    # each request in a dup object unless the +rack.run_once+ variable is
    # set in the environment.
    def call(env)
      do_log = env['HTTP_X_FIRELOGGER']
      if do_log
        env['firelogger'] = @logger = Logger.new

        began_at = Time.now
        status, header, body = @app.call(env)
        header = Utils::HeaderHash.new(header)

        id = rand(0xffffffff)
        @logger.encode.each_with_index do |chunk, i|
          header["FireLogger-#{id}-#{i}"] = chunk
        end

        [status, header, body]
      else
        @app.call env
      end
    end
  end
end
