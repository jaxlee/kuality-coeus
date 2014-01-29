class ActionList < BasePage

  page_url "#{$base_url}portal.do?channelTitle=Action List&channelUrl=#{$base_url[/^.+(com|org)/]+':'+$base_url[/(?<=(com|org))(\/.+\/)$/]}kew/ActionList.do"

  search_results_table

  p_value(:action_requested) { |item_id, b| b.item_row(item_id).tds[ACTION_REQUESTED].text }
  p_value(:route_status) { |item_id, b| b.item_row(item_id).tds[ROUTE_STATUS].text }
  action(:filter) { |b| b.frm.button(name: 'methodToCall.viewFilter').click; b.loading }
  action(:take_actions) { |b| b.frm.link(id: 'takeMassActions').click; b.loading }
  p_element(:action) { |item_id, b| b.item_row(item_id).select(name: /actionTakenCd/) }
  action(:outbox) { |b| b.frm.link(href: /viewOutbox/).click }
  element(:last_button) { |b| b.frm.link(text: 'Last') }
  action(:last) { |b| b.last_button.click }
  action(:refresh) { |b| b.frm.button(name: 'methodToCall.refresh').click; b.loading }

  #Default action select list for FYIs
  action(:default_action) { |b| b.frm.select(name: 'defaultActionToTake') }
  action(:apply_default_action) { |b| b.frm.link(align: 'absmiddle').click }



end