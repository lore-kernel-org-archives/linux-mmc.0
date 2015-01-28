From: Suman Tripathi <stripathi@apm.com>
Subject: Re: [PATCH v1 2/2] arm64: dts: Add the arasan sdhc nodes in
 apm-storm.dtsi.
Date: Wed, 28 Jan 2015 09:48:56 +0530
Message-ID: <CAOHikRB4tSkJsMccqHRS8XYULaP+dS7KujeSLh+ZpTxDDOF5xQ@mail.gmail.com>
References: <1422379260-10139-1-git-send-email-stripathi@apm.com>
 <1422379260-10139-3-git-send-email-stripathi@apm.com>
 <4747424.udeKOcy6tC@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5854058578692608132=="
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <4747424.udeKOcy6tC@wuerfel>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mark Langsdorf <mlangsdo@redhat.com>, Jon Masters <jcm@redhat.com>, anton@enomsg.org, linux-mmc@vger.kernel.org, chris@printf.net, patches <patches@apm.com>, Don Dutile <ddutile@redhat.com>, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

--===============5854058578692608132==
Content-Type: multipart/alternative; boundary=089e01634b9287a004050daeabcf

--089e01634b9287a004050daeabcf
Content-Type: text/plain; charset=UTF-8

Hi Arnd,

On Tuesday 27 January 2015 22:51:00 Suman Tripathi wrote:
>
> +               sdhc0: sdhc@1c000000 {
> +                       device_type = "sdhc";
> +                       compatible = "arasan,sdhci-8.9a";
> +                       reg = <0x0 0x1c000000 0x0 0x100>;
> +                       interrupts = <0x0 0x49 0x4>;
> +                       clock-names = "clk_xin", "clk_ahb";
> +                       clocks = <&sdioclk 0>, <&ahbclk 0>;
> +               };
> +

Here you don't provide an 'iommus' property, which means that the
device is unable to use the iommu.
I added the iommus in the IOMMU AHBC patch. Anything wrong in that ? In the
next version Also I will remove the IOMMU hacks from arasan driver


On Wed, Jan 28, 2015 at 1:43 AM, Arnd Bergmann <arnd@arndb.de> wrote:

> On Tuesday 27 January 2015 22:51:00 Suman Tripathi wrote:
> >
> > +               sdhc0: sdhc@1c000000 {
> > +                       device_type = "sdhc";
> > +                       compatible = "arasan,sdhci-8.9a";
> > +                       reg = <0x0 0x1c000000 0x0 0x100>;
> > +                       interrupts = <0x0 0x49 0x4>;
> > +                       clock-names = "clk_xin", "clk_ahb";
> > +                       clocks = <&sdioclk 0>, <&ahbclk 0>;
> > +               };
> > +
>
> Here you don't provide an 'iommus' property, which means that the
> device is unable to use the iommu.
>
>         Arnd
>



-- 
Thanks,
with regards,
Suman Tripathi

--089e01634b9287a004050daeabcf
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Arnd,<div><br></div><div><span class=3D"im" style=3D"fo=
nt-size:13px">On Tuesday 27 January 2015 22:51:00 Suman Tripathi wrote:<br>=
&gt;<br>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sdhc0:=
 sdhc@1c000000 {<br>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0device_type =3D &quot;sdhc&quot;;<br>&gt;=
 +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0compatible =3D &quot;arasan,sdhci-8.9a&quot;;<br>&gt; +=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0re=
g =3D &lt;0x0 0x1c000000 0x0 0x100&gt;;<br>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0interrupts =3D &=
lt;0x0 0x49 0x4&gt;;<br>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0clock-names =3D &quot;clk_xin&quot;, =
&quot;clk_ahb&quot;;<br>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0clocks =3D &lt;&amp;sdioclk 0&gt;, &l=
t;&amp;ahbclk 0&gt;;<br>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0};<br>&gt; +<br><br></span><span style=3D"font-size:13px">Here yo=
u don&#39;t provide an &#39;iommus&#39; property, which means that the</spa=
n><br style=3D"font-size:13px"><span style=3D"font-size:13px">device is una=
ble to use the iommu.</span><div class=3D"" style=3D"font-size:13px"><div i=
d=3D":87" class=3D"" tabindex=3D"0"><img class=3D"" src=3D"https://ssl.gsta=
tic.com/ui/v1/icons/mail/images/cleardot.gif"></div><div id=3D":87" class=
=3D"" tabindex=3D"0">I added the iommus in the IOMMU AHBC patch. Anything w=
rong in that ? In the next version Also I will remove the IOMMU hacks from =
arasan driver=C2=A0</div><div id=3D":87" class=3D"" tabindex=3D"0"><br></di=
v></div></div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quot=
e">On Wed, Jan 28, 2015 at 1:43 AM, Arnd Bergmann <span dir=3D"ltr">&lt;<a =
href=3D"mailto:arnd@arndb.de" target=3D"_blank">arnd@arndb.de</a>&gt;</span=
> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex"><span class=3D"">On Tuesday 27 J=
anuary 2015 22:51:00 Suman Tripathi wrote:<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sdhc0: sdhc@1c=
000000 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0device_type =3D &quot;sdhc&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0compatible =3D &quot;arasan,sdhci-8.9a&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0reg =3D &lt;0x0 0x1c000000 0x0 0x100&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0interrupts =3D &lt;0x0 0x49 0x4&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0clock-names =3D &quot;clk_xin&quot;, &quot;clk_ahb&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0clocks =3D &lt;&amp;sdioclk 0&gt;, &lt;&amp;ahbclk 0&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt; +<br>
<br>
</span>Here you don&#39;t provide an &#39;iommus&#39; property, which means=
 that the<br>
device is unable to use the iommu.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Arnd<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div class=3D"gmail_signature"><div dir=3D"ltr"><div>Thanks,</div><div>wi=
th regards,</div>Suman Tripathi</div></div>
</div>

--089e01634b9287a004050daeabcf--

--===============5854058578692608132==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXhwcGMt
ZGV2IG1haWxpbmcgbGlzdApMaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZwpodHRwczovL2xp
c3RzLm96bGFicy5vcmcvbGlzdGluZm8vbGludXhwcGMtZGV2

--===============5854058578692608132==--
