module ApplicationHelper
  def locale_field(record, field)
    if I18n.locale == :ja
      record.send("#{field}_jp") rescue record.send("#{field}_en")
    else
      record.send("#{field}_en")
    end
  end
end
