class User < ApplicationRecord
	has_secure_password
	has_many :websites
	has_many :categories

	validates_presence_of :name, :email, :password_digest
	validates_uniqueness_of :name, :email
end
