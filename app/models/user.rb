class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :initials, :role
  # attr_accessible :title, :body
  
  ROLES = %w[superadmin manager doctor]
  

  
  def role?(role)
    return self.role == role.to_s
  end
  
  def get_user
    @current_user = current_user
  end
end
