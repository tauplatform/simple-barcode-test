require 'rho'
require 'rho/rhocontroller'
require 'rho/rhoerror'
require 'helpers/browser_helper'

class TestsController < Rho::RhoController
  include BrowserHelper
  
  def form
    render :string => @params.to_s
  end


  
end
