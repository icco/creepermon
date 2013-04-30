class User < ActiveRecord::Base
  def self.factory name
    return User.find_or_create_by_name name
  end
end
