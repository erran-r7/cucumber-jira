require 'cucumber/jira/version'
require 'cucumber/jira/soap'

module Cucumber
  module Jira
    class << self
      attr_accessor :client, :jira_version
    end

    def method_missing(method_name, *args, &block)
      if jira_version =~ /^4/
        client.send(method_name, *args, &block)
      else
        super
      end
    end

    def respond_to?(method_name, include_private = false)
      if jira_version =~ /^4/
        Cucumber::Jira::Soap.respond_to?(method_name, include_private)
      else
        super
      end
    end
  end
end
