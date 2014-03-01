class User < ActiveRecord::Base
  validates_format_of :name, :with => /\A[-a-z0-9_+\.]+\z/i
  validates_uniqueness_of :name
  validates_format_of :email, :with => /@/
  has_many :sites

  def self.factory name
    u = User.find_or_create_by(name: name)
    u.save if u.id.nil?
    return u
  end
end
