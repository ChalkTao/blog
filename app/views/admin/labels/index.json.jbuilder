	json.array!(@labels) do |label|
  json.extract! label, :id, :name
  json.url admin_label_url(label, format: :json)
end
