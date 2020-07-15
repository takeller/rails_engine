module Searchable
  def format_params(params)
    search_params = format_input_params(params)

    search_template = ""
    search_values = ""
    counter = 0
    search_params.each do |attribute, search_param|

      if attribute == 'name' || attribute == 'description'
        search_param = "%#{search_param.downcase}%"
        attribute = "lower(#{attribute})"
      end

      if attribute.include?("_at")
        search_template << " and #{attribute} >= ? and #{attribute} < ?"
        search_values << ", #{search_param.to_datetime}, #{search_param.to_datetime + 2.seconds}"
      elsif attribute == 'unit_price'
        search_template << " and #{attribute} = ?"
        search_values << ", #{search_param}"
      else
        search_template << " and #{attribute} like ?"
        search_values << ", #{search_param}"
      end
      counter += 1
    end
    [search_template[5..-1], search_values[2..-1].split(',')].flatten
  end

  private

  def format_input_params(input_params)
    {
      'name' => input_params[:name],
      'description' => input_params[:description],
      'unit_price' => input_params[:unit_price],
      'created_at' => input_params[:created_at],
      'updated_at' => input_params[:updated_at]
    }.compact
  end
end
