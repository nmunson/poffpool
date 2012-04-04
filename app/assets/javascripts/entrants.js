$(document).ready(function() {

  $('#new_entrant').change(function() {
    validateEntries();
  });
  
});

function validateEntries() {
  checkOnePlayerPerTeam();
  $.each(['col1', 'col2', 'col3', 'col4', 'col5'], function(index, value) {
    checkThreePlayersColumn(value);
  });
  checkOneGoalie();
  checkMulliganMan();
}

function checkOnePlayerPerTeam() {
  var rows = $("#player_selection tr:gt(0)");

  rows.each(function(index) {
    var row_count = 0
    $(this).find("input").each(function() {
      if ($(this).attr('checked') && $(this).data('type') != 'mulligan') {
        row_count += 1;
      }
    });
    if (row_count > 1) {
      console.log('Too many players in a single team');
    }
  });
}

function checkThreePlayersColumn(column) {
  if ($('input[data-type=' + column + ']:checked').length > 3) {
    console.log('Too many players in ' + column);
  }
}

function checkOneGoalie() {
  if ($('input[data-type="goalie"]:checked').length > 1) {
    console.log('Too many goalies');
  }
}

function checkMulliganMan() {
  if ($('input[data-type="mulligan"]:checked').length > 1) {
    console.log('Too many mulligan men');
  }
  if ($('input[data-type="mulligan"]:checked').length == 1) {
    var team = $('input[data-type="mulligan"]:checked').data('team');
    if ($('input[data-type="goalie"]:checked').length == 1 && $('input[data-type="goalie"]:checked').data('team') == team) {
      console.log('Goalie can not be from same team as mulligan');
    }
  }
}