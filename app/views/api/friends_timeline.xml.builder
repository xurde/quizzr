xml.instruct!
xml.tag!(:recent_activity_for_member.to_s.dasherize) do
  render :partial => "member", :locals => {:member => @member, :doc => xml}
  xml.status do
    render :partial => "api/status", :collection => @quizzs
  end
end