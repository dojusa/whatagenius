class Ability
  include CanCan::Ability

  def initialize(user)
  
    can :create, :all
    
    if user.nil?
      cannot [:update, :destroy], :all
    else
      
      if user.admin?
        can :manage, :all
      end
      
      can [:update, :destroy], Post, :user_id => user.id
    end
  end
end
