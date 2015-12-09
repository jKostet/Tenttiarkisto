class Course < ActiveRecord::Base

  belongs_to :subject

  validates :subject, presence: true

  def can_user_manage(user)
    self.subject.can_user_manage(user)
  end

  filterrific(
  available_filters: [
    :search_query
  ]
  )

  scope :search_query, lambda { |query|
	  return nil if query.blank?
	  where("(LOWER(courses.name) LIKE '%"+query.to_s.downcase+"%') OR (LOWER(courses.identifier) LIKE '%"+query.to_s.downcase+"%')")
	}

end
