class TimeoutLoggerMiddleware
    def initialize(app, max_runtime: 120)
      @app = app
      @max_runtime = max_runtime
    end
  
    def call(env)
      start_time = Time.now
      status, headers, body = @app.call(env)
      duration = Time.now - start_time
  
      if duration > @max_runtime
        Rails.logger.warn "Long request detected: #{env['REQUEST_PATH']}, Duration: #{duration} seconds"
      end
  
      [status, headers, body]
    end
  end
  