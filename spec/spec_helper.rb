require 'pg'
require 'csv_data_service'
require 'query_service'

RSpec.configure do |config|
  test_conn = PG.connect(host: 'test-postgres', dbname: 'postgres', user: 'postgres')
  config.after(:example) do 
    test_conn.exec("DROP TABLE IF EXISTS exams")
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
