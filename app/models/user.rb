class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum role: { client: 0, owner: 1 }


  def self.role_options
    roles.keys.map { |r| [I18n.t("activerecord.attributes.user.roles.#{r}"), r]}
  end
end
