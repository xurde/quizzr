xml.instruct!
xml.tag!(:recent_activity_for_member.to_s.dasherize) do
  render :partial => "member", :locals => {:member => @member, :doc => xml}
  xml.photos do
    render :partial => "api/photos/photo", :collection => @member.photos, :locals => {:thumb => :small, :doc => xml}
  end
  xml.friends do
    render :partial => "member", :collection => @member.friends, :locals => {:doc => xml}
  end
end