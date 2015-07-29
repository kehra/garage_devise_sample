class User < ActiveRecord::Base
  include Garage::Representer
  include Garage::Authorizable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

   property :id
   property :email

   def self.build_permissions(perms, other, target)
     perms.permits! :read
   end

   def build_permissions(perms, other)
     perms.permits! :read
     perms.permits! :write if self == other
   end
end
