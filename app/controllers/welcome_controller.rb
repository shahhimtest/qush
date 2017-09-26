class WelcomeController < ApplicationController
  def root
  end

  private

  def authorized?
    return true
  end

  def authenticated?
    return true
  end
end
