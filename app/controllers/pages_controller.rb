class PagesController < ApplicationController
  before_filter :get_event_counts


  def get_event_counts
    @high ||= Event.find(:all, :include => :sig, :conditions => ['signature.sig_priority = 1']).size
    @medium ||= Event.find(:all, :include => :sig, :conditions => ['signature.sig_priority = 2']).size
    @low ||= Event.find(:all, :include => :sig, :conditions => ['signature.sig_priority = 3']).size
    @all ||= @high+@medium+@low
  end

  def dashboard
    @g_event_severity ||= open_flash_chart_object(400,200, pie_event_severity_graph_url(:high => @high, :medium => @medium, :low => @low))
    @g_category_information ||= open_flash_chart_object(400,200, bar_event_severity_graph_url(:high => @high, :medium => @medium, :low => @low, :all => @all))
    @events ||= Event.all :include => :sig
    @uniq_events ||= Event.all :group => 'signature'
    @uniq_adds ||= Iphdr.find(:all, :group => 'ip_src').uniq.size + Iphdr.find(:all, :group => 'ip_dst').uniq.size
    @categories ||= SigClass.all
    @sensors ||= Sensor.all :include => :events, :order => 'sid ASC'
  end

  def credits
  end

end
