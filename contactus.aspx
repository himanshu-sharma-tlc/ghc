<%@ Page Language="VB" %>

<%@ Import Namespace="System.Net" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Data" %>
<script runat="server">
    Protected Sub Page_Load(sender As Object, e As EventArgs)
        If (String.IsNullOrEmpty(Request.QueryString("name"))) Then

        End If
    End Sub
    Protected Sub btnSubmit_Click(sender As Object, e As EventArgs) Handles btnSubmit.Click
        btnSubmit.Enabled = False
        If hdnResponse.Value <> "" Then
            Dim connectionstring As String = System.Configuration.ConfigurationManager.ConnectionStrings("GHC_Con").ConnectionString
            Dim con As SqlConnection = New SqlConnection(connectionstring)
            con.Open()
            Dim cmd As SqlCommand = New SqlCommand()
            cmd.CommandText = "usp_InsertGHCData"
            cmd.Connection = con
            cmd.CommandType = System.Data.CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@Name", txtFirstName.Text)
            cmd.Parameters.AddWithValue("@Mobile", ddlCountryCode1.Value + " " + mobileNo_contact.Value)
            cmd.Parameters.AddWithValue("@Email", txtEmail.Text)
            cmd.Parameters.AddWithValue("@BatchFrom", ddlBatchFrom.SelectedItem.Text)
            cmd.Parameters.AddWithValue("@BatchTo", ddlBatchTo.SelectedItem.Text)
            cmd.Parameters.AddWithValue("@Attendance", ddlBatch.SelectedItem.Text)
            cmd.Parameters.AddWithValue("@DelegateName", "")
            cmd.Parameters.AddWithValue("@RegistrationType", "ContactUs")
            Dim status As Integer = cmd.ExecuteNonQuery()

            Dim Message As New Net.Mail.MailMessage()
            Dim FromEmail As New Net.Mail.MailAddress("contactus@globalhospitalityconclave.com", "Global Hospitality Conclave")
            Message.From = FromEmail
            Dim toEmail As String = txtEmail.Text.ToString()
            Dim membername As String = txtFirstName.Text
            Message.To.Add(New Net.Mail.MailAddress(toEmail, toEmail))


            'Drop to Internal Team
            Dim TLCMessage As New Net.Mail.MailMessage()
            TLCMessage.From = FromEmail
            'TLCMessage.To.Add(New Net.Mail.MailAddress("contactus@globalhospitalityconclave.com", "contactus@globalhospitalityconclave.com"))
            TLCMessage.To.Add(New Net.Mail.MailAddress("sarvesh.gupta@tlcgroup.com", "sarvesh.gupta@tlcgroup.com"))
            TLCMessage.IsBodyHtml = True
            TLCMessage.Subject = "Global Hospitality Conclave | Registration"
            Dim pathToHTMLFile1 As String = Server.MapPath("~/drop2.html")
            Dim messageToUser1 As String = File.ReadAllText(pathToHTMLFile1)
            messageToUser1 = messageToUser1.Replace("$$FirstName$$", txtFirstName.Text)
            messageToUser1 = messageToUser1.Replace("$$Email$$", txtEmail.Text)
            messageToUser1 = messageToUser1.Replace("$$Mobile$$", ddlCountryCode1.Value + " " + mobileNo_contact.Value)
            messageToUser1 = messageToUser1.Replace("$$batch$$", ddlBatchFrom.SelectedItem.Text + " - " + ddlBatchTo.SelectedItem.Text)
            messageToUser1 = messageToUser1.Replace("$$Attendance$$", ddlBatch.SelectedItem.Text)
            TLCMessage.Body = messageToUser1
            TLCMessage.BodyEncoding = Encoding.UTF8


            TLCMessage.CC.Add(New Net.Mail.MailAddress("monika.jaswal@tlcgroup.com", "monika.jaswal@tlcgroup.com"))
            'TLCMessage.CC.Add(New Net.Mail.MailAddress("rahul.shekhawat@tlcgroup.com", "rahul.shekhawat@tlcgroup.com"))
            TLCMessage.CC.Add(New Net.Mail.MailAddress("kamini.sharma@tlcgroup.com", "kamini.sharma@tlcgroup.com"))
            TLCMessage.CC.Add(New Net.Mail.MailAddress("shailendra@tlcgroup.com", "shailendra@tlcgroup.com"))
            'TLCMessage.CC.Add(New Net.Mail.MailAddress("sarvesh.gupta@tlcgroup.com", "sarvesh.gupta@tlcgroup.com"))
            TLCMessage.CC.Add(New Net.Mail.MailAddress("sudhir@tlcgroup.com", "sudhir@tlcgroup.com"))
            TLCMessage.CC.Add(New Net.Mail.MailAddress("tanuj.arora@tlcgroup.com", "tanuj.arora@tlcgroup.com"))
            TLCMessage.CC.Add(New Net.Mail.MailAddress("azam.md@tlcgroup.com", "azam.md@tlcgroup.com"))

            Message.IsBodyHtml = True
            Message.Subject = "Thank You for contacting Global Hospitality Conclave"
            Dim pathToHTMLFile As String = Server.MapPath("~/email_thankyoupage.html")
            Dim messageToUser As String = File.ReadAllText(pathToHTMLFile)
            messageToUser = messageToUser.Replace("$$MemberName$$", membername)
            Message.Body = messageToUser
            Message.BodyEncoding = Encoding.UTF8
            Dim SmtpTLC As New Net.Mail.SmtpClient("relay-hosting.secureserver.net", 25)
            SmtpTLC.UseDefaultCredentials = False
            SmtpTLC.EnableSsl = False
            SmtpTLC.Send(Message)
            SmtpTLC.Send(TLCMessage)
            Response.Redirect("thankyou.aspx")
        End If
    End Sub
