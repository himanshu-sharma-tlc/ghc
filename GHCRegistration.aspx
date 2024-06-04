<%@ Page Language="VB" %>
<%@ Import Namespace="System.Net" %>
<%@ Import Namespace="System.IO" %>
<%@import Namespace="System.Data.SqlClient" %>
<%@import Namespace="System.Data" %>
<script runat="server">
    Protected Sub Page_Load(sender As Object, e As EventArgs)
        If (Not (String.IsNullOrEmpty(Request.QueryString("name")))) Then
            Dim utm_source As String = ""
            Dim utm_medium As String = ""
            Dim utm_campaign As String = ""
            If (Not (String.IsNullOrEmpty(Request.QueryString("utm_source")) Or String.IsNullOrEmpty(Request.QueryString("utm_medium")) Or String.IsNullOrEmpty(Request.QueryString("utm_campaign")))) Then
                utm_source = Request.QueryString("utm_source")
                utm_medium = Request.QueryString("utm_medium")
                utm_campaign = Request.QueryString("utm_campaign")
            End If
            If (Request.QueryString("mode") = "0") Then

                Dim connectionstring As String = System.Configuration.ConfigurationManager.ConnectionStrings("GHC_Con").ConnectionString
                Dim con As SqlConnection = New SqlConnection(connectionstring)
                con.Open()
                Dim cmd As SqlCommand = New SqlCommand()
                cmd.CommandText = "usp_InsertGHCData"
                cmd.Connection = con
                cmd.CommandType = System.Data.CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@Name", Request.QueryString("name"))
                cmd.Parameters.AddWithValue("@Mobile", Request.QueryString("country") & " " & Request.QueryString("phone"))
                cmd.Parameters.AddWithValue("@Email", Request.QueryString("email"))
                cmd.Parameters.AddWithValue("@BatchFrom", Request.QueryString("BatchFrom"))
                cmd.Parameters.AddWithValue("@BatchTo", Request.QueryString("BatchTo"))
                cmd.Parameters.AddWithValue("@Attendance", Request.QueryString("attendance"))
                cmd.Parameters.AddWithValue("@DelegateName", "")
                cmd.Parameters.AddWithValue("@RegistrationType", "Alumni")
                cmd.Parameters.AddWithValue("@utm_source", utm_source)
                cmd.Parameters.AddWithValue("@utm_medium", utm_medium)
                cmd.Parameters.AddWithValue("@utm_campaign", utm_campaign)
                Dim status As Integer = cmd.ExecuteNonQuery()
                Dim name As String = Request.QueryString("name")
                Dim Message As New Net.Mail.MailMessage()
                Dim FromEmail As New Net.Mail.MailAddress("contactus@globalhospitalityconclave.com", "Global Hospitality Conclave")
                Message.From = FromEmail
                'Drop to Internal Team
                Dim TLCMessage As New Net.Mail.MailMessage()
                TLCMessage.From = FromEmail
                TLCMessage.To.Add(New Net.Mail.MailAddress("contactus@globalhospitalityconclave.com", "contactus@globalhospitalityconclave.com"))
                'TLCMessage.To.Add(New Net.Mail.MailAddress("sarvesh.gupta@tlcgroup.com", "sarvesh.gupta@tlcgroup.com"))
                TLCMessage.IsBodyHtml = True
                TLCMessage.Subject = "GHC 2024 Registration"
                Dim pathToHTMLFile1 As String = Server.MapPath("~/drop.html")
                Dim messageToUser1 As String = File.ReadAllText(pathToHTMLFile1)
                messageToUser1 = messageToUser1.Replace("$$FirstName$$", name)
                messageToUser1 = messageToUser1.Replace("$$Email$$", Request.QueryString("email"))
                messageToUser1 = messageToUser1.Replace("$$Mobile$$", Request.QueryString("country") + " " + Request.QueryString("phone"))
                messageToUser1 = messageToUser1.Replace("$$batch$$", Request.QueryString("BatchFrom") + " - " + Request.QueryString("BatchTo"))
                messageToUser1 = messageToUser1.Replace("$$Attendance$$", Request.QueryString("attendance"))
                TLCMessage.Body = messageToUser1
                TLCMessage.BodyEncoding = Encoding.UTF8


                'TLCMessage.CC.Add(New Net.Mail.MailAddress("sarvesh.gupta@tlcgroup.com", "sarvesh.gupta@tlcgroup.com"))
                TLCMessage.CC.Add(New Net.Mail.MailAddress("kamini.sharma@tlcgroup.com", "kamini.sharma@tlcgroup.com"))
                TLCMessage.CC.Add(New Net.Mail.MailAddress("shailendra@tlcgroup.com", "shailendra@tlcgroup.com"))
                ''TLCMessage.CC.Add(New Net.Mail.MailAddress("aarti.gautam@tlcgroup.com", "aarti.gautam@tlcgroup.com"))
                TLCMessage.CC.Add(New Net.Mail.MailAddress("sudhir@tlcgroup.com", "sudhir@tlcgroup.com"))
                TLCMessage.CC.Add(New Net.Mail.MailAddress("tanuj.arora@tlcgroup.com", "tanuj.arora@tlcgroup.com"))
                TLCMessage.CC.Add(New Net.Mail.MailAddress("azam.md@tlcgroup.com", "azam.md@tlcgroup.com"))
                Dim SmtpTLC As New Net.Mail.SmtpClient("relay-hosting.secureserver.net", 25)
                SmtpTLC.UseDefaultCredentials = False
                SmtpTLC.EnableSsl = False
                SmtpTLC.Send(TLCMessage)
                Server.Transfer("PGprocessing.aspx?mode=0")
                'Page.ClientScript.RegisterClientScriptBlock(Page.GetType(), "CallMyMethod", "javascript:window.close();")
            End If
            If (Request.QueryString("mode") = "1") Then
                Dim connectionstring As String = System.Configuration.ConfigurationManager.ConnectionStrings("GHC_Con").ConnectionString
                Dim con As SqlConnection = New SqlConnection(connectionstring)
                con.Open()
                Dim cmd As SqlCommand = New SqlCommand()
                cmd.CommandText = "usp_InsertGHCData"
                cmd.Connection = con
                cmd.CommandType = System.Data.CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@Name", Request.QueryString("name"))
                cmd.Parameters.AddWithValue("@DelegateName", Request.QueryString("delegate"))
                cmd.Parameters.AddWithValue("@RegistrationType", "Spouse")
                cmd.Parameters.AddWithValue("@utm_source", utm_source)
                cmd.Parameters.AddWithValue("@utm_medium", utm_medium)
                cmd.Parameters.AddWithValue("@utm_campaign", utm_campaign)
                Dim status As Integer = cmd.ExecuteNonQuery()
                Dim name As String = Request.QueryString("name")
                Dim Message As New Net.Mail.MailMessage()
                Dim FromEmail As New Net.Mail.MailAddress("contactus@globalhospitalityconclave.com", "Global Hospitality Conclave")
                Message.From = FromEmail
                'Drop to Internal Team
                Dim TLCMessage As New Net.Mail.MailMessage()
                TLCMessage.From = FromEmail
                TLCMessage.To.Add(New Net.Mail.MailAddress("contactus@globalhospitalityconclave.com", "contactus@globalhospitalityconclave.com"))
                'TLCMessage.To.Add(New Net.Mail.MailAddress("sarvesh.gupta@tlcgroup.com", "sarvesh.gupta@tlcgroup.com"))
                TLCMessage.IsBodyHtml = True
                TLCMessage.Subject = "GHC 2024 | Spouse Registration"
                Dim pathToHTMLFile1 As String = Server.MapPath("~/drop1.html")
                Dim messageToUser1 As String = File.ReadAllText(pathToHTMLFile1)
                messageToUser1 = messageToUser1.Replace("$$FirstName$$", name)
                messageToUser1 = messageToUser1.Replace("$$delegate$$", Request.QueryString("delegate"))
                TLCMessage.Body = messageToUser1
                TLCMessage.BodyEncoding = Encoding.UTF8

                'TLCMessage.CC.Add(New Net.Mail.MailAddress("sarvesh.gupta@tlcgroup.com", "sarvesh.gupta@tlcgroup.com"))
                'TLCMessage.CC.Add(New Net.Mail.MailAddress("rahul.shekhawat@tlcgroup.com", "rahul.shekhawat@tlcgroup.com"))
                TLCMessage.CC.Add(New Net.Mail.MailAddress("kamini.sharma@tlcgroup.com", "kamini.sharma@tlcgroup.com"))
                TLCMessage.CC.Add(New Net.Mail.MailAddress("shailendra@tlcgroup.com", "shailendra@tlcgroup.com"))
                ''TLCMessage.CC.Add(New Net.Mail.MailAddress("aarti.gautam@tlcgroup.com", "aarti.gautam@tlcgroup.com"))
                TLCMessage.CC.Add(New Net.Mail.MailAddress("sudhir@tlcgroup.com", "sudhir@tlcgroup.com"))
                TLCMessage.CC.Add(New Net.Mail.MailAddress("tanuj.arora@tlcgroup.com", "tanuj.arora@tlcgroup.com"))
                Dim SmtpTLC As New Net.Mail.SmtpClient("relay-hosting.secureserver.net", 25)
                SmtpTLC.UseDefaultCredentials = False
                SmtpTLC.EnableSsl = False
                SmtpTLC.Send(TLCMessage)
                Server.Transfer("PGprocessing.aspx?mode=1")
            End If
        End If
    End Sub
</script>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        </div>
    </form>
</body>
</html>
