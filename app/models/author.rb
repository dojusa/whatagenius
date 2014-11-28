class Author
  include Mongoid::Document
  include Mongoid::Paperclip
  
  has_mongoid_attached_file :avatar, styles: {
    small: '30x30',
    square: '100x100#'
  }
  
  validates_attachment :avatar, 
    :size => { :in => 0..2.megabytes },
    :content_type => { :content_type => /\Aimage\/.*\Z/ }
  
  validates_presence_of :name, :nickname
  validates :name, :nickname, uniqueness: { case_sensitive: false }
  
  field :name, type: String
  field :nickname, type: String 
  field :description, type: String
  
  has_many :posts, dependent: :restrict
  has_many :pizzas
  
end
