require 'rho'
require 'rho/rhocontroller'
require 'rho/rhoerror'
require 'helpers/browser_helper'

class BarcodeController < Rho::RhoController
  include BrowserHelper
  

  @@scanner = nil

  def self.scanner
    @@scanner
  end

  def index

    
    @scanners = Rho::Barcode.enumerate
    s = @params['scanner'].to_i
    @scanners[s].disable unless s.nil?

    
    #@scanners.each_with_index { |s,i| 
    #    @scanners[i].disable
    #}

    render
  end

  def enable
    @scanner = @params['scanner'].to_i
    sObj = Rho::Barcode.enumerate[@scanner];

    #sObj.code128 = true
    #sObj.ean13 = false

    #sObj.aimType = Rho::Barcode::AIMTYPE_CONTINUOUS_READ
    
    sObj.enable( {}, url_for( :action => :barcode_callback) )
    #sObj.take( {}, url_for( :action => :barcode_callback) )

    @@scanner = @scanner

    render
  end

  def barcode_callback

    Rho::WebView.executeJavascript( "updateResults('#{@params.to_s}');" )

    barcode = @params['data'] || @params['barcode']

    #unless barcode.nil?

        #frequency = barcode[0..barcode.size/2-1].to_i
        #duration = barcode[barcode.size/2..-1].to_i

        #puts "playing: frequency: #{frequency}; duration: #{duration}"

        #Rho::Notification.beep( { 'frequency' => frequency, 'duration' => duration, 'volume' => 3 } )

        #if @@scanner
        #    Rho::Barcode.enumerate[@@scanner].sameSymbolTimeout = duration
        #    Rho::Barcode.enumerate[@@scanner].differentSymbolTimeout = duration
        #end
    #end
  end
  
end
