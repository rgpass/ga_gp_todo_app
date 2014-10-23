class Task < ActiveRecord::Base
  belongs_to :user

  before_save :set_due_at
  
  validates :title, presence: true, length: { in: 3..254 }
  validates :user_id, presence: true


  def set_due_at
    # Uses provided due_at or defaults to today
    self.due_at ||= Date.today
  end
end
