require 'rho/rhoapplication'

class AppApplication < Rho::RhoApplication
  def initialize
    # Tab items are loaded left->right, @tabs[0] is leftmost tab in the tab-bar
    # Super must be called *after* settings @tabs!
    @tabs = nil
    #To remove default toolbar uncomment next line:
    #@@toolbar = nil
    super

    Rho::Application.setApplicationNotify(
      -> (x) {

          puts ">>> App notify: #{x}"

          if (x['applicationEvent']==Rho::Application::APP_EVENT_ACTIVATED)
            timer = Rho::Timer.create
            timer.start(5000, -> (x) {

              scanner = BarcodeController.scanner
              location = Rho::WebView.currentLocation

              puts "Active scanner: #{scanner}, app location: #{location}"

              if location =~ /Barcode\/enable/
                sObj = Rho::Barcode.enumerate[scanner];
                sObj.enable( {}, '/app/Barcode/barcode_callback' )
              end

              timer.stop
            })
          end
      } )
    
  end
end
