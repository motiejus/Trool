$(document).ready(function() {
    $('#messages input').change(function() {
        $(this).parents('form:first').submit();
    });
});
