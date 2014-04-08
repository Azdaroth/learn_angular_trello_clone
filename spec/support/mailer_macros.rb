module MailerMacros
  def last_email
    ActionMailer::Base.deliveries.last
  end

  def reset_email
    ActionMailer::Base.deliveries = []
  end

  def reset_with_delayed_job_deliveries
    ActionMailer::Base.deliveries = []
    Delayed::Job.destroy_all
  end

  def all_emails
    ActionMailer::Base.deliveries
  end

  def all_emails_sent_count
    ActionMailer::Base.deliveries.count
  end

  def all_emails_sent_count_with_dj
    ActionMailer::Base.deliveries.count + Delayed::Job.count
  end
end
