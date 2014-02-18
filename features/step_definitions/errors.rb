#----------------------#
# Add to the error message hash in situations that throw uncomplicated errors.
# $current_page makes this possible.
#----------------------#
Then /^an error should appear that says (.*)$/ do |error|
  errors = {'at least one principal investigator is required' => 'There is no Principal Investigator selected. Please enter a Principal Investigator.',
            'to select a valid unit' => 'Please select a valid Unit.',
            'a key person role is required' => 'Key Person Role is a required field.',
            'the credit split is not a valid percentage' => 'Credit Split is not a valid percentage.',
            'only one PI is allowed' => 'Only one proposal role of Principal Investigator is allowed.',
            'the IP can not be added because it\'s not fully approved' => 'Cannot add this funding proposal. The associated Development Proposal has "Approval Pending - Submitted" status.',
            'approval should occur later than the application' => 'Approval Date should be the same or later than Application Date.',
            'the user already holds investigator role' => %|#{@first_name} #{@last_name} already holds Investigator role.|,
            'not to select other roles alongside aggregator' => 'Do not select other roles when Aggregator is selected.',
            'the lead unit code is invalid' => 'Lead Unit is invalid.',
            'the co-investigator requires at least one unit' => %|At least one Unit is required for #{@proposal.key_personnel.co_investigator.full_name}.|,
            'only one version can be final' => 'Only one Budget Version can be marked "Final".',
            'the investigators are not all certified' => %|The Investigators are not all certified. Please certify #{@proposal.key_personnel[0].first_name}  #{@proposal.key_personnel[0].last_name}.|,
            'a revision type must be selected' => 'S2S Revision Type must be selected when Proposal Type is Revision.',
            'I need to select the Other revision type' => %|The revision 'specify' field is only applicable when the revision type is "Other"|,
            'an original proposal ID is needed'=>'Please provide an original institutional proposal ID that has been previously submitted to Grants.gov for a Change\/Corrected Application.',
            'the prior award number is required'=> %|require the sponsor's prior award number in the "sponsor proposal number."|,
            'sponsor deadline date not entered' => 'Sponsor deadline date has not been entered.',
            'questionnaire must be completed' => %|You must complete the questionnaire "S2S FAT &amp; Flat Questionnaire"|,
            'you must complete the compliance question' => 'Answer is required for Question 1 in group B. Compliance.',
            'proposal questions were not answered' => 'Answer is required for Question 1 in group A. Proposal Questions.',
            'a valid sponsor is required' => 'A valid Sponsor Code (Sponsor) must be selected.',
            'the duplicate organizations is shown' => '',
            'the terms are missing' => ''

  }
  $current_page.errors.should include errors[error]
end

Then /^an error should appear indicating the field is required$/ do
  error = case @required_field
            when 'Description'
              "Document #{@required_field} is a required field."
            when /Obligation/
              "#{@required_field} is required when Obligated Amount is greater than zero."
            when 'Lead Unit'
              'Lead Unit ID (Lead Unit ID) is a required field.'
            when 'Activity Type', 'Transaction Type', 'Award Status', 'Award Type', 'Project End Date'
              "#{@required_field} (#{@required_field}) is a required field."
            when 'Award Title'
              "#{@required_field} (Title) is a required field."
            when 'Anticipated Amount'
              'The Anticipated Amount must be greater than or equal to Obligated Amount.'
            else
              "#{@required_field} is a required field."
          end
  $current_page.error_summary.wait_until_present(5)
  $current_page.errors.should include error
end

Then(/^an error notification should say the field is required$/) do
  error = case @required_field
            when 'Description'
              "Document #{@required_field} is a required field."
            when 'Proposal Type'
              'Proposal Type (Proposal Type Code) is a required field.'
            when 'Activity Type'
              'Activity Type (Activity) is a required field.'
            when 'Project Title'
              "#{@required_field} (Title) is a required field."
            when 'Sponsor ID'
              'Sponsor ID (Sponsor ID) is a required field.'
          end
  $current_page.errors.should include error
end