Given /^I have (.*)-Campus, (.*) type Institute Rates appropriate for the proposal$/ do |campus, rate_type|
  campus_flags = {'On-and-off'=>[:set,:clear],'On'=>[:set],'Off'=>[:clear]}
  fiscal_years = (@proposal.project_start_date[/\d+$/]..@proposal.project_end_date[/\d+$/]).to_a
  campus_flags[campus].each do |camp|
    fiscal_years.each do |year|
      rate_object = make InstituteRateObject,
                  fiscal_year: year,
                  on_off_campus_flag: camp,
                  activity_type: @proposal.activity_type,
                  rate_type: rate_type,
                  unit_number: @proposal.lead_unit[/^\w+-*\w+/]
      # TODO: Need to code the setting of the rate in the data object if there is a matching record
      if rate_object.exist?
        rate_object.get_current_rate
        rate_object.activate
      else
        rate_object.create
      end
      set("rate_#{year}_#{camp}", rate_object)
    end
  end
end