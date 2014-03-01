class User < ActiveRecord::Base
  validates_format_of :name, :with => /\A[-a-z0-9_+\.]+\z/i
  validates_uniqueness_of :name
  validates_format_of :email, :with => /@/

  def self.factory name
    return User.find_or_create_by_name name
  end
end
