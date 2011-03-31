// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function navigate_question(trans_type, question_id) {
	var idx = QUESTION_IDS.indexOf(question_id);
	$('#question_' + question_id).fadeOut('fast',function() {
		//fade out is done now
		if (trans_type == 'next') {
			idx++;
		} else {
			idx--;
		}
		question_id = QUESTION_IDS[idx];
		if ($('#question_' + question_id).length > 0) {
			$('#question_' + question_id).fadeIn();
		}
	});
}
