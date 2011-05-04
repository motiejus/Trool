$(document).ready(function() {
    $('#messages input').change(function() { // Submit changes
        $(this).closest('form').submit();
    }).filter(':text').keypress(function(e) { // focus next/prev
        // on tab or enter, focus next entry
        if (e.keyCode == 13 || e.keyCode == 9) {
            if (e.shiftKey) // previous
              $(this).closest('tr').prev().
                      find('input:text').focus();
            else $(this).closest('tr').next(). // next
                      find('input:text').focus();
            return false;
        }
    }).focusin(function() {
        $(this).addClass('current');
    }).focusout(function() {
        $(this).removeClass('current');
    }).hover(
        function() { $(this).addClass('focused'); },
        function() { $(this).removeClass('focused'); }
    );
});
