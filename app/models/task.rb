class Task < ActiveRecord::Base
	
	belongs_to :taask_list
	validates_presence_of :title
end
