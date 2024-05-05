class Buffet < ApplicationRecord
  belongs_to :user
  has_one :address
  has_many :buffet_payment_methods
  has_many :payment_methods, through: :buffet_payment_methods
  has_many :events

  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :buffet_payment_methods

  validates :brand_name, presence: true
  validates :brand_name, uniqueness: true
  validates :company_name, presence: true
  validates :crn, presence: true
  validates :crn, uniqueness: true
  validates :brand_name, uniqueness: true
  validates :phone, presence: true
  validates :email, presence: true
  validates :description, presence: true
  validate :at_least_one_payment_method
  validate :valid_crn

  def buffet_payment_method_options
    self.buffet_payment_methods.map do |buffet_payment_method|
      [buffet_payment_method.payment_method.id, buffet_payment_method.payment_method.name]
    end
  end

  private

  def at_least_one_payment_method
    errors.add(:payment_methods, "deve ter no mínimo uma opção selecionada") if payment_methods.empty?
  end

  def valid_crn
    errors.add(:crn, "inválido") unless CNPJ.valid?(crn)
  end
end