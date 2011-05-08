$(document).ready(function() {
    $('input, textarea', $('#messages')[0]).live('change', function() {
        // Submit changes
        $(this).closest('form').submit();
    });
    $('textarea', $('#messages')[0]).live('keydown', function(e) {
        // On tab or enter, focus next entry
        if ((e.ctrlKey && e.keyCode == 13) || e.keyCode == 9) {
            if (e.shiftKey) // previous
              $(this).closest('tr').prev().
                      find('textarea').focus();
            else $(this).closest('tr').next(). // next
                      find('textarea').focus();
            return false;
        }
    }).live('focusin', function() {
        $(this).addClass('current');
        $(this).closest("tr").find("td.msgid span").addClass("spaced");
    }).live('focusout', function() {
        $(this).removeClass('current');
        $(this).closest("tr").find("td.msgid span").removeClass("spaced");
    }).live('mouseenter', function() { $(this).addClass('focused');
    }).live('mouseleave', function() { $(this).removeClass('focused'); });

    $('form.msgstr-form', $('#messages')[0]).live(
        'ajax:error', function(evt, xhr, status, error) {
        stat = $(this).parent().nextAll('td.msgstatus');
        try {
            errors = $.parseJSON(xhr.responseText);
            stat.css('opacity', 1).css('background', '#D55');
            stat[0].title = errors['msgstr'][0];
        } catch(err) {
            errors = {'message': 'Server error'}
        }
    }).live('ajax:success', function(evt, data, status, xhr) {
        stat = $(this).parent().nextAll('td.msgstatus');
        stat.css('opacity', 1).css('background', '#5D5').fadeTo(600, 0);
        stat[0].title = $.parseJSON(xhr.responseText);
    });

    $('.loadmsg').bind('ajax:success', function(evt, data, status, xhr) {
        $('#messages').html(xhr.responseText);
    });

    fstack = [];
    $('.filter').bind('input', function() {
        var req = { 'v' : this.value };
        fstack.push(req);
        setTimeout(function () {
            if (fstack.indexOf(req) >= fstack.length - 1) {
                $.get('?' + $.param({ 'filter': req['v'] }))
                    .success(function(data) { $('#messages').html(data); });
                fstack = [];
            }
        }, 150);
    }).blur(function() {
        if (this.value == '') {
            $(this).addClass('empty').val(this.title);
        }
    }).focus(function() {
        if ($(this).hasClass('empty')) {
            $(this).removeClass('empty').val('')
        }
    }).keyup(function(e) {
        if (e.keyCode == 27) {
            $(this).val("").trigger('input').blur();
        }
    });
});
