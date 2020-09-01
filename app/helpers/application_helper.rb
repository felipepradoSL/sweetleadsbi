module ApplicationHelper

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def custom_date date
    return nil if date.blank?
    begin
      data = (l (date.to_datetime).to_date,format: :default)
       return data
    rescue ArgumentError
      return date
    end
  end


end


