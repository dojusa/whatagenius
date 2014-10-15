class Post
  include Mongoid::Document
  include Mongoid::Search
  include Mongoid::Paperclip
  
  has_mongoid_attached_file :file, styles: {
    post: '640x480>'
  }
  
  validates_attachment :file, 
    :size => { :in => 0..2.megabytes },
    :content_type => { :content_type => /\Aimage\/.*\Z/ }

  validates_presence_of :title
  validates_presence_of :body, :unless => :file?
  validates_presence_of :author, :date
  
  field :title, type: String
  field :body, type: String
  field :date, type: DateTime
  
  has_many :likes
  
  belongs_to :author
  
  def author_name
    if(self.author?)
      return self.author.name
    else
      return ""
    end
  end
  
  search_in :title, :author => [:name, :nickname]
  
  def self.full_search(search)
    
    unless search.nil? || search.empty?
      search("#{search}")
    else
      desc(:date)
    end
  end
end
