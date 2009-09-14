From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: EXT_CSD  Register : CSD_STRUCTURE vs CSD_CSD_REV
Date: Mon, 14 Sep 2009 20:34:35 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B02F6454333@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0816670603=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, "Raju,
	Veeramanikandan" <veera@ti.com>, "Joshi, Rhishi" <rhishi@ti.com>, "Sawant, Anand" <sawant@ti.com>, "Benjamin.Telya@sandisk.com" <Benjamin.Telya@sandisk.com>, "drzeus-list@drzeus.cx" <drzeus-list@drzeus.cx>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>
List-Id: linux-mmc@vger.kernel.org

--===============0816670603==
Content-Language: en-US
Content-Type: multipart/related;
	boundary="_005_2A3DCF3DA181AD40BDE86A3150B27B6B02F6454333dbde02enttico_";
	type="multipart/alternative"

--_005_2A3DCF3DA181AD40BDE86A3150B27B6B02F6454333dbde02enttico_
Content-Type: multipart/alternative;
	boundary="_000_2A3DCF3DA181AD40BDE86A3150B27B6B02F6454333dbde02enttico_"

--_000_2A3DCF3DA181AD40BDE86A3150B27B6B02F6454333dbde02enttico_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,

I am working in Linux MMC driver.
Recently I came across one 16GB MMC card where EXT_CSD Register having EXT_=
CSD_REV[192] field as ZERO, which is valid according to Specification. But =
card is not working due to following reason -

 1.  As we know there are two fields in Extended CSD Register -  CSD_STRUCT=
URE Version[194] & EXT_CSD_REV Revision [192].


 1.  In mmc.c/ mmc_read_ext_csd ()
    *   Implementation expecting EXT_CSD_REV non zero (e.g. >3 in current c=
ode)
    *   I think it could be checking for CSD_STRUCTURE version.
    *   Because EXT_CSD_REV having Zero is the valid Field.
    *   This is the way it's done in other OS too.


 1.  To check the high capacity card.
    *   We could check in access mode from OCR.  This is not in Linux exact=
ly and steps to check the EXT_CSD_REV.
    *   This is done in some other OS too.

So do you think we can update the code to check the CSD_STRUCTURE Version? =
Please let us know your opinion.

[cid:image001.gif@01CA357A.C599E580]
[cid:image002.gif@01CA357A.C599E580]

Thanks & regards,
Sukumar Ghorai

---------------------------------------------------------------------------=
----------

WTSD, Texas Instruments,

#66/3 Bagmane Tech Park, CVRaman Nagar, Bangalore, India-560093.

Voice: +91-80-25048868

http://www.india.ti.com<http://www.india.ti.com/>

---------------------------------------------------------------------------=
----------


--_000_2A3DCF3DA181AD40BDE86A3150B27B6B02F6454333dbde02enttico_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:x=3D"urn:schemas-microsoft-com:office:excel" xmlns:p=3D"urn:schemas-m=
icrosoft-com:office:powerpoint" xmlns:a=3D"urn:schemas-microsoft-com:office=
:access" xmlns:dt=3D"uuid:C2F41010-65B3-11d1-A29F-00AA00C14882" xmlns:s=3D"=
uuid:BDC6E3F0-6DA3-11d1-A2A3-00AA00C14882" xmlns:rs=3D"urn:schemas-microsof=
t-com:rowset" xmlns:z=3D"#RowsetSchema" xmlns:b=3D"urn:schemas-microsoft-co=
m:office:publisher" xmlns:ss=3D"urn:schemas-microsoft-com:office:spreadshee=
t" xmlns:c=3D"urn:schemas-microsoft-com:office:component:spreadsheet" xmlns=
:odc=3D"urn:schemas-microsoft-com:office:odc" xmlns:oa=3D"urn:schemas-micro=
soft-com:office:activation" xmlns:html=3D"http://www.w3.org/TR/REC-html40" =
xmlns:q=3D"http://schemas.xmlsoap.org/soap/envelope/" xmlns:rtc=3D"http://m=
icrosoft.com/officenet/conferencing" xmlns:D=3D"DAV:" xmlns:Repl=3D"http://=
schemas.microsoft.com/repl/" xmlns:mt=3D"http://schemas.microsoft.com/share=
point/soap/meetings/" xmlns:x2=3D"http://schemas.microsoft.com/office/excel=
/2003/xml" xmlns:ppda=3D"http://www.passport.com/NameSpace.xsd" xmlns:ois=
=3D"http://schemas.microsoft.com/sharepoint/soap/ois/" xmlns:dir=3D"http://=
schemas.microsoft.com/sharepoint/soap/directory/" xmlns:ds=3D"http://www.w3=
.org/2000/09/xmldsig#" xmlns:dsp=3D"http://schemas.microsoft.com/sharepoint=
/dsp" xmlns:udc=3D"http://schemas.microsoft.com/data/udc" xmlns:xsd=3D"http=
://www.w3.org/2001/XMLSchema" xmlns:sub=3D"http://schemas.microsoft.com/sha=
repoint/soap/2002/1/alerts/" xmlns:ec=3D"http://www.w3.org/2001/04/xmlenc#"=
 xmlns:sp=3D"http://schemas.microsoft.com/sharepoint/" xmlns:sps=3D"http://=
