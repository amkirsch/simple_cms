class Page < ActiveRecord::Base
  has_many :sections

  belongs_to :subject
  has_and_belongs_to_many :editors, class_name: "AdminUser" #, :join_table => "admin_users_pages"

  scope :visible, lambda { where(visible: true) }
  scope :invisible, lambda { where(visible: false) }
  scope :sorted, lambda { order("pages.position ASC") }
end
