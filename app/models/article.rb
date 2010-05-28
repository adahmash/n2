class Article < ActiveRecord::Base

  acts_as_voteable
  acts_as_taggable_on :tags, :sections
  acts_as_featured_item
  acts_as_moderatable
  acts_as_media_item
  acts_as_refineable

  has_one :content
  belongs_to :author, :class_name => "User"

  named_scope :newest, lambda { |*args| { :order => ["created_at desc"], :limit => (args.first || 10)} }
  named_scope :featured, lambda { |*args| { :conditions => ["is_featured=1"],:order => ["featured_at desc"], :limit => (args.first || 1)} }
  #named_scope :top, lambda { |*args| { :order => ["votes_tally desc, created_at desc"], :limit => (args.first || 10)} }

  accepts_nested_attributes_for :content

  validates_presence_of :body
  
  before_save :sanitize_body
  
  private
  
  def sanitize_body
    self.body = self.body.sanatize_standard
  end
end
