require 'test_helper'

class TicketsControllerTest < ActionController::TestCase
  setup do
    @ticket = tickets(:one)
    user_sign_in
  end

  test "should get index" do
    get :index
    assert_redirected_to tickets_manage_path
  end

  test "should show ticket" do
    get :show, id: @ticket
    assert_response :success
  end

  test "should update ticket" do
    patch :update, id: @ticket, ticket: { body: @ticket.body, customer_email: @ticket.customer_email, customer_name: @ticket.customer_name, department: @ticket.department, subject: @ticket.subject }
    assert_redirected_to ticket_path(assigns(:ticket))
  end

  test "should destroy ticket" do
    assert_difference('Ticket.count', -1) do
      delete :destroy, id: @ticket
    end

    assert_redirected_to tickets_path
  end
end
