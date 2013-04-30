class User < ActiveRecord::Base
  validates_format_of :name, :with => /^[-a-z0-9_+\.]+$/i
  validates_uniqueness_of :name

  def self.factory name
    return User.find_or_create_by_name name
  end
end
