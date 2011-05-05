$(document).ready(function() {
    $('input, textarea', '#messages').change(function() { // Submit changes
        $(this).closest('form').submit();
    }).filter('textarea').keypress(function(e) { // focus next/prev
        // on tab or enter, focus next entry
        if ((e.ctrlKey && e.keyCode == 13) || e.keyCode == 9) {
            if (e.shiftKey) // previous
              $(this).closest('tr').prev().
                      find('textarea').focus();
            else $(this).closest('tr').next(). // next
                      find('textarea').focus();
            return false;
        }
    }).focusin(function() {
        $(this).addClass('current');
        $(this).closest("tr").find("td.msgid span").addClass("spaced");
    }).focusout(function() {
        $(this).removeClass('current');
        $(this).closest("tr").find("td.msgid span").removeClass("spaced");
    }).hover(
        function() { $(this).addClass('focused'); },
        function() { $(this).removeClass('focused'); }
    );
});
