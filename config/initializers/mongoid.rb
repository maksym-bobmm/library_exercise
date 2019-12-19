# frozen_string_literal: true

Mongoid.logger = Logger.new($stdout) if Rails.env.development?
