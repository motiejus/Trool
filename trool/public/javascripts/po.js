$(document).ready(function() {
    $('#messages input').change(function() {
        $(this).parents('form:first').submit();
    }).filter(':text').change(function() {
        // Hide current
        $(this).hide()
        $(this).parents('.msgstr:first').find('span').
                text($(this).val()).show();

        // Show next
        $(this).parents('tr:first').next().
                find('.msgstr span').hide();
        $(this).parents('tr:first').next().
                find('.msgstr input').show().focus();
    }).keypress(function(e) {
        if (e.keyCode == 13 || e.keyCode == 9) {
            $(this).change();
        }
    });
});
