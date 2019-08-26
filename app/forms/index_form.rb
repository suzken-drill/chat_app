class IndexForm
	include ActiveModel::Model

	attr_accessor  :name
	
	validates :name, :presence => {:message => "表示を入力して下さい"}

end