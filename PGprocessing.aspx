<%@ Page Language="VB" AutoEventWireup="false" CodeFile="PGprocessing.aspx.vb" Inherits="PGprocessing" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript">
        var mode = GetParameterValues('mode');
       
        if (mode == "0") {
            //parent.window.close();
            window.location.href = "https://payit.cc/S33710";
            //window.location.href = "https://payit.cc/S31550";
            //window.open('https://payit.cc/S29368');
        }
        if (mode == "1") {
            //parent.window.close();
            window.location.href = "https://payit.cc/S33711";
            //window.location.href = "https://payit.cc/S31550";
            //window.open('https://payit.cc/S29353');
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
        
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        </div>
    </form>
</body>
</html>
