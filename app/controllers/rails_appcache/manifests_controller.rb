
class RailsAppcache::ManifestsController < RailsAppcache::ApplicationController
  include RailsAppcache::ApplicationHelper

  before_action :check_caching_enabled

  def show
    puts "params = #{params}"
    puts "Version Strings #{params[:version]} vs #{appcache_version_string}"
    if params[:version] == appcache_version_string
      puts "manifest #{params[:manifest]} event_slug #{params[:event_slug]}"
      # This is a request from a current version of the page
      @event_slug = params[:event_slug]	
      render params[:manifest]
    else
      # This is a request from an obsolete page, using an obsolete manifest
      # Serving a 404 enough to trigger an obsoletion event, which is purge
      # the manifest from the appcache.
      #
      # The client will get the correct version on the *next* page request
      display_404
    end
  end

  private

  def display_404
    render status: :not_found, text: ''
  end

  def check_caching_enabled
    display_404 unless RailsAppcache.config.perform_caching?
  end

end
