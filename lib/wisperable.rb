require 'active_support'
require 'wisper'
require 'wisperable/version'

module Wisperable
  module Model
    extend ActiveSupport::Concern

    module ClassMethods
      attr_reader :wisperable_opts

      private

      def wisperable(opts = {})
        @wisperable_opts = opts
      end
    end

    included do
      include Wisper::Publisher

      after_commit  :broadcast_after_created,  on: :create
      after_commit  :broadcast_after_updated,  on: :update
      after_commit  :broadcast_after_destroyed, on: :destroy
    end

    private

    def opts
      self.class.wisperable_opts || {}
    end

    def events
      opts[:events] || []
    end

    def publish_key
      opts[:publish_key] || self.class.model_name.param_key
    end

    def event_enabled?(event)
      events.include?(event)
    end

    def broadcast_after_created
      broadcast("#{publish_key}_created", self) if event_enabled?(:created)
    end

    def broadcast_after_updated
      broadcast("#{publish_key}_updated", self, previous_changes) if event_enabled?(:updated)
    end

    def broadcast_after_destroyed
      broadcast("#{publish_key}_destroyed", attributes) if event_enabled?(:destroyed)
    end
  end
end