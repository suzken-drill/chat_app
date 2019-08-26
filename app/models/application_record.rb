class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  def current_user
    User.find_by_session_key(cookies.encrypted[:session_key])
  end
end
