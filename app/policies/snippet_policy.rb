class SnippetPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be sure to add user to resolve scope
    def resolve
      scope.all
    end
  end

  def update?
    user == record.user
  end

  def edit?
    update?
  end

  def destroy?
    user == record.user
  end

  def show?
    true # Everyone can view public snippets; adjust as needed for privacy
  end

  def create?
    user.present? # Only logged-in users can create snippets
  end

  def new?
    create?
  end
end
