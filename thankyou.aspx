<%@ Page Language="VB" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <title>GHC</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" type="image/png" href="assets/fav.jpg" sizes="16x16" />
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <!-- jQuery library -->
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.3/dist/jquery.slim.min.js"></script>
    <!-- Popper JS -->
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <!-- Latest compiled JavaScript -->
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/contact-us.css">
    <link rel="stylesheet" href="css/nav2.css">
     <script src="header-component-prod/header.js" type="text/javascript" defer></script> 
    <%--<script src="header-component/header.js" type="text/javascript" defer></script>--%>
    <script src="footer-component/footer.js" type="text/javascript" defer></script>
    <script src="https://www.google.com/recaptcha/api.js" async defer></script>
    <script src="https://code.jquery.com/jquery-3.6.3.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="script/contact.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;1,200&family=Shadows+Into+Light&display=swap" rel="stylesheet">

    <link rel='stylesheet' href='https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css'>
</head>
<body>
    <header-component></header-component>
    <section class="MAIN">
        <div class="membership-section-wrapper" id="callback">
            <div class="membership-banner">
                <img src="assets/banner-contact-global-hospitality-conclave-2023.jpg" class="membership-banner-image" alt="" srcset="">
            </div>
            <div class="membership-form-block">
                <div class="membership-form">
                    <form class="frmbx" id="first_form" runat="server">
                        <div class="frmsction">
                            <div class="frmtr">
                                <div class="frmtd" id="first_name">
                                    <div class="frmfld_area">
                                        <asp:TextBox ID="txtFirstName" runat="server" placeholder="Name" CssClass="frmfldbx" onkeyup="showProperCase(this);" onkeypress="return isNameAlphabet(event);" MaxLength="50"></asp:TextBox>
                                    </div>
                                </div>

                            </div>
                            <div class="frmtr">
                                <div class="frmtd titlewidth">
                                    <div class="frmslct_area">
                                        <asp:DropDownList runat="server" ID="ddlCompany" CssClass="frmslctbx">
                                            <asp:ListItem Text="+91" Value="+91" Selected="True"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="frmtd mblwidth">
                                    <div class="frmfld_area" id="phoneno">
                                        <asp:TextBox ID="txtMobile" runat="server" placeholder="Mobile" CssClass="frmfldbx" onkeypress="return isnumeric(event);" MaxLength="10"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="frmtr">
                                <div class="frmtd emailwidth" id="email">
                                    <div class="frmfld_area">
                                        <asp:TextBox ID="txtEmail" runat="server" placeholder="Email" CssClass="frmfldbx" onkeypress="return isemailAlphanumeric(event);" MaxLength="80"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="frmtr">
                                <div class="frmtd emailwidth" id="batch">
                                    <div class="frmfld_area">
                                        <asp:TextBox ID="txtBatch" runat="server" placeholder="Batch" CssClass="frmfldbx" onkeypress="return isnumeric(event);" MaxLength="10"></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                            <div class="frmtr">
                                <div class="frmtd emailwidth">
                                    <div class="frmfld_area">
                                        <asp:DropDownList runat="server" ID="ddlBatch" CssClass="frmslctbx">
                                            <asp:ListItem Text="OSHM/OCLD Batch" Value="OSHM/OCLD Batch" Selected="True"></asp:ListItem>
                                            <asp:ListItem Text="Management Training/Guest Services" Value="Management Training/Guest Services"></asp:ListItem>
                                            <asp:ListItem Text="Kitchen" Value="Kitchen"></asp:ListItem>
                                            <asp:ListItem Text="Housekeeping" Value="Housekeeping"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>

                            <div class="frmtr">
                                <div class="check" id="chk">
                                    <div class="checkbox-container">
                                        <label class="checkbox-label">
                                            <asp:CheckBox ID="chkTerms" runat="server" />
                                            <span class="mark"></span>
                                        </label>
                                    </div>
                                    <div class="chkbx_txt">
                                        By offering the content above, I give permission to Global Hospitality Conclave and TLC DigiTech to make contact with me to receive more information and agree to 
                                      <span>
                                          <a href="https://www.tlcgroup.com/disclaimer" target="_blank">Terms & Conditions </a>and the 
                                            <a href="https://www.tlcgroup.com/privacy-policy" target="_blank">Privacy Policy</a> on the website. 
                                      </span>
                                    </div>
                                </div>
                                <span class="chkError" id="chkError"></span>
                            </div>
                            <div class="frmtr captcha">
                                <asp:HiddenField runat="server" ID="hdnResponse" Value="" />
                                <div id="recaptcha-demo" class="g-recaptcha" data-sitekey="6LfiQr0kAAAAAHj6eJci96JyN2K9PBxEx6b3NIQK"
                                    data-callback="onSuccess">
                                </div>
                                <script>
                                    var onSuccess = function (r) {
                                        debugger;
                                        $("#hdnResponse").val(r);
                                    };
                                </script>
                            </div>
                            <div class="submit_btn">
                                <asp:Button ID="btnSubmit" runat="server" Text="Submit" />
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </section>
    <section>
        <!-- Modal -->
        <div class="modal" id="divThanku" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">

                    <div class="modal-body">

                        <div class="thankupage">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="javascript:return redirecttoHome();">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <div class="thankubx">
                                <div>
                                    <img src="assets/thankuicn.svg">
                                </div>
                                <div class="thankyoutext">
                                    <h3>Thank you!</h3>
                                    <p>We have made a note of your request and are adding you to our event mailing list, in order to send you timely updates regarding the event.</p>
                                    <div class="submit_btn contnuebtn mx-auto d-block" onclick="javascript:return redirecttoHome();" >Continue</div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </section>
    <footer-component></footer-component>


   <script type="text/javascript">
       function redirecttoHome() {
           var weburi = '<%=ConfigurationManager.AppSettings("webUri") %>';
           
           window.location.href = weburi;
           return false;
       }
       $(document).ready(function () {

           //     $(".menu-btn a").click(function () {
           //         $(".overlay").fadeToggle(200);
           //         $(this).toggleClass('btn-open').toggleClass('btn-close');

           //     });

           // });


       });
   </script>
</body>
</html>
