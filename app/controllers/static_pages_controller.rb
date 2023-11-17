class StaticPagesController < ApplicationController
  skip_before_action :authenticate

  def contact
  end

  def license
  end

  def privacy_policy
  end
end
