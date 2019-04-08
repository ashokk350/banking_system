class UsersController < ApplicationController
	def index
		@users = User.where(role: 'user')
	end
end
