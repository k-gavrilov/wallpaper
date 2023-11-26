class StaticPagesController < ApplicationController
  skip_before_action :authenticate
  before_action :find_categories, only: [:contact, :license, :privacy_policy]

  def contact
  end

  def license
  end

  def privacy_policy
  end
end
