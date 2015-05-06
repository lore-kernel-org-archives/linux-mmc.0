From: Suman Tripathi <stripathi@apm.com>
Subject: Re: [PATCH v5 1/1] arm64: dts: Add the arasan sdhc nodes in
 apm-storm.dtsi.
Date: Wed, 6 May 2015 17:27:07 +0530
Message-ID: <CAOHikRBBy2VAG8sO=ZJJqCrqvGaSE1P4kPVvgsx9Q3Q9g8xemQ@mail.gmail.com>
References: <1430817426-5241-1-git-send-email-stripathi@apm.com>
 <4635229.bceBxngCoe@wuerfel> <5549C68B.9090602@xilinx.com>
 <2568634.iEosTvMJpM@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3618844610586003767=="
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <2568634.iEosTvMJpM@wuerfel>
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mark Langsdorf <mlangsdo@redhat.com>, "jcm@redhat.com" <jcm@redhat.com>, Anton Vorontsov <anton@enomsg.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Michal Simek <michal.simek@xilinx.com>, "chris@printf.net" <chris@printf.net>, "patches@apm.com" <patches@apm.com>, Rob Herring <robherring2@gmail.com>, Don Dutile <ddutile@redhat.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

--===============3618844610586003767==
Content-Type: multipart/alternative; boundary=047d7ba97f1a8a684b0515687ea2

--047d7ba97f1a8a684b0515687ea2
Content-Type: text/plain; charset=UTF-8

On Wed, May 6, 2015 at 2:10 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> On Wednesday 06 May 2015 09:45:15 Michal Simek wrote:
> > On 05/06/2015 09:31 AM, Arnd Bergmann wrote:
> > > On Wednesday 06 May 2015 10:41:07 Suman Tripathi wrote:
> > >>>> @@ -533,6 +567,16 @@
> > >>>>                         interrupts = <0x0 0x4f 0x4>;
> > >>>>                 };
> > >>>>
> > >>>> +               sdhc0: sdhc@1c000000 {
> > >>>> +                       device_type = "sdhc";
> > >>>
> > >>> device_type generally should not be used (there are a few
> exceptions).
> > >>
> > >> Okay !!
> > >>
> > >
> > > While we're at it, please change sdhc@1c000000 to mmc@1c000000.
> > > Even though Linux does not care, we try to use the standard device
> > > names for consistency.
> >
> > Do we have a list of these names somewhere?
> > Normally I do use ePARP - generic names recommendation but mmc or sdhci
> > are not listed there.
> > Both combination mmc@ or sdhci@ are used in the kernel.
> >
> > On zynq and zynqmp we do use shdci@.
> >
>
> Ah, I thought ePAPR listed mmc already. Using "sdhci" is a little too
> specific here, since a lot of mmc hosts are not sdhci compliant, and
> "sdhc" is completely wrong, because that identifies a specific card
> type, but a host that supports SDHC cards will generally also work
> with SD (less than 4GB) or SDXC (more than 48GB) cards.
>

Agree on this . Will change it.

>
>         Arnd
>



-- 
Thanks,
with regards,
Suman Tripathi

--047d7ba97f1a8a684b0515687ea2
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Wed, May 6, 2015 at 2:10 PM, Arnd Bergmann <span dir=3D"ltr">&lt;<a =
href=3D"mailto:arnd@arndb.de" target=3D"_blank">arnd@arndb.de</a>&gt;</span=
> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=
=3D"h5">On Wednesday 06 May 2015 09:45:15 Michal Simek wrote:<br>
&gt; On 05/06/2015 09:31 AM, Arnd Bergmann wrote:<br>
&gt; &gt; On Wednesday 06 May 2015 10:41:07 Suman Tripathi wrote:<br>
&gt; &gt;&gt;&gt;&gt; @@ -533,6 +567,16 @@<br>
&gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0interrupts =3D &lt;0x0 0x4f 0x4&gt;;<=
br>
&gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0};<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0sdhc0: sdhc@1c000000 {<br>
&gt; &gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0device_type =3D &quot;sdhc&quot;;<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; device_type generally should not be used (there are a few=
 exceptions).<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Okay !!<br>
&gt; &gt;&gt;<br>
&gt; &gt;<br>
&gt; &gt; While we&#39;re at it, please change sdhc@1c000000 to mmc@1c00000=
0.<br>
&gt; &gt; Even though Linux does not care, we try to use the standard devic=
e<br>
&gt; &gt; names for consistency.<br>
&gt;<br>
&gt; Do we have a list of these names somewhere?<br>
&gt; Normally I do use ePARP - generic names recommendation but mmc or sdhc=
i<br>
&gt; are not listed there.<br>
&gt; Both combination mmc@ or sdhci@ are used in the kernel.<br>
&gt;<br>
&gt; On zynq and zynqmp we do use shdci@.<br>
&gt;<br>
<br>
</div></div>Ah, I thought ePAPR listed mmc already. Using &quot;sdhci&quot;=
 is a little too<br>
specific here, since a lot of mmc hosts are not sdhci compliant, and<br>
&quot;sdhc&quot; is completely wrong, because that identifies a specific ca=
rd<br>
type, but a host that supports SDHC cards will generally also work<br>
with SD (less than 4GB) or SDXC (more than 48GB) cards.<br></blockquote><di=
v><br></div><div>Agree on this . Will change it. =C2=A0</div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;p=
adding-left:1ex">
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Arnd<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div class=3D"gmail_signature"><div dir=3D"ltr"><div>Thanks,</div><div>wi=
th regards,</div>Suman Tripathi</div></div>
</div></div>

--047d7ba97f1a8a684b0515687ea2--

--===============3618844610586003767==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXhwcGMt
ZGV2IG1haWxpbmcgbGlzdApMaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZwpodHRwczovL2xp
c3RzLm96bGFicy5vcmcvbGlzdGluZm8vbGludXhwcGMtZGV2

--===============3618844610586003767==--
