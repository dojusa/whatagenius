class Post
  include Mongoid::Document
  include Mongoid::Search
  
  validates_presence_of :body, :title, :author, :date
  
  field :title, type: String
  field :body, type: String
  field :likes, type: Integer, default: 0
  field :date, type: DateTime
  
  belongs_to :author
  
  search_in :title, :author => [:name, :nickname]
  
  def self.full_search(search)
    
    unless search.nil? || search.empty?
      search("#{search}")
    else
      desc(:date)
    end
  end
end
