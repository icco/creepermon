class User < ActiveRecord::Base
  include BCrypt

  has_many :sites

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

  # https://github.com/collectiveidea/delayed_job/blob/master/README.md
  def grab_config
    config = {}
    Dir.mktmpdir("creeper") do |dir|
    end
  end
  handle_asynchronously :grab_config
end
