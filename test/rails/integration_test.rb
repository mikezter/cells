require 'test_helper'

class RailsIntegrationTest < ActionController::TestCase
  tests MusicianController
  
  context "A Rails controller" do
    should "respond to render_cell" do
      get 'promotion'
      assert_equal "That's me, naked <img alt=\"Me\" src=\"/images/me.png\" />", @response.body
    end
    
    should "respond to render_cell in the view without escaping twice" do
      BassistCell.class_eval do
        def provoke; render; end
      end
      get 'featured'
      assert_equal "That's me, naked <img alt=\"Me\" src=\"/images/me.png\" />", @response.body
    end
    
    should "respond to render_cell in a haml view" do
      BassistCell.class_eval do
        def provoke; render; end
      end
      get 'hamlet'
      assert_equal "That's me, naked <img alt=\"Me\" src=\"/images/me.png\" />\n", @response.body
    end
    
    should "make params (and friends) available in a cell" do
      BassistCell.class_eval do
        def listen
          render :text => "That's a #{params[:note]}"
        end
      end
      get 'skills', :note => "D"
      assert_equal "That's a D", @response.body
    end
  end
  
end
