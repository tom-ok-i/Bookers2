class RelationshipsController < ApplicationController
    
  def create
      other_user = User.find(params[:user_id])
      @rel = Relationship.new(follower_id: current_user.id,
                              followed_id: other_user.id
                              )
    @rel.save
      redirect_back(fallback_location: root_path)
  end
  
  def destroy
      @rel = Relationship.find(params[:id])
      @rel.destroy
      redirect_back(fallback_location: root_path)
  end 

end
