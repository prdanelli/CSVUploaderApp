class User < ApplicationRecord
  VALID_EMAIL_REGEX = /(.)+@(.)+\.(.)+/i.freeze

  has_many :csvs, class_name: "UserCsv"
  has_secure_password

  validates :email, presence: true, uniqueness: true, format: VALID_EMAIL_REGEX
  validates :password, presence: true, length: { in: 8..128 }
end
