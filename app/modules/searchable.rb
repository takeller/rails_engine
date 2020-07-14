module Searchable
  def format_params(params)
    {
      name: params[:name],
      created_at: params[:created_at],
      updated_at: params[:updated_at]
    }.compact
  end
end
