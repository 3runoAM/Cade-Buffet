class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum role: { client: 0, owner: 1 }
  validates :name, presence: true
  validates :role, inclusion: { in: roles.keys }

  private

  def self.role_options
    roles.keys.map { |r| [r, I18n.t("activerecord.attributes.user.roles.#{r}")]}
  end
end
