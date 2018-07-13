$('#submit').click(function(s) {
    s.preventDefault();
    swal({
        title: "Na add na",
        confirmButtonText: "Ok",
        closeOnConfirm: false
    },
    function(){
        window.location = "subcontractors.pug"
    });
});