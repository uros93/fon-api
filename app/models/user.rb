class User < ApplicationRecord
	has_secure_password

	validates_presence_of :name, :email, :password_digest
	validates_uniqueness_of :name, :email
end
