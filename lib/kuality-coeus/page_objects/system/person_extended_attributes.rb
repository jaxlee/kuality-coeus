class PersonExtendedAttributes < BasePage

  document_header_elements
  global_buttons
  description_field

  element(:primary_title) { |b| b.frm.text_field(name: 'document.newMaintainableObject.primaryTitle') }
  element(:directory_title) { |b| b.frm.text_field(name: 'document.newMaintainableObject.directoryTitle') }
  element(:citizenship_type) { |b| b.frm.select(name: 'document.newMaintainableObject.citizenshipTypeCode') }
  element(:era_commons_user_name) { |b| b.frm.text_field(name: 'document.newMaintainableObject.eraCommonUserName') }
  element(:graduate_student_count) { |b| b.frm.text_field(name: 'document.newMaintainableObject.businessObject.personCustomDataList[6].value') }
  element(:billing_element) { |b| b.frm.text_field(name: 'document.newMaintainableObject.businessObject.personCustomDataList[2].value') }
  
end