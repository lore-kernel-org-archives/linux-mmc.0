From: Pavan Kunapuli <pkunapuli@nvidia.com>
Subject: Deferring sdhci probe if regulators are not found
Date: Tue, 23 Oct 2012 12:58:13 +0530
Message-ID: <C79B248886DD134989C8FF6B096A91AB7EC6B8C76D@BGMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0183800859106485564=="
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
To: "cjb@laptop.org" <cjb@laptop.org>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>
Cc: "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Pavan Kunapuli <pkunapuli@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

--===============0183800859106485564==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_C79B248886DD134989C8FF6B096A91AB7EC6B8C76DBGMAIL01nvidi_"

--_000_C79B248886DD134989C8FF6B096A91AB7EC6B8C76DBGMAIL01nvidi_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

Tegra sdhci platform driver currently enables the necessary gpios which wil=
l power on the SD host and sd/emmc cards. I have made changes to use vmmc a=
nd vqmmc regulators for the same.

During testing on some platforms, I observed that the there is a possibilit=
y of regulator driver probe being deferred due to dependencies on other mod=
ules like gpio etc. In such case, the vmmc and vqmmc regulators will not be=
 available. MMC/SD cards will not work without enabling the regulators. To =
fix this, I am deferring sdhci probe if regulator_get() calls fail. The pro=
be will continue when the regulators are present. With this change, mmc and=
 SD cards are working properly.

However, this patch would require vmmc, vqmmc supplies to be registered eit=
her with a valid entry or a using dummy regulator entry for all platforms t=
hat use sdhci driver. I am aware of tegra platforms details and can add ent=
ries for the same. I don't know the details of other platforms which are us=
ing sdhci driver. I can try adding regulator_get() calls in the sdhci tegra=
 platform driver and bypass the regulator_get calls in sdhci driver if the =
regulator structures are already present. This wouldn't effect non-tegra pl=
atforms. But, this is more of a hack and not a proper solution. I need sugg=
estions on how to fix the issue properly without affecting other platforms.=
 I have pushed patches with the above mentioned changes. I hope it helps in=
 understanding better on what I am trying to do.

Regards,
Pavan.

--_000_C79B248886DD134989C8FF6B096A91AB7EC6B8C76DBGMAIL01nvidi_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40"><head><meta http-equiv=3DContent-Type content=
=3D"text/html; charset=3Dus-ascii"><meta name=3DGenerator content=3D"Micros=
oft Word 14 (filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";
	mso-fareast-language:EN-US;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri","sans-serif";
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DEN-IN link=3Dblue vli=
nk=3Dpurple><div class=3DWordSection1><p class=3DMsoNormal><span lang=3DEN-=
US>Hi,<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US><o:p>&n=
bsp;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US>Tegra sdhci pl=
atform driver currently enables the necessary gpios which will power on the=
 SD host and sd/emmc cards. I have made changes to use vmmc and vqmmc regul=
ators for the same.<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3D=
EN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US>D=
uring testing on some platforms, I observed that the there is a possibility=
 of regulator driver probe being deferred due to dependencies on other modu=
les like gpio etc. In such case, the vmmc and vqmmc regulators will not be =
available. MMC/SD cards will not work without enabling the regulators. To f=
ix this, I am deferring sdhci probe if regulator_get() calls fail. The prob=
e will continue when the regulators are present. With this change, mmc and =
SD cards are working properly.<o:p></o:p></span></p><p class=3DMsoNormal><s=
pan lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lan=
g=3DEN-US>However, this patch would require vmmc, vqmmc supplies to be regi=
stered either with a valid entry or a using dummy regulator entry for all p=
latforms that use sdhci driver. I am aware of tegra platforms details and c=
an add entries for the same. I don&#8217;t know the details of other platfo=
rms which are using sdhci driver. I can try adding regulator_get() calls in=
 the sdhci tegra platform driver and bypass the regulator_get calls in sdhc=
i driver if the regulator structures are already present. This wouldn&#8217=
;t effect non-tegra platforms. But, this is more of a hack and not a proper=
 solution. I need suggestions on how to fix the issue properly without affe=
cting other platforms. I have pushed patches with the above mentioned chang=
es. I hope it helps in understanding better on what I am trying to do.<o:p>=
</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p><=
/span></p><p class=3DMsoNormal><span lang=3DEN-US>Regards,<o:p></o:p></span=
></p><p class=3DMsoNormal><span lang=3DEN-US>Pavan.<o:p></o:p></span></p></=
div></body></html>=

--_000_C79B248886DD134989C8FF6B096A91AB7EC6B8C76DBGMAIL01nvidi_--


--===============0183800859106485564==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0183800859106485564==--
