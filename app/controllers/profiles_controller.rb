class ProfilesController < ApplicationController
    before_action :authenticate_user!
    before_action :only_current_user
    
    def new
       # Form where a user can fill out own profile.
      @user = User.find( params[:user_id] )
      @profile = Profile.new
    end
    
    def create
       # This comes from the URL
       @user = User.find( params[:user_id] )
       @profile = @user.build_profile(profile_params)
       
       if @profile.save
           flash[:success] = "Profile Updated!"
           redirect_to user_path( params[:user_id] )
       else
           render action: :new
       end
    end
    
    def edit
        @user = User.find( params[:user_id] )
        @profile = @user.profile
    end
    
    def update
        @user = User.find( params[:user_id] )
        @profile = @user.profile
        if @profile.update_attributes(profile_params)
            flash[:success] = "Profile Updated!"
            redirect_to user_path( params[:user_id] )
        else
            render action: :edit
        end
    end
    
    private
        def profile_params
            params.require(:profile).permit(:first_name, :last_name, :avatar, :job_title, :phone_number, :contact_email, :description)
        end
        
        def only_current_user
            @user = User.find(params[:user_id])
            # @user is passed in from URL, current_user is a devise thing
            redirect_to(root_url) unless @user == current_user
        end
end