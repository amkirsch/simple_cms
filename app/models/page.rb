class Page < ActiveRecord::Base
  belongs_to :subject
  has_many :sections
  has_and_belongs_to_many :editors, class_name: "AdminUser" #, :join_table => "admin_users_pages"

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
end
