class Post
  include Mongoid::Document
  
  validates_presence_of :body, :title, :author, :date
  
  field :title, type: String
  field :body, type: String
  field :likes, type: Integer, default: 0
  field :date, type: Date
  
  belongs_to :author
end
