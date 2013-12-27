class User < ActiveRecord::Base
  validates :name, :crypted_password, presence: true

  # If you create an object, this makes sure there is both password and
  # password_confirmation and that they are the same.
  validates :password, confirmation: true

  def password= pass
    @password = pass
    self.crypted_password = pass.nil? ? nil : ::BCrypt::Password.create(pass)
  end

  def crypted_password
    @crypted_password ||= begin
      ep = read_attribute(crypted_password)
      ep.nil? ? nil : ::BCrypt::Password.new(ep)
    end
  end
  alias_method :password, :crypted_password
end
