class User < ApplicationRecord
	has_secure_password
	has_many :websites

	validates_presence_of :name, :email, :password_digest
	validates_uniqueness_of :name, :email
end
