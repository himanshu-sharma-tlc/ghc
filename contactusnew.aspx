<%@ Page Language="VB" %>

<%@ Import Namespace="System.Net" %>
<%@ Import Namespace="System.IO" %>
<%@import Namespace="System.Data.SqlClient" %>
<%@import Namespace="System.Data" %>
<script runat="server">
    Protected Sub Page_Load(sender As Object, e As EventArgs)
        If (String.IsNullOrEmpty(Request.QueryString("name"))) Then

        End If
    End Sub
    Protected Sub btnSubmit_Click(sender As Object, e As EventArgs) Handles btnSubmit.Click
        btnSubmit.Enabled = False

        Dim connectionstring As String = System.Configuration.ConfigurationManager.ConnectionStrings("GHC_Con").ConnectionString
        Dim con As SqlConnection = New SqlConnection(connectionstring)
        con.Open()
        Dim cmd As SqlCommand = New SqlCommand()
        cmd.CommandText = "usp_InsertGHCData"
        cmd.Connection = con
        cmd.CommandType = System.Data.CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@Name", txtFirstName.Text)
        cmd.Parameters.AddWithValue("@Mobile", ddlCompany.SelectedValue + " " + txtMobile.Text)
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
        TLCMessage.To.Add(New Net.Mail.MailAddress("contactus@globalhospitalityconclave.com", "contactus@globalhospitalityconclave.com"))
        TLCMessage.IsBodyHtml = True
        TLCMessage.Subject = "GHC Evening | Registration"
        Dim pathToHTMLFile1 As String = Server.MapPath("~/drop.html")
        Dim messageToUser1 As String = File.ReadAllText(pathToHTMLFile1)
        messageToUser1 = messageToUser1.Replace("$$FirstName$$", txtFirstName.Text)
        messageToUser1 = messageToUser1.Replace("$$Email$$", txtEmail.Text)
        messageToUser1 = messageToUser1.Replace("$$Mobile$$", ddlCompany.SelectedValue + " " + txtMobile.Text)
        messageToUser1 = messageToUser1.Replace("$$batch$$", ddlBatchFrom.SelectedItem.Text + " - " + ddlBatchTo.SelectedItem.Text)
        messageToUser1 = messageToUser1.Replace("$$Attendance$$", ddlBatch.SelectedItem.Text)
        TLCMessage.Body = messageToUser1
        TLCMessage.BodyEncoding = Encoding.UTF8

        'TLCMessage.CC.Add(New Net.Mail.MailAddress("nrapendra.mishra@tlcgroup.com", "nrapendra.mishra@tlcgroup.com"))
        'TLCMessage.CC.Add(New Net.Mail.MailAddress("rahul.shekhawat@tlcgroup.com", "rahul.shekhawat@tlcgroup.com"))
        TLCMessage.CC.Add(New Net.Mail.MailAddress("kamini.sharma@tlcgroup.com", "kamini.sharma@tlcgroup.com"))
        TLCMessage.CC.Add(New Net.Mail.MailAddress("shailendra@tlcgroup.com", "shailendra@tlcgroup.com"))
        'TLCMessage.CC.Add(New Net.Mail.MailAddress("aarti.gautam@tlcgroup.com", "aarti.gautam@tlcgroup.com"))
        TLCMessage.CC.Add(New Net.Mail.MailAddress("sudhir@tlcgroup.com", "sudhir@tlcgroup.com"))
        TLCMessage.CC.Add(New Net.Mail.MailAddress("tanuj.arora@tlcgroup.com", "tanuj.arora@tlcgroup.com"))

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
    End Sub
</script>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Contact Us | Global Hospitality Conclave</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="icon" type="image/png" href="assets/fav.jpg" sizes="16x16" />


    <meta name="og:type" property="og:type" content="website">
    <meta name="description" property="description" content="Please fill the form to become a part of GHC or to seek any details or information about GHC.">
    <meta name="og:description" property="og:description" content="Please fill the form to become a part of GHC or to seek any details or information about GHC.">
    <meta name="og:title" property="og:title" content="Contact Us | Global Hospitality Conclave">

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

    <script src="https://www.google.com/recaptcha/api.js" async defer></script>
    <script src="https://code.jquery.com/jquery-3.6.3.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="script/contactnew.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;1,200&family=Shadows+Into+Light&display=swap" rel="stylesheet">

    <link rel='stylesheet' href='https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css'>
