From: Philip Rakity <prakity-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/2] sdhci: add quirk for lack of 1.8v support
Date: Sun, 25 Nov 2012 20:14:05 +0100
Message-ID: <4D2A8E52-FCBE-49A4-8A73-87D95B2308BC@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8447539137616594696=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Daniel Drake <dsd-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Cc: "jrudholm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <jrudholm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org" <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

--===============8447539137616594696==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_4D2A8E52FCBE49A48A7387D95B2308BCnvidiacom_"

--_000_4D2A8E52FCBE49A48A7387D95B2308BCnvidiacom_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Reviewed-by. Philip Rakity <prakity-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

----- Reply message -----
From: "Daniel Drake" <dsd-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
To: "Philip Rakity" <prakity-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org" <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux=
-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "jrudholm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <jrudholm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "device=
tree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Subject: [PATCH 1/2] sdhci: add quirk for lack of 1.8v support
Date: Sun, Nov 25, 2012 18:50



On Sun, Nov 25, 2012 at 12:36 PM, Philip Rakity <prakity-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrot=
e:
> The same effect can be achieved by setting the quirk
> SDHCI_QUIRK_MISSING_CAPS
> reading caps[0] and removing from caps[1] the UHS values in the control=
ler specific code for your board.
>
> What is the reason you cannot do this ?

The same reasons we already touched upon in the other thread.
http://marc.info/?l=3Dlinux-mmc&m=3D135240077826454&w=3D2
http://marc.info/?l=3Dlinux-mmc&m=3D135240181826846&w=3D2

To reiterate (I know this has been broken out over a couple of weeks):

There is no controller-specific or board-specific code. We are working
with the device tree. It must be done generically.

SDHCI_QUIRK_MISSING_CAPS seems to be aimed at cases where the
controller does not report caps, or it is lying about the caps it
does/doesn't support. In this case our controller is being truthful,
so this does not feel appropriate.

Also, the only realistic way that I can see to combine
SDHCI_QUIRK_MISSING_CAPS with the device tree would be to put the
caps/caps1 override data in the device tree. This just seems ugly, and
feels like it is taking the wrong approach of again suggesting that
the controller is providing bad data, when in this case actually it is
correctly saying that 1.8v is supported (by the controller - it
obviously cannot speak for external components).

We don't have a regulator to work with here.

Thanks
Daniel

-------------------------------------------------------------------------=
----------
This email message is for the sole use of the intended recipient(s) and m=
ay contain
confidential information.  Any unauthorized review, use, disclosure or di=
stribution
is prohibited.  If you are not the intended recipient, please contact the=
=20sender by
reply email and destroy all copies of the original message.
-------------------------------------------------------------------------=
----------

--_000_4D2A8E52FCBE49A48A7387D95B2308BCnvidiacom_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html><head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-885=
9-1">
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text -->
<style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-lef=
t: #800000 2px solid; } --></style></head>
<body>
<style>
<!--
.EmailQuote
=09{margin-left:1pt;
=09padding-left:4pt;
=09border-left:#800000 2px solid}
-->
</style><body><span style=3D"font-family:Arial">Reviewed-by. Philip Rakit=
y &lt;prakity-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org&gt;<br><br><div id=3D"htc_header" style=3D"">---=
-- Reply message -----<br>From: &quot;Daniel Drake&quot; &lt;dsd@laptop.o=
rg&gt;<br>To: &quot;Philip Rakity&quot; &lt;prakity-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org&gt;<br>Cc:=
=20&quot;cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org&quot; &lt;cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org&gt;, &quot;linux-mmc@vge=
r.kernel.org&quot; &lt;linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org&gt;, &quot;jrudholm@gmai=
l.com&quot; &lt;jrudholm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;, &quot;devicetree-discuss-uLR06cmDAlY@public.gmane.org=
labs.org&quot; &lt;devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org&gt;<br>Subject: [P=
ATCH 1/2] sdhci: add quirk for lack of 1.8v support<br>Date: Sun, Nov 25,=
=202012 18:50<br><br></div></span><br><br>
<DIV>
<HR>
</DIV>
<DIV>This email message is for the sole use of the intended recipient(s) =
and may=20
contain confidential information.&nbsp; Any unauthorized review, use, dis=
closure=20
or distribution is prohibited.&nbsp; If you are not the intended recipien=
t,=20
please contact the sender by reply email and destroy all copies of the or=
iginal=20
message. </DIV>
<DIV>
<HR>
</DIV>
<P></P>
</body>
<font size=3D"2"><div class=3D"PlainText">On Sun, Nov 25, 2012 at 12:36 P=
M, Philip Rakity &lt;prakity-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org&gt; wrote:<br>
&gt; The same effect can be achieved by setting the quirk<br>
&gt; SDHCI_QUIRK_MISSING_CAPS<br>
&gt; reading caps[0] and removing from caps[1] the UHS values in the cont=
roller specific code for your board.<br>
&gt;<br>
&gt; What is the reason you cannot do this ?<br>
<br>
The same reasons we already touched upon in the other thread.<br>
<a href=3D"http://marc.info/?l=3Dlinux-mmc&amp;m=3D135240077826454&amp;w=3D=
2">http://marc.info/?l=3Dlinux-mmc&amp;m=3D135240077826454&amp;w=3D2</a><=
br>
<a href=3D"http://marc.info/?l=3Dlinux-mmc&amp;m=3D135240181826846&amp;w=3D=
2">http://marc.info/?l=3Dlinux-mmc&amp;m=3D135240181826846&amp;w=3D2</a><=
br>
<br>
To reiterate (I know this has been broken out over a couple of weeks):<br=
>
<br>
There is no controller-specific or board-specific code. We are working<br=
>
with the device tree. It must be done generically.<br>
<br>
SDHCI_QUIRK_MISSING_CAPS seems to be aimed at cases where the<br>
controller does not report caps, or it is lying about the caps it<br>
does/doesn't support. In this case our controller is being truthful,<br>
so this does not feel appropriate.<br>
<br>
Also, the only realistic way that I can see to combine<br>
SDHCI_QUIRK_MISSING_CAPS with the device tree would be to put the<br>
caps/caps1 override data in the device tree. This just seems ugly, and<br=
>
feels like it is taking the wrong approach of again suggesting that<br>
the controller is providing bad data, when in this case actually it is<br=
>
correctly saying that 1.8v is supported (by the controller - it<br>
obviously cannot speak for external components).<br>
<br>
We don't have a regulator to work with here.<br>
<br>
Thanks<br>
Daniel<br>
</div></font>
</body>
</html>

--_000_4D2A8E52FCBE49A48A7387D95B2308BCnvidiacom_--

--===============8447539137616594696==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============8447539137616594696==--