</script>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>Contact Us | Global Hospitality Conclave</title>
    <!-- Google Tag Manager -->
    <script>(function (w, d, s, l, i) {
            w[l] = w[l] || []; w[l].push({
                'gtm.start':
                    new Date().getTime(), event: 'gtm.js'
            }); var f = d.getElementsByTagName(s)[0],
                j = d.createElement(s), dl = l != 'dataLayer' ? '&l=' + l : ''; j.async = true; j.src =
                    'https://www.googletagmanager.com/gtm.js?id=' + i + dl; f.parentNode.insertBefore(j, f);
        })(window, document, 'script', 'dataLayer', 'GTM-MP75LDQ');</script>
    <!-- End Google Tag Manager -->
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="icon" type="image/png" href="assets/fav.jpg" sizes="16x16" />


    <meta name="og:type" property="og:type" content="website">
    <meta name="description" property="description"
        content="Please fill the form to become a part of GHC or to seek any details or information about GHC.">
    <meta name="og:description" property="og:description"
        content="Please fill the form to become a part of GHC or to seek any details or information about GHC.">
    <meta name="og:title" property="og:title" content="Contact Us | Global Hospitality Conclave">

    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
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
    <script
        src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="script/contact.js"></script>
    <link
        href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;1,200&family=Shadows+Into+Light&display=swap"
        rel="stylesheet">
     <!-- Country CODE -->
    <link rel="stylesheet" href="country/membershipSignUpForm.min.css" type="text/css">
    <script src="country/membershipSignUpForm.min.js"></script>
    <!-- Country CODE -->
    <link rel='stylesheet'
        href='https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css'>

    <!-- Google tag (gtag.js) -->
    <script async src="https://www.googletagmanager.com/gtag/js?id=G-GDDJ4B0NZX"></script>
    <script> window.dataLayer = window.dataLayer || []; function gtag() { dataLayer.push(arguments); } gtag('js', new Date()); gtag('config', 'G-GDDJ4B0NZX'); </script>
</head>

