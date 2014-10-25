json.array!(@tickets) do |ticket|
  json.extract! ticket, :id, :customer_name, :customer_email, :department_id, :subject, :body, :ref
  json.url ticket_url(ticket, format: :json)
end
