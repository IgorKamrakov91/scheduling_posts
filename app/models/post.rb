class Post < ApplicationRecord
  scope :draft, -> { where(published_at: nil)   }
  scope :published, -> { where.not(published_at: nil).where("published_at <= ?", Time.zone.now)   }
  scope :scheduled, -> { where.not(published_at: nil).where("published_at > ?", Time.zone.now)   }

  attr_accessor :status

  before_validation :clean_up_status

  def clean_up_status
    case status
    when 'Draft'
      self.published_at = nil
    when 'Published'
      self.published_at = Time.zone.now
    else
      self.published_at = published_at
    end

    # the same thing
    # self.published_at = nil if status == 'Draft'
    # self.published_at = Time.zone.now if status == 'Published'

    # because of before_validation return statements
    true
  end
end
