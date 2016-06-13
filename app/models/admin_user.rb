class AdminUser < ActiveRecord::Base
  # To configure a different table name
  # self.table_name = "admin_users"

  has_secure_password # includes everything we need
  # # # What has_secure_password does:
  # attr_reader :password
  ##password=(unencrypted_password)

  # validates_presence_of :password, on: :create
  # validates_presence_of :password_confirmation
  # validates_confirmation_of :password

  ##authenticate(unencrypted_password)

  has_and_belongs_to_many :pages#, :join_table => "admin_users_pages"
  has_many :section_edits
  has_many :sections, through: :section_edits

  EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i
  FORBIDDEN_USERNAMES = ['littlebopeep','humptydumpty','marymary', 'adminuser', 'admin']

  # validates_presence_of :first_name
  # validates_length_of :first_name, :maximum => 25
  # validates_presence_of :last_name
  # validates_length_of :last_name, :maximum => 50
  # validates_presence_of :username
  # validates_length_of :username, :within => 8..25
  # validates_uniqueness_of :username
  # validates_presence_of :email
  # validates_length_of :email, :maximum => 100
  # validates_format_of :email, :with => EMAIL_REGEX
  # validates_confirmation_of :email

  # shortcut validations, aka "sexy validations"
  validates :first_name, presence: true, length: {maximum: 25}
  validates :last_name, presence: true, length: {maximum: 50}
  validates :username, uniqueness: true, length: {within: 8..25}
  validates :email, :presence => true,
                    :length => { :maximum => 100 },
                    :format => EMAIL_REGEX,
                    :confirmation => true

  validate :username_is_allowed
  validate :no_new_users_on_saturday, on: :create

  scope :sorted, lambda { order("last_name ASC, first_name ASC") }

  def name
    "#{first_name} #{last_name}"
  end

  private

  def username_is_allowed
    if FORBIDDEN_USERNAMES.include?(username)
      errors.add(:username, "has been restricted from use.")
    end
  end

  # Errors not related to a specific attribute
  # can be added to errors[:base]
  def no_new_users_on_saturday
    if Time.now.wday == 6
      errors[:base] << "No new users on Saturdays."
    end
  end

end
