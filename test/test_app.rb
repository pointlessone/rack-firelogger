class FireLoggerTestApp
  def self.call(env)

    env['firelogger'].info({
      "args" => [
        "/",
        {
          "action" => "index",
          "controller" => "welcome"
        },
        {
          "multi" => {
            "dicts" => [
              {
                "_items" => "[('action', u'index'), ('controller', u'welcome')]",
                "_" => "MultiDict([('action', u'index'), ('controller', u'welcome')])"
              },
                {
                  "reason" => "'Not a POST request'",
                  "_" => ""
              }
            ],
            "_" => "NestedMultiDict([('action', u'index'), ('controller', u'welcome')])"
          },
          "errors" => "ignore",
          "decode_keys" => true,
          "_" => "UnicodeMultiDict([(u'action', u'index'), (u'controller', u'welcome')])",
          "encoding" => "utf-8"
        }
      ],
      "name" => "www",
      "thread" => -1610029280,
      "level" => "debug",
      "process" => 64884,
      "timestamp" => 1237161193396626,
      "threadName" => "MainThread",
      "pathname" => "/opt/local/Library/Frameworks/Python.framework/Versions/2.5/lib/python2.5/logging/__init__.py",
      "lineno" => 1327,
      "template" => "Dispatching %s to %s (%s)",
      "time" => "23:53:13.396",
      "exc_text" => nil,
      "message" => "Dispatching / to {'action': u'index', 'controller': u'welcome'} (UnicodeMultiDict([(u'action', u'index'), (u'controller', u'welcome')]))"
    })

    env['firelogger'].debug(:a => 'b', :c => 42)
    env['firelogger'].info($:.join("\n"))

    begin
      boom!
    rescue Exception => e
      env['firelogger'].add_error e
      #raise e
    end

    [
      200,
      {'Content-Type' => 'text/html'},
      ['success']
    ]
  end
end
