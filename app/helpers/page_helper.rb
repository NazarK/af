module PageHelper
  def errorLabel id
    if @errorFields[id] then 'errorLabel' end
  end

  def errorInput id
    if @errorFields[id] then 'errorInput' end
  end

  def session_value object, property
    if session[object]
      session[object][property]
    end
  end
  
  def errorSpan id
    if @errorFields[id] then 'errorSpan' end
  end
end
