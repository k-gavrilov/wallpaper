class StaticPagesController < ApplicationController
  layout 'clear'
  skip_before_action :authenticate
  before_action :find_collections, only: [:contact, :license, :privacy_policy]

  def contact
  end

  def license
  end

  def privacy_policy
  end
end
