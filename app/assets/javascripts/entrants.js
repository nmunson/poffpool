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
  enableSubmit();
}

function enableSubmit() {
  if ($('#requirements li.success').length == $('#requirements li').length) {
    $('input[type="submit"]').removeAttr('disabled');
  }
}

function checkOnePlayerPerTeam() {
  var rows = $("#player_selection tr:gt(0)");
  var teamSuccessCount = 0;
  var failure = false;

  //check for failure
  rows.each(function(index) {
    var row_count = 0
    $(this).find("input").each(function() {
      if ($(this).attr('checked') && $(this).data('type') != 'mulligan') {
        row_count += 1;
      }
    });
    if (row_count > 1) {
      console.log('Too many players in a single team');
      $('#one-player-per-team').removeClass('failure').addClass('error');
      failure = true;
    }
    else if (row_count == 1) {
      teamSuccessCount += 1;
    }
  });

  //check for success
  if (failure)
    return;
  else if (teamSuccessCount == 16) {
    $('#one-player-per-team').removeClass('error').addClass('success');
  }
  else {
    $('#one-player-per-team').removeClass('success').removeClass('error');
  }
}

function checkThreePlayersColumn(column) {
  //check for failure
  if ($('input[data-type=' + column + ']:checked').length > 3) {
    $('#three-players-per-' + column).removeClass('success').addClass('error');
    console.log('Too many players in ' + column);
  }
  else if ($('input[data-type=' + column + ']:checked').length == 3) {
    $('#three-players-per-' + column).removeClass('error').addClass('success');
  }
  else {
    $('#three-players-per-' + column).removeClass('error').removeClass('success');
  }
}

function checkOneGoalie() {
  if ($('input[data-type="goalie"]:checked').length > 1) {
    $('#one-goalie').removeClass('success').addClass('error');
    console.log('Too many goalies');
  }
  else if ($('input[data-type="goalie"]:checked').length == 1) {
    $('#one-goalie').removeClass('error').addClass('success');
  }
  else {
    $('#one-goalie').removeClass('error').removeClass('success');
  }
}

function checkMulliganMan() {
  if ($('input[data-type="mulligan"]:checked').length > 1) {
    $('#one-mulligan-man').removeClass('success').addClass('error');
    console.log('Too many mulligan men');
  }
  else if ($('input[data-type="mulligan"]:checked').length == 1) {
    var team = $('input[data-type="mulligan"]:checked').data('team');
    if ($('input[data-type="goalie"]:checked').length == 1 && $('input[data-type="goalie"]:checked').data('team') == team) {
      $('#one-mulligan-man').removeClass('success').addClass('error');
      console.log('Goalie can not be from same team as mulligan');
    }
    else {
      $('#one-mulligan-man').removeClass('error').addClass('success');
    }
  }
  else {
    $('#one-mulligan-man').removeClass('error').removeClass('success');
  }
}