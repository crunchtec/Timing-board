  $(function() {
    $('#control-interface-main-switch').change(function() {
      if ($('#main-switch').prop('checked') == true) {
        $('#main-switch-status').val('checked');
      } else {
        $('#main-switch-status').val('unchecked');
      }
      $(this).submit();
    });

    $('ul#delay-tabs').on('load', function(){
        console.log("delay tabs loaded...");
        var lastTab = $('#last-delay-tab').val();
        console.log(lastTab);
        if (lastTab == "ch_a") {
          $('.nav-tabs a[href="#ch_a"]').tab('show');
        } else if (lastTab == "ch_b") {
          $('.nav-tabs a[href="#ch_b"]').tab('show');
        }
    });

    $('#delay-tabs').ready(function(){
        console.log("delay-tabs ready...")
        var lastTab = $('#last-delay-tab').val();
        console.log(lastTab);
        if (lastTab == "ch_a") {
          $('.nav-tabs a[href="#ch_a"]').tab('show');
        } else if (lastTab == "ch_b") {
          $('.nav-tabs a[href="#ch_b"]').tab('show');
        } else if (lastTab == "ch_c") {
          $('.nav-tabs a[href="#ch_c"]').tab('show');
        } else if (lastTab == "ch_d") {
          $('.nav-tabs a[href="#ch_d"]').tab('show');
        }
    });

    $('#ch-a-control-interface').change(function() {
      $(this).submit();
    });
    $('#ch-b-control-interface').change(function() {
      $(this).submit();
    });
    $('#command-history').change(function() {
      var command_index = 0
      $('#command-history option:selected').each(function(){
        command_index = $(this).index();
        $('#response-history').prop('selectedIndex', command_index);
      });
      $('#any-command').val($(this).val());
      $('#any-command').focus();
    });

    $('#response-history').change(function() {
      var response_index = 0
      $('#response-history option:selected').each(function(){
        response_index = $(this).index();
        $('#command-history').prop('selectedIndex', response_index).change();
      });
    });

    $('#channel_a_delay_up').click(function(){
      var current_value = 0
      var increment = 0
      var min_delay = 0
      var max_delay = 0
      min_delay = parseInt($('#channel_a_delay_value').attr('min'));
      max_delay = parseInt($('#channel_a_delay_value').attr('max'));
      current_value = parseInt($('#channel_a_delay_value').val());
      if (current_value != max_delay) {
        
        if ($("input[id='channel_a_step_size_0']").is(':checked')) {
          increment = parseInt($('#channel_a_step_size_0').val());
        } else if ($("input[id='channel_a_step_size_1']").is(':checked')) {
          increment = parseInt($('#channel_a_step_size_1').val());
        } else if ($("input[id='channel_a_step_size_2']").is(':checked')) {
          increment = parseInt($('#channel_a_step_size_2').val());
        } else if ($("input[id='channel_a_step_size_3']").is(':checked')) {
          increment = parseInt($('#channel_a_step_size_3').val());
        }
        if ((current_value + increment) < max_delay) {
          $('#channel_a_delay_value').val(
            parseInt($('#channel_a_delay_value').val()) + increment
          );
        } else {
          $('#channel_a_delay_value').val(max_delay);        
        }
        $('#ch-a-control-interface').submit();

      }
    });

    $('#channel_a_delay_down').click(function(){
      var current_value = 0
      var decrement = 0
      var min_delay = 0
      var max_delay = 0
      min_delay = parseInt($('#channel_a_delay_value').attr('min'));
      max_delay = parseInt($('#channel_a_delay_value').attr('max'));
      current_value = parseInt($('#channel_a_delay_value').val());
      if (current_value != min_delay) {
        
        if ($("input[id='channel_a_step_size_0']").is(':checked')) {
          decrement = parseInt($('#channel_a_step_size_0').val());
        } else if ($("input[id='channel_a_step_size_1']").is(':checked')) {
          decrement = parseInt($('#channel_a_step_size_1').val());
        } else if ($("input[id='channel_a_step_size_2']").is(':checked')) {
          decrement = parseInt($('#channel_a_step_size_2').val());
        } else if ($("input[id='channel_a_step_size_3']").is(':checked')) {
          decrement = parseInt($('#channel_a_step_size_3').val());
        }
        if ((current_value - decrement) > min_delay) {
          $('#channel_a_delay_value').val(
            parseInt($('#channel_a_delay_value').val()) - decrement
          );
        } else {
          $('#channel_a_delay_value').val(min_delay);
        }
        $('#ch-a-control-interface').submit();

      }
    });



    $('#channel_b_delay_up').click(function(){
      var current_value = 0
      var increment = 0
      var min_delay = 0
      var max_delay = 0
      min_delay = parseInt($('#channel_b_delay_value').attr('min'));
      max_delay = parseInt($('#channel_b_delay_value').attr('max'));
      current_value = parseInt($('#channel_b_delay_value').val());
      if (current_value != max_delay) {
        
        if ($("input[id='channel_b_step_size_0']").is(':checked')) {
          increment = parseInt($('#channel_b_step_size_0').val());
        } else if ($("input[id='channel_b_step_size_1']").is(':checked')) {
          increment = parseInt($('#channel_b_step_size_1').val());
        } else if ($("input[id='channel_b_step_size_2']").is(':checked')) {
          increment = parseInt($('#channel_b_step_size_2').val());
        } else if ($("input[id='channel_b_step_size_3']").is(':checked')) {
          increment = parseInt($('#channel_b_step_size_3').val());
        }
        if ((current_value + increment) < max_delay) {
          $('#channel_b_delay_value').val(
            parseInt($('#channel_b_delay_value').val()) + increment
          );
        } else {
          $('#channel_b_delay_value').val(max_delay);        
        }
        $('#ch-b-control-interface').submit();

      }
    });

    $('#channel_b_delay_down').click(function(){
      var current_value = 0
      var decrement = 0
      var min_delay = 0
      var max_delay = 0
      min_delay = parseInt($('#channel_b_delay_value').attr('min'));
      max_delay = parseInt($('#channel_b_delay_value').attr('max'));
      current_value = parseInt($('#channel_b_delay_value').val());
      if (current_value != min_delay) {
        
        if ($("input[id='channel_b_step_size_0']").is(':checked')) {
          decrement = parseInt($('#channel_b_step_size_0').val());
        } else if ($("input[id='channel_b_step_size_1']").is(':checked')) {
          decrement = parseInt($('#channel_b_step_size_1').val());
        } else if ($("input[id='channel_b_step_size_2']").is(':checked')) {
          decrement = parseInt($('#channel_b_step_size_2').val());
        } else if ($("input[id='channel_b_step_size_3']").is(':checked')) {
          decrement = parseInt($('#channel_b_step_size_3').val());
        }
        if ((current_value - decrement) > min_delay) {
          $('#channel_b_delay_value').val(
            parseInt($('#channel_b_delay_value').val()) - decrement
          );
        } else {
          $('#channel_b_delay_value').val(min_delay);
        }
        $('#ch-b-control-interface').submit();

      }
    });





  });