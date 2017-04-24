require "commands_workshop/engine"
require "waterfall"

module CommandsWorkshop
  # Your code goes here...
end

# reopening waterfall to add convenience method
# as explained in https://github.com/apneadiving/waterfall#rails-and-transactions
module Waterfall
  extend ActiveSupport::Concern

  class Rollback < StandardError; end

  def with_transaction(&block)
    ActiveRecord::Base.transaction(requires_new: true) do
      yield
      on_dam do
        raise Waterfall::Rollback
      end
    end
  rescue Waterfall::Rollback
    self
  end
end