</head>
<body>
    <header>
        <nav class="navbar">
            <div class="navbar-container container">
                <div class="logo">
                    <a href="index.html">
                        <img src="assets/GHC-Logo.png" /></a>
                </div>
                <ul class="header__nav dsktop" id="">
                    <li><a href="index.html">Home</a></li>
                    <li><a href="ghc-2023.html">GHC 2023</a></li>
                    <li><a href="organizing-committee.html">Organizing Committee</a></li>
                    <li><a href="photo-gallery-1.html">Photo Gallery</a></li>
                    <li><a href="contactus.aspx" class="active">Contact Us</a></li>
                </ul>

                <span class="navbar-text">
                    <div class="menu-btn">
                        <a class="btn-open" href="javascript:void(0)"></a>
                    </div>
                </span>

            </div>
        </nav>
    </header>
    <div class="overlay">
        <div class="menu">
            <div class="container">
                <ul class="header__nav" id="">
                    <li><a href="index.html">Home</a></li>
                    <li><a href="ghc-2023.html">GHC 2023</a></li>
                    <li><a href="organizing-committee.html">Organizing Committee</a></li>
                    <li><a href="photo-gallery-1.html">Photo Gallery</a></li>
                    <li><a href="contactus.aspx" class="active">Contact Us</a></li>
                </ul>
            </div>
        </div>
    </div>
    <section class="banner-section">
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
                                        <asp:TextBox ID="txtFirstName" runat="server" placeholder="Full Name" CssClass="frmfldbx" onkeyup="showProperCase(this);" onkeypress="return isNameAlphabet(event);" onblur="javascript:return validateForm1('name');" MaxLength="50"></asp:TextBox>
                                    </div>
                                </div>

                            </div>
                            <div class="frmtr">
                                <div class="frmtd titlewidth">
                                    <div class="frmslct_area">
                                        <asp:DropDownList runat="server" ID="ddlCompany" CssClass="frmslctbx">
                                            <asp:ListItem Text="+91" Value="+91" Selected="True"></asp:ListItem>
                                            <asp:ListItem Text="+93" Value="+93"></asp:ListItem>
                                            <asp:ListItem Text="+355" Value="+355"></asp:ListItem>
                                            <asp:ListItem Text="+213" Value="+213"></asp:ListItem>
                                            <asp:ListItem Text="+376" Value="+376"></asp:ListItem>
                                            <asp:ListItem Text="+244" Value="+244"></asp:ListItem>
                                            <asp:ListItem Text="+1" Value="+1"></asp:ListItem>
                                            <asp:ListItem Text="+54" Value="+54"></asp:ListItem>
                                            <asp:ListItem Text="+374" Value="+374"></asp:ListItem>
                                            <asp:ListItem Text="+297" Value="+297"></asp:ListItem>
                                            <asp:ListItem Text="+61" Value="+61"></asp:ListItem>
                                            <asp:ListItem Text="+43" Value="+43"></asp:ListItem>
                                            <asp:ListItem Text="+994" Value="+994"></asp:ListItem>
                                            <asp:ListItem Text="+973" Value="+973"></asp:ListItem>
                                            <asp:ListItem Text="+880" Value="+880"></asp:ListItem>
                                            <asp:ListItem Text="+375" Value="+375"></asp:ListItem>
                                            <asp:ListItem Text="+32" Value="+32"></asp:ListItem>
                                            <asp:ListItem Text="+501" Value="+501"></asp:ListItem>
                                            <asp:ListItem Text="+229" Value="+229"></asp:ListItem>
                                            <asp:ListItem Text="+975" Value="+975"></asp:ListItem>
                                            <asp:ListItem Text="+591" Value="+591"></asp:ListItem>
                                            <asp:ListItem Text="+387" Value="+387"></asp:ListItem>
                                            <asp:ListItem Text="+267" Value="+267"></asp:ListItem>
                                            <asp:ListItem Text="+55" Value="+55"></asp:ListItem>
                                            <asp:ListItem Text="+673" Value="+673"></asp:ListItem>
                                            <asp:ListItem Text="+359" Value="+359"></asp:ListItem>
                                            <asp:ListItem Text="+226" Value="+226"></asp:ListItem>
                                            <asp:ListItem Text="+257" Value="+257"></asp:ListItem>
                                            <asp:ListItem Text="+855" Value="+855"></asp:ListItem>
                                            <asp:ListItem Text="+237" Value="+237"></asp:ListItem>
                                            <asp:ListItem Text="+238" Value="+238"></asp:ListItem>
                                            <asp:ListItem Text="+236" Value="+236"></asp:ListItem>
                                            <asp:ListItem Text="+235" Value="+235"></asp:ListItem>
                                            <asp:ListItem Text="+56" Value="+56"></asp:ListItem>
                                            <asp:ListItem Text="+86" Value="+86"></asp:ListItem>
                                            <asp:ListItem Text="+57" Value="+57"></asp:ListItem>
                                            <asp:ListItem Text="+269" Value="+269"></asp:ListItem>
                                            <asp:ListItem Text="+242" Value="+242"></asp:ListItem>
                                            <asp:ListItem Text="+682" Value="+682"></asp:ListItem>
                                            <asp:ListItem Text="+506" Value="+506"></asp:ListItem>
                                            <asp:ListItem Text="+225" Value="+225"></asp:ListItem>
                                            <asp:ListItem Text="+385" Value="+385"></asp:ListItem>
                                            <asp:ListItem Text="+53" Value="+53"></asp:ListItem>
                                            <asp:ListItem Text="+599" Value="+599"></asp:ListItem>
                                            <asp:ListItem Text="+357" Value="+357"></asp:ListItem>
                                            <asp:ListItem Text="+420" Value="+420"></asp:ListItem>
                                            <asp:ListItem Text="+45" Value="+45"></asp:ListItem>
                                            <asp:ListItem Text="+253" Value="+253"></asp:ListItem>
                                            <asp:ListItem Text="+593" Value="+593"></asp:ListItem>
                                            <asp:ListItem Text="+20" Value="+20"></asp:ListItem>
                                            <asp:ListItem Text="+503" Value="+503"></asp:ListItem>
                                            <asp:ListItem Text="+240" Value="+240"></asp:ListItem>
                                            <asp:ListItem Text="+291" Value="+291"></asp:ListItem>
                                            <asp:ListItem Text="+372" Value="+372"></asp:ListItem>
                                            <asp:ListItem Text="+251" Value="+251"></asp:ListItem>
                                            <asp:ListItem Text="+500" Value="+500"></asp:ListItem>
                                            <asp:ListItem Text="+298" Value="+298"></asp:ListItem>
                                            <asp:ListItem Text="+679" Value="+679"></asp:ListItem>
                                            <asp:ListItem Text="+358" Value="+358"></asp:ListItem>
                                            <asp:ListItem Text="+33" Value="+33"></asp:ListItem>
                                            <asp:ListItem Text="+594" Value="+594"></asp:ListItem>
                                            <asp:ListItem Text="+689" Value="+689"></asp:ListItem>
                                            <asp:ListItem Text="+241" Value="+241"></asp:ListItem>
                                            <asp:ListItem Text="+220" Value="+220"></asp:ListItem>
                                            <asp:ListItem Text="+995" Value="+995"></asp:ListItem>
                                            <asp:ListItem Text="+49" Value="+49"></asp:ListItem>
                                            <asp:ListItem Text="+233" Value="+233"></asp:ListItem>
                                            <asp:ListItem Text="+350" Value="+350"></asp:ListItem>
                                            <asp:ListItem Text="+30" Value="+30"></asp:ListItem>
                                            <asp:ListItem Text="+299" Value="+299"></asp:ListItem>
                                            <asp:ListItem Text="+590" Value="+590"></asp:ListItem>
                                            <asp:ListItem Text="+502" Value="+502"></asp:ListItem>
                                            <asp:ListItem Text="+224" Value="+224"></asp:ListItem>
                                            <asp:ListItem Text="+245" Value="+245"></asp:ListItem>
                                            <asp:ListItem Text="+592" Value="+592"></asp:ListItem>
                                            <asp:ListItem Text="+509" Value="+509"></asp:ListItem>
                                            <asp:ListItem Text="+504" Value="+504"></asp:ListItem>
                                            <asp:ListItem Text="+852" Value="+852"></asp:ListItem>
                                            <asp:ListItem Text="+36" Value="+36"></asp:ListItem>
                                            <asp:ListItem Text="+354" Value="+354"></asp:ListItem>
                                            <asp:ListItem Text="+91" Value="+91"></asp:ListItem>
                                            <asp:ListItem Text="+62" Value="+62"></asp:ListItem>
                                            <asp:ListItem Text="+98" Value="+98"></asp:ListItem>
                                            <asp:ListItem Text="+964" Value="+964"></asp:ListItem>
                                            <asp:ListItem Text="+353" Value="+353"></asp:ListItem>
                                            <asp:ListItem Text="+972" Value="+972"></asp:ListItem>
                                            <asp:ListItem Text="+876" Value="+876"></asp:ListItem>
                                            <asp:ListItem Text="+81" Value="+81"></asp:ListItem>
                                            <asp:ListItem Text="+962" Value="+962"></asp:ListItem>
                                            <asp:ListItem Text="+7" Value="+7"></asp:ListItem>
                                            <asp:ListItem Text="+254" Value="+254"></asp:ListItem>
                                            <asp:ListItem Text="+686" Value="+686"></asp:ListItem>
                                            <asp:ListItem Text="+82" Value="+82"></asp:ListItem>
                                            <asp:ListItem Text="+965" Value="+965"></asp:ListItem>
                                            <asp:ListItem Text="+996" Value="+996"></asp:ListItem>
                                            <asp:ListItem Text="+856" Value="+856"></asp:ListItem>
                                            <asp:ListItem Text="+371" Value="+371"></asp:ListItem>
                                            <asp:ListItem Text="+961" Value="+961"></asp:ListItem>
                                            <asp:ListItem Text="+266" Value="+266"></asp:ListItem>
                                            <asp:ListItem Text="+231" Value="+231"></asp:ListItem>
                                            <asp:ListItem Text="+218" Value="+218"></asp:ListItem>
                                            <asp:ListItem Text="+423" Value="+423"></asp:ListItem>
                                            <asp:ListItem Text="+370" Value="+370"></asp:ListItem>
                                            <asp:ListItem Text="+352" Value="+352"></asp:ListItem>
                                            <asp:ListItem Text="+853" Value="+853"></asp:ListItem>
                                            <asp:ListItem Text="+261" Value="+261"></asp:ListItem>
                                            <asp:ListItem Text="+265" Value="+265"></asp:ListItem>
                                            <asp:ListItem Text="+60" Value="+60"></asp:ListItem>
                                            <asp:ListItem Text="+960" Value="+960"></asp:ListItem>
                                            <asp:ListItem Text="+223" Value="+223"></asp:ListItem>
                                            <asp:ListItem Text="+356" Value="+356"></asp:ListItem>
                                            <asp:ListItem Text="+692" Value="+692"></asp:ListItem>
                                            <asp:ListItem Text="+596" Value="+596"></asp:ListItem>
                                            <asp:ListItem Text="+222" Value="+222"></asp:ListItem>
                                            <asp:ListItem Text="+230" Value="+230"></asp:ListItem>
                                            <asp:ListItem Text="+52" Value="+52"></asp:ListItem>
                                            <asp:ListItem Text="+691" Value="+691"></asp:ListItem>
                                            <asp:ListItem Text="+373" Value="+373"></asp:ListItem>
                                            <asp:ListItem Text="+377" Value="+377"></asp:ListItem>
                                            <asp:ListItem Text="+976" Value="+976"></asp:ListItem>
                                            <asp:ListItem Text="+382" Value="+382"></asp:ListItem>
                                            <asp:ListItem Text="+212" Value="+212"></asp:ListItem>
                                            <asp:ListItem Text="+258" Value="+258"></asp:ListItem>
                                            <asp:ListItem Text="+95" Value="+95"></asp:ListItem>
                                            <asp:ListItem Text="+264" Value="+264"></asp:ListItem>
                                            <asp:ListItem Text="+674" Value="+674"></asp:ListItem>
                                            <asp:ListItem Text="+977" Value="+977"></asp:ListItem>
                                            <asp:ListItem Text="+31" Value="+31"></asp:ListItem>
                                            <asp:ListItem Text="+687" Value="+687"></asp:ListItem>
                                            <asp:ListItem Text="+64" Value="+64"></asp:ListItem>
                                            <asp:ListItem Text="+505" Value="+505"></asp:ListItem>
                                            <asp:ListItem Text="+227" Value="+227"></asp:ListItem>
                                            <asp:ListItem Text="+234" Value="+234"></asp:ListItem>
                                            <asp:ListItem Text="+683" Value="+683"></asp:ListItem>
                                            <asp:ListItem Text="+850" Value="+850"></asp:ListItem>
                                            <asp:ListItem Text="+47" Value="+47"></asp:ListItem>
                                            <asp:ListItem Text="+968" Value="+968"></asp:ListItem>
                                            <asp:ListItem Text="+92" Value="+92"></asp:ListItem>
                                            <asp:ListItem Text="+680" Value="+680"></asp:ListItem>
                                            <asp:ListItem Text="+507" Value="+507"></asp:ListItem>
                                            <asp:ListItem Text="+675" Value="+675"></asp:ListItem>
                                            <asp:ListItem Text="+595" Value="+595"></asp:ListItem>
                                            <asp:ListItem Text="+51" Value="+51"></asp:ListItem>
                                            <asp:ListItem Text="+63" Value="+63"></asp:ListItem>
                                            <asp:ListItem Text="+48" Value="+48"></asp:ListItem>
                                            <asp:ListItem Text="+351" Value="+351"></asp:ListItem>
                                            <asp:ListItem Text="+974" Value="+974"></asp:ListItem>
                                            <asp:ListItem Text="+40" Value="+40"></asp:ListItem>
                                            <asp:ListItem Text="+250" Value="+250"></asp:ListItem>
                                            <asp:ListItem Text="+247" Value="+247"></asp:ListItem>
                                            <asp:ListItem Text="+290" Value="+290"></asp:ListItem>
                                            <asp:ListItem Text="+508" Value="+508"></asp:ListItem>
                                            <asp:ListItem Text="+685" Value="+685"></asp:ListItem>
                                            <asp:ListItem Text="+378" Value="+378"></asp:ListItem>
                                            <asp:ListItem Text="+239" Value="+239"></asp:ListItem>
                                            <asp:ListItem Text="+966" Value="+966"></asp:ListItem>
                                            <asp:ListItem Text="+221" Value="+221"></asp:ListItem>
                                            <asp:ListItem Text="+381" Value="+381"></asp:ListItem>
                                            <asp:ListItem Text="+248" Value="+248"></asp:ListItem>
                                            <asp:ListItem Text="+232" Value="+232"></asp:ListItem>
                                            <asp:ListItem Text="+65" Value="+65"></asp:ListItem>
                                            <asp:ListItem Text="+421" Value="+421"></asp:ListItem>
                                            <asp:ListItem Text="+386" Value="+386"></asp:ListItem>
                                            <asp:ListItem Text="+677" Value="+677"></asp:ListItem>
                                            <asp:ListItem Text="+252" Value="+252"></asp:ListItem>
                                            <asp:ListItem Text="+27" Value="+27"></asp:ListItem>
                                            <asp:ListItem Text="+211" Value="+211"></asp:ListItem>
                                            <asp:ListItem Text="+82" Value="+82"></asp:ListItem>
                                            <asp:ListItem Text="+34" Value="+34"></asp:ListItem>
                                            <asp:ListItem Text="+94" Value="+94"></asp:ListItem>
                                            <asp:ListItem Text="+249" Value="+249"></asp:ListItem>
                                            <asp:ListItem Text="+597" Value="+597"></asp:ListItem>
                                            <asp:ListItem Text="+268" Value="+268"></asp:ListItem>
                                            <asp:ListItem Text="+46" Value="+46"></asp:ListItem>
                                            <asp:ListItem Text="+41" Value="+41"></asp:ListItem>
                                            <asp:ListItem Text="+963" Value="+963"></asp:ListItem>
                                            <asp:ListItem Text="+886" Value="+886"></asp:ListItem>
                                            <asp:ListItem Text="+992" Value="+992"></asp:ListItem>
                                            <asp:ListItem Text="+255" Value="+255"></asp:ListItem>
                                            <asp:ListItem Text="+66" Value="+66"></asp:ListItem>
                                            <asp:ListItem Text="+670" Value="+670"></asp:ListItem>
                                            <asp:ListItem Text="+228" Value="+228"></asp:ListItem>
                                            <asp:ListItem Text="+690" Value="+690"></asp:ListItem>
                                            <asp:ListItem Text="+676" Value="+676"></asp:ListItem>
                                            <asp:ListItem Text="+1" Value="+1"></asp:ListItem>
                                            <asp:ListItem Text="+216" Value="+216"></asp:ListItem>
                                            <asp:ListItem Text="+90" Value="+90"></asp:ListItem>
                                            <asp:ListItem Text="+993" Value="+993"></asp:ListItem>
                                            <asp:ListItem Text="+688" Value="+688"></asp:ListItem>
                                            <asp:ListItem Text="+256" Value="+256"></asp:ListItem>
                                            <asp:ListItem Text="+380" Value="+380"></asp:ListItem>
                                            <asp:ListItem Text="+971" Value="+971"></asp:ListItem>
                                            <asp:ListItem Text="+44" Value="+44"></asp:ListItem>
                                            <asp:ListItem Text="+598" Value="+598"></asp:ListItem>
                                            <asp:ListItem Text="+998" Value="+998"></asp:ListItem>
                                            <asp:ListItem Text="+678" Value="+678"></asp:ListItem>
                                            <asp:ListItem Text="+379" Value="+379"></asp:ListItem>
                                            <asp:ListItem Text="+39" Value="+39"></asp:ListItem>
                                            <asp:ListItem Text="+58" Value="+58"></asp:ListItem>
                                            <asp:ListItem Text="+84" Value="+84"></asp:ListItem>
                                            <asp:ListItem Text="+681" Value="+681"></asp:ListItem>
                                            <asp:ListItem Text="+967" Value="+967"></asp:ListItem>
                                            <asp:ListItem Text="+260" Value="+260"></asp:ListItem>
                                            <asp:ListItem Text="+263" Value="+263"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="frmtd mblwidth">
                                    <div class="frmfld_area" id="phoneno">
                                        <asp:TextBox ID="txtMobile" runat="server" placeholder="Mobile" CssClass="frmfldbx" onkeypress="return isnumeric(event);" onblur="javascript:return validateForm1('phone');" MaxLength="10"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="frmtr">
                                <div class="frmtd emailwidth" id="email">
                                    <div class="frmfld_area">
                                        <asp:TextBox ID="txtEmail" runat="server" placeholder="Email" CssClass="frmfldbx" onkeypress="return isemailAlphanumeric(event);" onblur="javascript:return validateForm1('email');" MaxLength="80"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="frmtr">
                                <div class="frmtd batchwidth">
                                    <div class="frmslct_area">
                                        <asp:DropDownList runat="server" ID="ddlBatchFrom" CssClass="frmslctbx" onchange="javascript:return validateForm1('batchfrom');">
                                            <asp:ListItem Text="From" Value="1" disabled selected hidden></asp:ListItem>
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
                                        <asp:DropDownList runat="server" ID="ddlBatchTo" CssClass="frmslctbx" onchange="javascript:return validateForm1('batchto');">
                                            <asp:ListItem Text="To" Value="1" disabled selected hidden></asp:ListItem>
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
                                        <asp:DropDownList runat="server" ID="ddlBatch" CssClass="frmslctbx" onchange="javascript:return validateForm1('attendance');">
                                            <asp:ListItem Text="Attendance" Value="1" disabled selected hidden></asp:ListItem>
                                            <asp:ListItem Text="OCLD/OSHM" Value="OCLD/OSHM"></asp:ListItem>
                                            <asp:ListItem Text="Executive Role" Value="Executive Role"></asp:ListItem>
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
                                <div id="recaptcha-demo" class="g-recaptcha" data-sitekey="6LdlTwwlAAAAALJQgUlPsheTozzWYPkChAbW8XaB"
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
                                <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClientClick="javascript:return validateForm();" OnClick="btnSubmit_Click" />
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
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="javascript:window.location.href='https://globalhospitalityconclave.com';">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <div class="thankubx">
                                <div>
                                    <img src="assets/thankuicn.svg">
                                </div>
                                <div class="thankyoutext">
                                    <h3>Thank you!</h3>
                                    <p>We have made a note of your request and are adding you to our event mailing list, in order to send you timely updates regarding the event.</p>
                                    <div class="submit_btn contnuebtn mx-auto d-block" onclick="javascript:window.location.href='https://globalhospitalityconclave.com';">Continue</div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </section>
    <section class="footer-section">
        <footer>
            <p>
                <a href="mailto:contactus@globalhospitalityconclave.com" style="color: #fff;"><span style="padding: 10px;">
                        <img src="assets/email-icon-global-hospitality-conclave-2023.svg" loading="lazy">
                    </span>contactus@globalhospitalityconclave.com</a>
            </p>
            <p>@ 2023 All Rights Reserved</p>
            <p>Website managed by <a href="https://tlcgroup.com/" target="blank">TLC DigiTech Pvt. Ltd</a>.</p>
        </footer>
    </section>


    <script type="text/javascript">

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
