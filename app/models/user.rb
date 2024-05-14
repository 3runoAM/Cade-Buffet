class User < ApplicationRecord
  has_one :buffet
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum role: { client: 0, owner: 1 }
  validates :role, inclusion: { in: roles.keys }
  validates :name, presence: true
  validates :cpf, presence: true, if: :client?
  validates :cpf, uniqueness: true, if: :client?
  validate :cpf_valid, if: :client?

  private

  def self.role_options
    roles.keys.map { |r| [r, I18n.t("activerecord.attributes.user.roles.#{r}")]}
  end

  def client?
    role == 'client'
  end

  def owner?
    role == 'owner'
  end

  def cpf_valid
    errors.add(:cpf, I18n.t("error.invalid")) unless CPF.valid?(cpf)
  end
end