schemas.microsoft.com/sharepoint/soap/" xmlns:xsi=3D"http://www.w3.org/2001=
/XMLSchema-instance" xmlns:udcs=3D"http://schemas.microsoft.com/data/udc/so=
ap" xmlns:udcxf=3D"http://schemas.microsoft.com/data/udc/xmlfile" xmlns:udc=
p2p=3D"http://schemas.microsoft.com/data/udc/parttopart" xmlns:st=3D"&#1;" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" xmlns=3D"http://ww=
w.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><o:SmartTagType
 namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags" name=3D"place"=
/>
<o:SmartTagType namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"State"/>
<!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
</style>
<![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Batang;
	panose-1:2 3 6 0 0 1 1 1 1 1;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
	{font-family:"\@Batang";
	panose-1:0 0 0 0 0 0 0 0 0 0;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
p
	{mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:12.0pt;
	font-family:"Times New Roman";}
span.EmailStyle18
	{mso-style-type:personal-compose;
	font-family:"Courier New";
	color:windowtext;
	font-weight:normal;
	font-style:normal;
	text-decoration:none none;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
 /* List Definitions */
 @list l0
	{mso-list-id:1426685501;
	mso-list-template-ids:-1900656446;}
@list l0:level1
	{mso-level-start-at:2;
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1
	{mso-list-id:1519007434;
	mso-list-type:hybrid;
	mso-list-template-ids:-627910974 67698703 67698713 67698715 67698703 67698=
713 67698715 67698703 67698713 67698715;}
@list l1:level1
	{mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level3
	{mso-level-tab-stop:1.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level4
	{mso-level-tab-stop:2.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level5
	{mso-level-tab-stop:2.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level6
	{mso-level-tab-stop:3.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level7
	{mso-level-tab-stop:3.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level8
	{mso-level-tab-stop:4.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level9
	{mso-level-tab-stop:4.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2
	{mso-list-id:1657102862;
	mso-list-template-ids:597836014;}
@list l2:level1
	{mso-level-start-at:3;
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l3
	{mso-list-id:1832867933;
	mso-list-template-ids:-2063933562;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DTahoma><span style=3D'font-size:=
10.0pt;
font-family:Tahoma'>Hello,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DTahoma><span style=3D'font-size:=
10.0pt;
font-family:Tahoma'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DTahoma><span style=3D'font-size:=
10.0pt;
font-family:Tahoma'>I am working in Linux MMC driver.<o:p></o:p></span></fo=
nt></p>

<p class=3DMsoNormal><font size=3D2 face=3DTahoma><span style=3D'font-size:=
10.0pt;
font-family:Tahoma'>Recently I came across one 16GB MMC card where EXT_CSD
Register having EXT_CSD_REV[192] field as ZERO, which is valid according to
Specification. But card is not working due to following reason -<o:p></o:p>=
</span></font></p>

<ol style=3D'margin-top:0in' start=3D1 type=3D1>
 <li class=3DMsoNormal style=3D'mso-list:l1 level1 lfo3'><font size=3D2 fac=
e=3DTahoma><span
     style=3D'font-size:10.0pt;font-family:Tahoma'>As we know there are two
     fields in Extended CSD Register - &nbsp;CSD_STRUCTURE Version[194] &am=
p;
     EXT_CSD_REV Revision [192]. <o:p></o:p></span></font></li>
</ol>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 face=3DTaho=
ma><span
style=3D'font-size:10.0pt;font-family:Tahoma'><o:p>&nbsp;</o:p></span></fon=
t></p>

<ol style=3D'margin-top:0in' start=3D2 type=3D1>
 <li class=3DMsoNormal style=3D'mso-list:l1 level1 lfo3'><font size=3D2 fac=
e=3DTahoma><span
     style=3D'font-size:10.0pt;font-family:Tahoma'>In mmc.c/ mmc_read_ext_c=
sd ()<o:p></o:p></span></font></li>
 <ol style=3D'margin-top:0in' start=3D1 type=3Da>
  <li class=3DMsoNormal style=3D'mso-list:l1 level2 lfo3'><font size=3D2 fa=
ce=3DTahoma><span
      style=3D'font-size:10.0pt;font-family:Tahoma'>Implementation expectin=
g EXT_CSD_REV
      non zero (e.g. &gt;3 in current code)<o:p></o:p></span></font></li>
  <li class=3DMsoNormal style=3D'mso-list:l1 level2 lfo3'><font size=3D2 fa=
ce=3DTahoma><span
      style=3D'font-size:10.0pt;font-family:Tahoma'>I think it could be che=
cking
      for CSD_STRUCTURE version. <o:p></o:p></span></font></li>
  <li class=3DMsoNormal style=3D'mso-list:l1 level2 lfo3'><font size=3D2 fa=
ce=3DTahoma><span
      style=3D'font-size:10.0pt;font-family:Tahoma'>Because EXT_CSD_REV hav=
ing <b><span
      style=3D'font-weight:bold'>Zero</span></b> is the valid Field. <o:p><=
/o:p></span></font></li>
  <li class=3DMsoNormal style=3D'mso-list:l1 level2 lfo3'><font size=3D2 fa=
ce=3DTahoma><span
      style=3D'font-size:10.0pt;font-family:Tahoma'>This is the way it&#821=
7;s
      done in other OS too.<o:p></o:p></span></font></li>
 </ol>
</ol>

<p class=3DMsoNormal><font size=3D2 face=3DTahoma><span style=3D'font-size:=
10.0pt;
font-family:Tahoma'><o:p>&nbsp;</o:p></span></font></p>

<ol style=3D'margin-top:0in' start=3D3 type=3D1>
 <li class=3DMsoNormal style=3D'mso-list:l1 level1 lfo3'><font size=3D2 fac=
e=3DTahoma><span
     style=3D'font-size:10.0pt;font-family:Tahoma'>To check the high capaci=
ty
     card. <o:p></o:p></span></font></li>
 <ol style=3D'margin-top:0in' start=3D1 type=3Da>
  <li class=3DMsoNormal style=3D'mso-list:l1 level2 lfo3'><font size=3D2 fa=
ce=3DTahoma><span
      style=3D'font-size:10.0pt;font-family:Tahoma'>We could check in acces=
s mode
      from OCR. &nbsp;This is not in Linux exactly and steps to check the
      EXT_CSD_REV. <o:p></o:p></span></font></li>
  <li class=3DMsoNormal style=3D'mso-list:l1 level2 lfo3'><font size=3D2 fa=
ce=3DTahoma><span
      style=3D'font-size:10.0pt;font-family:Tahoma'>This is done in some ot=
her OS
      too. <o:p></o:p></span></font></li>
 </ol>
</ol>

<p class=3DMsoNormal style=3D'margin-left:.75in'><font size=3D2 face=3DTaho=
ma><span
style=3D'font-size:10.0pt;font-family:Tahoma'><o:p>&nbsp;</o:p></span></fon=
t></p>

<p class=3DMsoNormal><u><font size=3D2 face=3DTahoma><span style=3D'font-si=
ze:10.0pt;
font-family:Tahoma'>So do you think we can update the code to check the
CSD_STRUCTURE Version? Please let us know your opinion.<o:p></o:p></span></=
font></u></p>

<p class=3DMsoNormal><font size=3D2 face=3DTahoma><span style=3D'font-size:=
10.0pt;
font-family:Tahoma'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DTahoma><span style=3D'font-size:=
10.0pt;
font-family:Tahoma'><img width=3D675 height=3D143 id=3D"_x0000_i1025"
src=3D"cid:image001.gif@01CA357A.C599E580"><o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DTahoma><span style=3D'font-size:=
10.0pt;
font-family:Tahoma'><img width=3D671 height=3D114 id=3D"_x0000_i1026"
src=3D"cid:image002.gif@01CA357A.C599E580"><o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DTahoma><span style=3D'font-size:=
10.0pt;
font-family:Tahoma'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DTahoma><span style=3D'font-size:=
10.0pt;
font-family:Tahoma'>Thanks &amp; regards,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DTahoma><span style=3D'font-size:=
10.0pt;
font-family:Tahoma'>Sukumar Ghorai<o:p></o:p></span></font></p>

<p style=3D'margin:0in;margin-bottom:.0001pt'><i><font size=3D1 color=3Dgra=
y
face=3D"Times New Roman"><span style=3D'font-size:7.5pt;color:gray;font-sty=
le:italic'>----------------------------------------------------------------=
---------------------<o:p></o:p></span></font></i></p>

<p style=3D'margin:0in;margin-bottom:.0001pt'><i><font size=3D1 color=3Dgra=
y
face=3D"Times New Roman"><span style=3D'font-size:7.5pt;color:gray;font-sty=
le:italic'>WTSD,
<st1:State w:st=3D"on"><st1:place w:st=3D"on">Texas</st1:place></st1:State>
Instruments, <o:p></o:p></span></font></i></p>

<p style=3D'margin:0in;margin-bottom:.0001pt'><i><font size=3D1 color=3Dgra=
y
face=3D"Times New Roman"><span lang=3DDE style=3D'font-size:7.5pt;color:gra=
y;
font-style:italic'>#66/3 Bagmane Tech Park, CVRaman Nagar, Bangalore,
India-560093. <o:p></o:p></span></font></i></p>

<p style=3D'margin:0in;margin-bottom:.0001pt'><i><font size=3D1 color=3Dgra=
y
face=3D"Times New Roman"><span style=3D'font-size:7.5pt;color:gray;font-sty=
le:italic'>Voice:
+91-80-25048868<o:p></o:p></span></font></i></p>

<p style=3D'margin:0in;margin-bottom:.0001pt'><font size=3D3 face=3D"Times =
New Roman"><span
style=3D'font-size:12.0pt'><a href=3D"http://www.india.ti.com/"><i><font si=
ze=3D1><span
style=3D'font-size:7.5pt;font-style:italic'>http://www.india.ti.com</span><=
/font></i></a></span></font><i><font
size=3D1 color=3Dgray><span style=3D'font-size:7.5pt;color:gray;font-style:=
italic'> <o:p></o:p></span></font></i></p>

<p style=3D'margin:0in;margin-bottom:.0001pt'><font size=3D1 color=3Dgray
face=3D"Times New Roman"><span style=3D'font-size:7.5pt;color:gray'>-------=
---------------------------------------------------------------------------=
---<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

--_000_2A3DCF3DA181AD40BDE86A3150B27B6B02F6454333dbde02enttico_--

--_005_2A3DCF3DA181AD40BDE86A3150B27B6B02F6454333dbde02enttico_
Content-Type: image/gif; name="image001.gif"
Content-Description: image001.gif
Content-Disposition: inline; filename="image001.gif"; size=15335;
	creation-date="Mon, 14 Sep 2009 20:34:35 GMT";
	modification-date="Mon, 14 Sep 2009 20:34:35 GMT"
Content-ID: <image001.gif@01CA357A.C599E580>
Content-Transfer-Encoding: base64

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
ADs=

--_005_2A3DCF3DA181AD40BDE86A3150B27B6B02F6454333dbde02enttico_
Content-Type: image/gif; name="image002.gif"
Content-Description: image002.gif
Content-Disposition: inline; filename="image002.gif"; size=10512;
	creation-date="Mon, 14 Sep 2009 20:34:35 GMT";
	modification-date="Mon, 14 Sep 2009 20:34:35 GMT"
Content-ID: <image002.gif@01CA357A.C599E580>
Content-Transfer-Encoding: base64

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
Rud0VudY1WaiQgJ3aOd4lud5RsyAAAA7

--_005_2A3DCF3DA181AD40BDE86A3150B27B6B02F6454333dbde02enttico_--


--===============0816670603==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0816670603==--