<body>
    <!-- Google Tag Manager (noscript) -->
    <noscript>
        <iframe src="https://www.googletagmanager.com/ns.html?id=GTM-MP75LDQ" height="0"
            width="0" style="display: none; visibility: hidden"></iframe>
    </noscript>
    <!-- End Google Tag Manager (noscript) -->
    <header-component></header-component>
    <section class="banner-section">
        <div class="membership-section-wrapper" id="callback">
            <div class="membership-banner">
                <img src="assets/banner-contact-global-hospitality-conclave-2023.jpg"
                    class="membership-banner-image" alt="" srcset="">
            </div>
            <div class="membership-form-block">
                <div class="membership-form">
                    <form class="frmbx" id="first_form" runat="server">
                        <div class="frmsction">
                            <div class="frmtr">
                                <div class="frmtd" id="first_name">
                                    <div class="frmfld_area">
                                        <asp:TextBox ID="txtFirstName" runat="server"
                                            onpaste="return false;" placeholder="Full Name"
                                            CssClass="frmfldbx" onkeyup="showProperCase(this);"
                                            onkeypress="return isNameAlphabet(event);"
                                            onblur="javascript:return validateForm1('name');"
                                            MaxLength="50"></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                            <div class="marginbottom">
                                <div class="cm-input-group">
                                    <div class="dropdown frmtd titlewidth">
                                        <input type="hidden" id="ddlCountryCode1"
                                            name="ddlCountryCode1" value="+91" runat="server" />
                                        <button class="country-code dropdown-togglee" type="button"
                                            data-toggle="dropdown" name="ddlCompany"
                                            id="ddlCompany">
                                            <span class="value" id="span_showcntNew">+91</span>
                                            <span class="caret"></span>
                                        </button>
                                        <ul class="dropdown-menu frmslctbx" id="ddlCountryCode"
                                            name="ddlCountryCode">
                                        </ul>
                                    </div>
                                    <div class="frmtd mblwidth">
                                        <div class="frmfld_area">
                                            <label for=""
                                                class="cm-input-label input-number member-signup">
                                                <input id="mobileNo_contact" name="mobile"
                                                    TabIndex="4" AutoComplete="off"
                                                    data-minlength="10" data-maxlength="10"
                                                    class="cm-input mobile" maxlength="10"
                                                    placeholder="Mobile" runat="server"
                                                    onkeypress="return isnumeric(event);"
                                                    onblur="javascript:return validateForm1('phone');">
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="frmtr">
                                <div class="frmtd emailwidth" id="email">
                                    <div class="frmfld_area">
                                        <asp:TextBox ID="txtEmail" runat="server"
                                            placeholder="Email" CssClass="frmfldbx"
                                            onkeypress="return isemailAlphanumeric(event);"
                                            onblur="javascript:return validateForm1('email');"
                                            MaxLength="80"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="frmtr">
                                <div class="frmtd batchwidth">
                                    <div class="frmslct_area">
                                        <asp:DropDownList runat="server" ID="ddlBatchFrom"
                                            CssClass="frmslctbx"
                                            onchange="javascript:return validateForm1('batchfrom');">
                                            <asp:ListItem Text="From" Value="1" disabled Selected
                                                hidden></asp:ListItem>
                                            <asp:ListItem Text="2024" Value="2024"></asp:ListItem>
                                            <asp:ListItem Text="2023" Value="2023"></asp:ListItem>
                                            <asp:ListItem Text="2022" Value="2022"></asp:ListItem>
                                            <asp:ListItem Text="2021" Value="2021"></asp:ListItem>
                                            <asp:ListItem Text="2020" Value="2020"></asp:ListItem>
                                            <asp:ListItem Text="2019" Value="2019"></asp:ListItem>
                                            <asp:ListItem Text="2018" Value="2018"></asp:ListItem>
                                            <asp:ListItem Text="2017" Value="2017"></asp:ListItem>
                                            <asp:ListItem Text="2016" Value="2016"></asp:ListItem>
                                            <asp:ListItem Text="2015" Value="2015"></asp:ListItem>
                                            <asp:ListItem Text="2014" Value="2014"></asp:ListItem>
                                            <asp:ListItem Text="2013" Value="2013"></asp:ListItem>
                                            <asp:ListItem Text="2012" Value="2012"></asp:ListItem>
                                            <asp:ListItem Text="2011" Value="2011"></asp:ListItem>
                                            <asp:ListItem Text="2010" Value="2010"></asp:ListItem>
                                            <asp:ListItem Text="2009" Value="2009"></asp:ListItem>
                                            <asp:ListItem Text="2008" Value="2008"></asp:ListItem>
                                            <asp:ListItem Text="2007" Value="2007"></asp:ListItem>
                                            <asp:ListItem Text="2006" Value="2006"></asp:ListItem>
                                            <asp:ListItem Text="2005" Value="2005"></asp:ListItem>
                                            <asp:ListItem Text="2004" Value="2004"></asp:ListItem>
                                            <asp:ListItem Text="2003" Value="2003"></asp:ListItem>
                                            <asp:ListItem Text="2002" Value="2002"></asp:ListItem>
                                            <asp:ListItem Text="2001" Value="2001"></asp:ListItem>
                                            <asp:ListItem Text="2000" Value="2000"></asp:ListItem>
                                            <asp:ListItem Text="1999" Value="1999"></asp:ListItem>
                                            <asp:ListItem Text="1998" Value="1998"></asp:ListItem>
                                            <asp:ListItem Text="1997" Value="1997"></asp:ListItem>
                                            <asp:ListItem Text="1996" Value="1996"></asp:ListItem>
                                            <asp:ListItem Text="1995" Value="1995"></asp:ListItem>
                                            <asp:ListItem Text="1994" Value="1994"></asp:ListItem>
                                            <asp:ListItem Text="1993" Value="1993"></asp:ListItem>
                                            <asp:ListItem Text="1992" Value="1992"></asp:ListItem>
                                            <asp:ListItem Text="1991" Value="1991"></asp:ListItem>
                                            <asp:ListItem Text="1990" Value="1990"></asp:ListItem>
                                            <asp:ListItem Text="1989" Value="1989"></asp:ListItem>
                                            <asp:ListItem Text="1988" Value="1988"></asp:ListItem>
                                            <asp:ListItem Text="1987" Value="1987"></asp:ListItem>
                                            <asp:ListItem Text="1986" Value="1986"></asp:ListItem>
                                            <asp:ListItem Text="1985" Value="1985"></asp:ListItem>
                                            <asp:ListItem Text="1984" Value="1984"></asp:ListItem>
                                            <asp:ListItem Text="1983" Value="1983"></asp:ListItem>
                                            <asp:ListItem Text="1982" Value="1982"></asp:ListItem>
                                            <asp:ListItem Text="1981" Value="1981"></asp:ListItem>
                                            <asp:ListItem Text="1980" Value="1980"></asp:ListItem>
                                            <asp:ListItem Text="1979" Value="1979"></asp:ListItem>
                                            <asp:ListItem Text="1978" Value="1978"></asp:ListItem>
                                            <asp:ListItem Text="1977" Value="1977"></asp:ListItem>
                                            <asp:ListItem Text="1976" Value="1976"></asp:ListItem>
                                            <asp:ListItem Text="1975" Value="1975"></asp:ListItem>
                                            <asp:ListItem Text="1974" Value="1974"></asp:ListItem>
                                            <asp:ListItem Text="1973" Value="1973"></asp:ListItem>
                                            <asp:ListItem Text="1972" Value="1972"></asp:ListItem>
                                            <asp:ListItem Text="1971" Value="1971"></asp:ListItem>
                                            <asp:ListItem Text="1970" Value="1970"></asp:ListItem>
                                            <asp:ListItem Text="1969" Value="1969"></asp:ListItem>
                                            <asp:ListItem Text="1968" Value="1968"></asp:ListItem>
                                            <asp:ListItem Text="1967" Value="1967"></asp:ListItem>
                                            <asp:ListItem Text="1966" Value="1966"></asp:ListItem>
                                            <asp:ListItem Text="1965" Value="1965"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>

                                <div class="frmtd batchwidth last">
                                    <div class="frmslct_area">
                                        <asp:DropDownList runat="server" ID="ddlBatchTo"
                                            CssClass="frmslctbx"
                                            onchange="javascript:return validateForm1('batchto');">
                                            <asp:ListItem Text="To" Value="1" disabled Selected
                                                hidden></asp:ListItem>
                                            <asp:ListItem Text="2024" Value="2024"></asp:ListItem>
                                            <asp:ListItem Text="2023" Value="2023"></asp:ListItem>
                                            <asp:ListItem Text="2022" Value="2022"></asp:ListItem>
                                            <asp:ListItem Text="2021" Value="2021"></asp:ListItem>
                                            <asp:ListItem Text="2020" Value="2020"></asp:ListItem>
                                            <asp:ListItem Text="2019" Value="2019"></asp:ListItem>
                                            <asp:ListItem Text="2018" Value="2018"></asp:ListItem>
                                            <asp:ListItem Text="2017" Value="2017"></asp:ListItem>
                                            <asp:ListItem Text="2016" Value="2016"></asp:ListItem>
                                            <asp:ListItem Text="2015" Value="2015"></asp:ListItem>
                                            <asp:ListItem Text="2014" Value="2014"></asp:ListItem>
                                            <asp:ListItem Text="2013" Value="2013"></asp:ListItem>
                                            <asp:ListItem Text="2012" Value="2012"></asp:ListItem>
                                            <asp:ListItem Text="2011" Value="2011"></asp:ListItem>
                                            <asp:ListItem Text="2010" Value="2010"></asp:ListItem>
                                            <asp:ListItem Text="2009" Value="2009"></asp:ListItem>
                                            <asp:ListItem Text="2008" Value="2008"></asp:ListItem>
                                            <asp:ListItem Text="2007" Value="2007"></asp:ListItem>
                                            <asp:ListItem Text="2006" Value="2006"></asp:ListItem>
                                            <asp:ListItem Text="2005" Value="2005"></asp:ListItem>
                                            <asp:ListItem Text="2004" Value="2004"></asp:ListItem>
                                            <asp:ListItem Text="2003" Value="2003"></asp:ListItem>
                                            <asp:ListItem Text="2002" Value="2002"></asp:ListItem>
                                            <asp:ListItem Text="2001" Value="2001"></asp:ListItem>
                                            <asp:ListItem Text="2000" Value="2000"></asp:ListItem>
                                            <asp:ListItem Text="1999" Value="1999"></asp:ListItem>
                                            <asp:ListItem Text="1998" Value="1998"></asp:ListItem>
                                            <asp:ListItem Text="1997" Value="1997"></asp:ListItem>
                                            <asp:ListItem Text="1996" Value="1996"></asp:ListItem>
                                            <asp:ListItem Text="1995" Value="1995"></asp:ListItem>
                                            <asp:ListItem Text="1994" Value="1994"></asp:ListItem>
                                            <asp:ListItem Text="1993" Value="1993"></asp:ListItem>
                                            <asp:ListItem Text="1992" Value="1992"></asp:ListItem>
                                            <asp:ListItem Text="1991" Value="1991"></asp:ListItem>
                                            <asp:ListItem Text="1990" Value="1990"></asp:ListItem>
                                            <asp:ListItem Text="1989" Value="1989"></asp:ListItem>
                                            <asp:ListItem Text="1988" Value="1988"></asp:ListItem>
                                            <asp:ListItem Text="1987" Value="1987"></asp:ListItem>
                                            <asp:ListItem Text="1986" Value="1986"></asp:ListItem>
                                            <asp:ListItem Text="1985" Value="1985"></asp:ListItem>
                                            <asp:ListItem Text="1984" Value="1984"></asp:ListItem>
                                            <asp:ListItem Text="1983" Value="1983"></asp:ListItem>
                                            <asp:ListItem Text="1982" Value="1982"></asp:ListItem>
                                            <asp:ListItem Text="1981" Value="1981"></asp:ListItem>
                                            <asp:ListItem Text="1980" Value="1980"></asp:ListItem>
                                            <asp:ListItem Text="1979" Value="1979"></asp:ListItem>
                                            <asp:ListItem Text="1978" Value="1978"></asp:ListItem>
                                            <asp:ListItem Text="1977" Value="1977"></asp:ListItem>
                                            <asp:ListItem Text="1976" Value="1976"></asp:ListItem>
                                            <asp:ListItem Text="1975" Value="1975"></asp:ListItem>
                                            <asp:ListItem Text="1974" Value="1974"></asp:ListItem>
                                            <asp:ListItem Text="1973" Value="1973"></asp:ListItem>
                                            <asp:ListItem Text="1972" Value="1972"></asp:ListItem>
                                            <asp:ListItem Text="1971" Value="1971"></asp:ListItem>
                                            <asp:ListItem Text="1970" Value="1970"></asp:ListItem>
                                            <asp:ListItem Text="1969" Value="1969"></asp:ListItem>
                                            <asp:ListItem Text="1968" Value="1968"></asp:ListItem>
                                            <asp:ListItem Text="1967" Value="1967"></asp:ListItem>
                                            <asp:ListItem Text="1966" Value="1966"></asp:ListItem>
                                            <asp:ListItem Text="1965" Value="1965"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                            <div class="frmtr">
                                <div class="frmtd emailwidth">
                                    <div class="frmslct_area">
                                        <asp:DropDownList runat="server" ID="ddlBatch"
                                            CssClass="frmslctbx"
                                            onchange="javascript:return validateForm1('attendance');">
                                            <asp:ListItem Text="Attendance" Value="1" disabled
                                                Selected hidden></asp:ListItem>
                                            <asp:ListItem Text="OCLD/OSHM" Value="OCLD/OSHM">
                                            </asp:ListItem>
                                            <asp:ListItem Text="Executive Role"
                                                Value="Executive Role"></asp:ListItem>
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
                                    <div class="chkbx_txt chkbx_txt2">
                                        By offering the content above, I give permission to Global
                                                            Hospitality Conclave and TLC DigiTech to make contact with
                                                            me to receive more information and agree to
                                                            <span>
                                                                <a href="https://www.tlcgroup.com/disclaimer"
                                                                    target="_blank">Terms & Conditions </a>and the
                                                                <a href="https://www.tlcgroup.com/privacy-policy"
                                                                    target="_blank">Privacy Policy</a> on the website.
                                                            </span>
                                    </div>
                                </div>
                                <span class="chkError" id="chkError"></span>
                            </div>
                            <div class="frmtr captcha">
                                <asp:HiddenField runat="server" ID="hdnResponse" Value="" />
                                <div id="recaptcha-demo" class="g-recaptcha"
                                    data-sitekey="6LdlTwwlAAAAALJQgUlPsheTozzWYPkChAbW8XaB"
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
                                <asp:Button ID="btnSubmit" runat="server" Text="Submit"
                                    OnClientClick="javascript:return validateForm();"
                                    OnClick="btnSubmit_Click" />
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </section>
    <section>
        <!-- Modal -->
        <div class="modal" id="divThanku" tabindex="-1" role="dialog"
            aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">

                    <div class="modal-body">

                        <div class="thankupage">
                            <button type="button" class="close" data-dismiss="modal"
                                aria-label="Close"
                                onclick="javascript:return redirecttoHome();">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <div class="thankubx">
                                <div>
                                    <img src="assets/thankuicn.svg">
                                </div>
                                <div class="thankyoutext">
                                    <h3>Thank you!</h3>
                                    <p>
                                        We have made a note of your request and are adding you to our
                                                            event mailing list, in order to send you timely updates
                                                            regarding the event.
                                    </p>
                                    <div class="submit_btn contnuebtn mx-auto d-block"
                                        onclick="javascript:return redirecttoHome();">
                                        Continue
                                    </div>
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
        //alert(weburi);
        window.location.href = weburi;
        return false;
    }
</script>

<script  type="text/javascript">
    $(document).ready(function () {
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
</script>
</body>

</html>
