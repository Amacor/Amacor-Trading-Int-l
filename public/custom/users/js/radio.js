$(".radioBtn").click(function() {
    $("#textField").attr("disabled", true);
    if ($("input[name=ynRadio]:checked").val() == "small") {
        $("#textField1").attr("disabled", false); 
        $("#textField2").attr("disabled", true);
        $("#textField3").attr("disabled", true);
    }
    if ($("input[name=ynRadio]:checked").val() == "medium") {
        $("#textField2").attr("disabled", false);
        $("#textField1").attr("disabled", true);
        $("#textField3").attr("disabled", true);
    }
    if ($("input[name=ynRadio]:checked").val() == "large") {
        $("#textField3").attr("disabled", false);
        $("#textField1").attr("disabled", true);
        $("#textField2").attr("disabled", true);
    }
});


function PreviewImage() {
    var oFReader = new FileReader();
    oFReader.readAsDataURL(document.getElementById("uploadImage").files[0]);
    oFReader.onload = function (oFREvent) {
    document.getElementById("uploadPreview").src = oFREvent.target.result;
    };
    };
function PreviewImage2() {
    var oFReader = new FileReader();
    oFReader.readAsDataURL(document.getElementById("uploadImage2").files[0]);
    oFReader.onload = function (oFREvent) {
    document.getElementById("uploadPreview2").src = oFREvent.target.result;
    };
    };
function PreviewImage3() {
    var oFReader = new FileReader();
    oFReader.readAsDataURL(document.getElementById("uploadImage3").files[0]);
    oFReader.onload = function (oFREvent) {
    document.getElementById("uploadPreview3").src = oFREvent.target.result;
    };
    };