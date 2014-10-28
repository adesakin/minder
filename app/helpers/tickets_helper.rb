module TicketsHelper
  def take_button(t)
    if t.workflow_state == 'new' && controller_name == 'tickets'
      link_to 'Take', control_ticket_path(t), class: "btn button reduced radius", method: :post
    end
  end
end
