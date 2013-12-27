class User < ActiveRecord::Base
  include BCrypt

  validates :name, :crypted_password, presence: true

  # If you create an object, this makes sure there is both password and
  # password_confirmation and that they are the same.
  validates :password, confirmation: true

  def password
    @password ||= Password.new(self.crypted_password)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.crypted_password = @password
  end
end
