class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin?

      cannot :edit, :all
    else

      cannot :edit, :all
    end
  end
end
