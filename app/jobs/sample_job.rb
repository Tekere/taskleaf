class SampleJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Sidekiq::Loagging.logger.info "サンプルが実行されました。"
  end
end
