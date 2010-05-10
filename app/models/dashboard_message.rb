class DashboardMessage < ActiveRecord::Base
  validates_presence_of :message  
  validates_length_of   :message,    :within => 3..50
  validates_length_of   :action_text,    :within => 3..25
  validates_format_of :action_url, :with => /\Ahttp(s?):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?/i, :message => "should look like a URL", :allow_blank => true
  
  named_scope :newest, lambda { |*args| { :order => ["created_at desc"], :limit => (args.first || 1)} }
end
