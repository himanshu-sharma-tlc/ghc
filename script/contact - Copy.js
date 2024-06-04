$(document).ready(function () {
    $("#chkError").hide();
    $("#divThanku").hide();
    //var mode = GetParameterValues('mode');
    var name = window.location.href;
    if (name.indexOf("thankyou") != -1) {
        //while (name.indexOf("%20") > -1) {
        //    name = name.replace("%20", " ");
        //}
        $(function () {
            $("#divThanku").modal('show');
        });
        //$("#dvMemmbername").append(name + ",");
    }
    function GetParameterValues(param) {
        var url = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
        for (var i = 0; i < url.length; i++) {
            var urlparam = url[i].split('=');
            if (urlparam[0] == param) {
                return urlparam[1];
            }
        }
    }
    $("#chkTerms").click(function () {
        var thisCheck = $(this);
        if (thisCheck.is(':checked')) {
            // Do stuff
            $("#chkError").hide();
        }
        else {
            $("#chkError").show();
        }
    });
    $(".menu-btn a").click(function () {
        var scroll = $(window).scrollTop();
        $(".overlay").fadeToggle(200);
        $(this).toggleClass('btn-open').toggleClass('btn-close');

        if ($(this).hasClass('btn-close')) {
            $("body").addClass("noscroll");
        }
        else if ($(this).hasClass('btn-open')) {
            $("body").removeClass('noscroll');
        }
    });
});

function validateEmail(email) {
        let res = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
        return res.test(email);
      }

function validateForm() {
    var FirstName = $("#txtFirstName").val();
    var Mobile = $("#txtMobile").val();
    var Email = $("#txtEmail").val();
    var batchfrom = $("#ddlBatchFrom").val();
    var batchto = $("#ddlBatchTo").val();
    var attendance = $("#ddlBatch").val();
    var flag = 0;
    $(".error").remove();
    if (FirstName == "") {
        $("#txtFirstName").after('<span class="error">Please enter Full Name.</span>');
        flag = 1;
    }
    if (Mobile == "") {
        $("#txtMobile").after('<span class="error">Please enter Mobile Number.</span>');
        flag = 1;
    }
    if (Email == "") {
        $("#txtEmail").after('<span class="error">Please enter a valid Email Id.</span>');
        flag = 1;
    }
    if (batchfrom == "Batch (from)") {
        $("#ddlBatchFrom").after('<span class="error">Please select Batch From.</span>');
        flag = 1;
    }
    if (batchto == "Batch (to)") {
        $("#ddlBatchTo").after('<span class="error">Please select Batch To.</span>');
        flag = 1;
    }
    if (parseInt(batchfrom) >= parseInt(batchto)) {
        $("#ddlBatchTo").after('<span class="error">Please select valid Batch To.</span>');
        flag = 1;
    }
    if (attendance == "Attendance") {
        $("#ddlBatch").after('<span class="error">Please select Attendance.</span>');
        flag = 1;
    }
    if (!$("#chkTerms").prop('checked')) {
        $("#chkError").html("Please accept the Terms by checking the box.");
        $("#chkError").show();
        flag = 1;
    }    
    if (flag == 1) {
        //$("#btnSubmit").removeAttr("disabled");
        return false;
    }
    else {
        if ($("#hdnResponse").val() == "") {
            alert("Please click on I'm not a robot.")
            flag = 1;
        }
        if (flag == 1) {
            //$("#btnSubmit").removeAttr("disabled");
            return false;
        }
        else {
            return true;
        }
    }
}

function validateForm1() {
    var FirstName = $("#txtFirstName").val();
    var Mobile = $("#txtMobile").val();
    var Email = $("#txtEmail").val();
    var batchfrom = $("#ddlBatchFrom").val();
    var batchto = $("#ddlBatchTo").val();
    var attendance = $("#ddlBatch").val();
    var flag = 0;
    $(".error").remove();
    if (FirstName == "") {
        $("#txtFirstName").after('<span class="error">Please enter Full Name.</span>');
        flag = 1;
    }
    if (Mobile == "") {
        $("#txtMobile").after('<span class="error">Please enter Mobile Number.</span>');
        flag = 1;
    }
    if (Email == "") {
        $("#txtEmail").after('<span class="error">Please enter a valid Email Id.</span>');
        flag = 1;
    }
    if (batchfrom == "Batch (from)") {
        $("#ddlBatchFrom").after('<span class="error">Please select Batch From.</span>');
        flag = 1;
    }
    if (batchto == "Batch (to)") {
        $("#ddlBatchTo").after('<span class="error">Please select Batch To.</span>');
        flag = 1;
    }
    if (parseInt(batchfrom) >= parseInt(batchto)) {
        $("#ddlBatchTo").after('<span class="error">Please select valid Batch To.</span>');
        flag = 1;
    }
    if (attendance == "Attendance") {
        $("#ddlBatch").after('<span class="error">Please select Attendance.</span>');
        flag = 1;
    }
    if (!$("#chkTerms").prop('checked')) {
        $("#chkError").html("Please accept the Terms by checking the box.");
        $("#chkError").show();
        flag = 1;
    }
    else {
        $("#chkError").hide();
    }
    if (flag == 1) {
        //$("#btnSubmit").removeAttr("disabled");
        return false;
    }
    else {

        return true;
    }
}
function isNameAlphabet(evt) //alphabets
{
    var charCode = (evt.which) ? evt.which : event.keyCode
    if (charCode == 32 || charCode == 8)
        return true;
    if (charCode > 31 && (charCode < 91 && charCode > 64))       //for alphabets
        return true;
    if (charCode > 31 && (charCode < 123 && charCode > 96))      // for alphabets
    {
        return true;
    }
    return false;
}
function showProperCase(obj) {
    //alert(toTitleCase($(obj).val()));
    $(obj).val(toTitleCase($(obj).val()));
}
function toTitleCase(str) {
    return str.replace(/(?:^|\s)\w/g, function (match) {
        return match.toUpperCase();
    });
}
function isnumeric(evt)    //numeric validations
{
    var charCode = (evt.which) ? evt.which : event.keyCode
    if (charCode > 31 && (charCode < 48 || charCode > 57))  // for numeric validations
    {
        return false;
    }
    return true;
}

function isemailAlphanumeric(evt) //alphanumeric validations
{
    var charCode = (evt.which) ? evt.which : event.keyCode
    if (charCode == 8 || charCode == 64 || charCode == 46 || charCode == 95 || charCode == 45 || charCode == 35 || charCode == 36 || charCode == 37 || charCode == 38 || charCode == 40 || charCode == 41 || charCode == 42) { return true; }
    if ((charCode < 91 && charCode > 64))      // for alphabets
    {
        return true;
    }
    if ((charCode < 48 || charCode > 57))  // Numbers
    {
        if ((charCode < 123 && charCode > 96))      // for alphanumeric validations
        { return true; }

        return false;
    }
    return true;
}