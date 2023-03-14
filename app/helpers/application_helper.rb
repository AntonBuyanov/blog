module ApplicationHelper
  def bootstrap_class_for_flash(flash_type)
    case flash_type
    when 'success'
      'alert-success'
    when 'error'
      'alert-danger'
    when 'warning', 'alert'
      'alert-warning'
    when 'notice'
      'alert-info'
    else
      flash_type.to_s
    end
  end

  def flash_message
    tag.div id: 'flash-message' do
      render 'shared/flash'
    end
  end
end
