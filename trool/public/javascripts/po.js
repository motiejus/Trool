$(document).ready(function() {
    $('#messages input').change(function() {
        // Hide current
        $(this).hide()
        $(this).parents('.msgstr:first').find('span').
                text($(this).val()).show();

        // Show next
        $(this).parents('tr:first').next().
                find('.msgstr span').hide();
        $(this).parents('tr:first').next().
                find('.msgstr input').show().focus();

        // Submit
        $(this).parents('form:first').submit();
    }).keypress(function(e) {
        if (e.keyCode == 13 || e.keyCode == 9) {
            $(this).change();
        }
    });
});
