require 'io/console'
require 'jiraSOAP'

module Cucumber
  module Jira
    class Soap
      def initialize(host, username = nil, password = nil)
        Cucumber::Jira.client = JIRA::JIRAService.new(host)

        if username && password
          login(username, password)
        end
      end

      def login(username, password, prompt = false)
        Cucumber::Jira.client.login(username, password)
      rescue Handsoap::Fault => e
        if prompt
          print 'Enter your username: '
          username = $stdin.gets.chomp

          print 'Enter your password: '
          password = $stdin.noecho(&:gets).chomp

          Cucumber::Jira.client.login(username, password)
        else
          raise e
        end
      end

      def search(query_hash)
        query = query_hash[:project]

        if query_hash[:themes]
          query << " Theme = '"
          query << query_hash[:themes].join("' AND Theme = '")
          query << "'"
        end

        query << " #{query_hash[:misc]}" if query_hash[:misc]

        Cucumber::Jira.client.issues_from_jql_search(query).map { |issue|
          {
            key:          issue.key,
            summary:      issue.summary,
            description:  issue.description,
            fix_versions: issue.fix_versions,
            # TODO: Does customfield_10571 always map to the themes field?
            themes:       issue.custom_field_values.find { |field| field.id == 'customfield_10571' }.values
          }
        }
      end
    end
  end
end
