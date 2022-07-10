class User < ApplicationRecord
  after_update :prevent_to_role_empty
  after_destroy :prevent_to_role_empty
  has_many :tasks, dependent: :destroy
  validates :email, uniqueness: true
  # accepts_nested_attributes_for :tasks
  has_secure_password

  def prevent_to_role_empty
    # byebug
    # begin
    # if User.where(admin: true).count >= 6
    # ActiveRecord::Rollback
    throw(:abort) if User.where(admin: true).count < 1
    # end
    # rescue
      # byebug
      # ActiveRecord::Rollback
      # redirect_to admin_users_path
    # end
  end

end
