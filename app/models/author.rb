class Author
  include Mongoid::Document
  
  validates_presence_of :name, :nickname
  validates :name, :nickname, uniqueness: { case_sensitive: false }
  
  field :name, type: String
  field :nickname, type: String 
  
  has_many :posts
end
