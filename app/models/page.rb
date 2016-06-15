class Page < ActiveRecord::Base
  belongs_to :subject
  has_many :sections
  has_and_belongs_to_many :editors, class_name: "AdminUser" #, :join_table => "admin_users_pages"

  acts_as_list scope: :subject

  before_validation :add_default_permalink
  after_save :touch_subject
  after_destroy :delete_related_sections

  validates_presence_of :name
  validates_length_of :name, maximum: 255
  validates_presence_of :permalink
  validates_length_of :permalink, within: 3..255
  # use presence_of with length_of to disallow spaces
  validates_uniqueness_of :permalink
  # for unique values by subject use "scope: subject_id"
  # in other words, say we have two pages with the permalink "Resources"
  # but under two DIFFERENT subjects, we could "scope" it to allow the
  # same permalink name to be used

  scope :visible, lambda { where(visible: true) }
  scope :invisible, lambda { where(visible: false) }
  scope :sorted, lambda { order("pages.position ASC") }

  private

  def add_default_permalink
    if permalink.blank?
      self.permalink = "#{id}-#{name.parameterize}"
    end
  end

  def touch_subject
    # touch is similar to:
    # subject.update_attribute(:updated_at, Time.now)
    subject.touch
  end

  def delete_related_sections
    self.sections.each do |section|
      # Or perhaps instead of destroy, you would move them to another page
      # section.destroy
    end
  end

end
