class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :replies
  has_many :tickets

  def self.formatted_all_records
    User.all.map {|t| [t.email, t.email]}
  end
end
