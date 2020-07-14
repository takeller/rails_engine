module Searchable
  def format_params(params)
    search_params = {
      'name' => params[:name],
      'created_at' => params[:created_at],
      'updated_at' => params[:updated_at]
    }.compact

    # ("LOWER(merchants.name) LIKE LOWER('%#{search_params['name']}%')")
    # ['lower(name) = ?', "#{search_params[:name].downcase}"]
    search_template = ""
    search_values = ""
    counter = 0
    search_params.each do |attribute, search_param|
      search_param = "%#{search_param.downcase}%" if attribute == 'name'
      attribute = "lower(#{attribute})" if attribute == 'name'

      if counter == 0 && !attribute.include?("_at")
        search_template << "#{attribute} like ?"
        search_values << "#{search_param}"
      elsif attribute.include?("_at") && counter == 0
        search_template << "#{attribute} >= ? and #{attribute} < ?"
        search_values << "#{search_param.to_datetime},#{search_param.to_datetime + 2.seconds}"
      elsif attribute.include?("_at")
        search_template << " and #{attribute} >= ? and #{attribute} < ?"
        search_values << ",#{search_param.to_datetime},#{search_param.to_datetime + 2.seconds}"
      else
        search_template << " and #{attribute} like ?" if counter > 0
        search_values << ", #{search_param}" if counter > 0
      end

      counter += 1
    end
    [search_template, search_values.split(',')].flatten
  end
end
