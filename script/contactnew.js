$(document).ready(function () {
    $('#first_form')[0].reset(); 
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
    $("#chkTerms1").click(function () {
        var thisCheck = $(this);
        if (thisCheck.is(':checked')) {
            // Do stuff
            $("#chkError1").hide();
        }
        else {
            $("#chkError1").show();
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
    var name = $("#txtFirstName").val();
    var Mobile = $("#txtMobile").val();
    var Email = $("#txtEmail").val();
    var batchfrom = $("#ddlBatchFrom").val();
    var batchto = $("#ddlBatchTo").val();
    var attendance = $("#ddlBatch").val();
    var mobilePattern="[^0-6]{1,1}[0-9]{9,9}"
    var flag = 0;
    $(".error").remove();
    // if (firstname == "") {
    //     $("#txtFirstName").after('<span class="error" id="errorfullname">Please enter Full Name.</span>');
    //     flag = 1;
    // }
if (name == "") {
                    $("#txtFirstName").after('<span class="error" id="errorfullname">Please enter Full Name.</span>');
                    flag = 1;
                }
                if (parseInt(name.length) < 3 && parseInt(name.length) > 0) {
                    $("#txtFirstName").after('<span class="error" id="errorfullname">Please enter valid Full Name.</span>');
                    flag = 1;
                }

    if (Mobile == "" ||  !Mobile.match(mobilePattern)) {
        $("#txtMobile").after('<span class="error" id="errorphone">Please enter Mobile Number.</span>');
        flag = 1;
    }
   
    if (Email == "") {
        $("#txtEmail").after('<span class="error" id="erroremail">Please enter a valid Email Id.</span>');
        flag = 1;
    }
    else {
        if (!validateEmail(Email)) {
            $("#txtEmail").after('<span class="error" id="erroremail">Please enter a valid Email Id.</span>');
            flag = 1;
        }
    }
    if (batchfrom == null) {
        $("#ddlBatchFrom").after('<span class="error" id="errorbatchfrom">Please select start year.</span>');
        flag = 1;
    }
    if (batchto == null) {
        $("#ddlBatchTo").after('<span class="error" id="errorbatchto">Please select end year.</span>');
        flag = 1;
    }
    if (parseInt(batchfrom) >= parseInt(batchto)) {
        $("#ddlBatchTo").after('<span class="error" id="errorbatchto">Please select valid Year.</span>');
        flag = 1;
    }
    if (attendance == null) {
        $("#ddlBatch").after('<span class="error" id="errorattendance">Please select Attendance.</span>');
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

function validateForm1(fieldname) {
    var name = $("#txtFirstName").val();
    var Mobile = $("#txtMobile").val();
    var Email = $("#txtEmail").val();
    var batchfrom = $("#ddlBatchFrom").val();
    var batchto = $("#ddlBatchTo").val();
    var attendance = $("#ddlBatch").val();
       var mobilePattern="[^0-6]{1,1}[0-9]{9,9}"
    var flag = 0;
    // if (fieldname == 'name') {
    //     $("#errorfullname").remove();
    //     if (FirstName == "") {
    //         $("#txtFirstName").after('<span class="error" id="errorfullname">Please enter Full Name.</span>');
    //         flag = 1;
    //     }
    // }
if (fieldname == 'name') {
                $("#errorfullname").remove();
                if (name == "") {
                    $("#txtFirstName").after('<span class="error" id="errorfullname">Please enter Full Name.</span>');
                    flag = 1;
                }
                if (parseInt(name.length) < 3 && parseInt(name.length) > 0) {
                    $("#txtFirstName").after('<span class="error" id="errorfullname">Please enter valid Full Name.</span>');
                    flag = 1;
                }
            }
    else if (fieldname == 'phone') {
        $("#errorphone").remove();
       if (Mobile == "" || !Mobile.match(mobilePattern)) {
            $("#txtMobile").after('<span class="error" id="errorphone">Please enter Mobile Number.</span>');
            flag = 1;
        }
    }
    else if (fieldname == 'email') {
        $("#erroremail").remove();
        if (Email == "") {
            $("#txtEmail").after('<span class="error" id="erroremail">Please enter a valid Email Id.</span>');
            flag = 1;
        }
        else {
            if (!validateEmail(Email)) {
                $("#txtEmail").after('<span class="error" id="erroremail">Please enter a valid Email Id.</span>');
                flag = 1;
            }
        }
    }
    else if (fieldname == 'batchfrom') {
        $("#errorbatchfrom").remove();
        if (batchfrom == null) {
            $("#ddlBatchFrom").after('<span class="error" id="errorbatchfrom">Please select start year.</span>');
            flag = 1;
        }
    }
    else if (fieldname == 'batchto') {
        $("#errorbatchto").remove();
        if (batchto == null){
            $("#ddlBatchTo").after('<span class="error" id="errorbatchto">Please select end year.</span>');
            flag = 1;
        }
        if (parseInt(batchfrom) >= parseInt(batchto)) {
            $("#ddlBatchTo").after('<span class="error" id="errorbatchto">Please select valid Year.</span>');
            flag = 1;
        }
    }
    else if (fieldname == 'attendance') {
        $("#errorattendance").remove();
        if (attendance == null) {
            $("#ddlBatch").after('<span class="error" id="errorattendance">Please select Attendance.</span>');
            flag = 1;
        }
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

function validateEmail(varEmail) {
    var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
    return emailReg.test(varEmail);
}