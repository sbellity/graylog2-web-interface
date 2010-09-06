class Incident
  include MongoMapper::Document

  key :title, String
  key :timerange, Integer

  validates_presence_of :title
  validates_length_of :title, :within => 0..75
end
