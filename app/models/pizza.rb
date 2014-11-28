class Pizza
  
  include Mongoid::Document
  
  validates_presence_of :author
  
  field :motivo, type: String
  
  belongs_to :author
  
  def self.group_by_author
    result = collection.aggregate("$group" => { "_id" => "$author_id", count: {"$sum" =>  1} })
    
    map = {}
    result.each {
      |v| map[Author.find(v["_id"]).name] = v["count"] 
    }
    
    map.sort
  end
end