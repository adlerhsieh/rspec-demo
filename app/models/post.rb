class Post < ActiveRecord::Base
  validates :title, :presence => true
  has_many :comments

  def self.no_content
    where(:content => nil)
  end

  def abstract
    self.content[0..20]
  end
end
