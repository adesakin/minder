require 'test_helper'

class CustomerControllerTest < ActionController::TestCase
  setup do
    @ticket = tickets(:one)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ticket" do
    assert_difference('Ticket.count') do
      post :create, ticket: { body: @ticket.body, customer_email: @ticket.customer_email, customer_name: @ticket.customer_name, department_id: @ticket.department_id, subject: @ticket.subject }
    end
    assert_redirected_to customer_ticket_path(assigns(:ticket))
  end


  test "should get update" do
    get :update
    assert_response :success
  end

end
