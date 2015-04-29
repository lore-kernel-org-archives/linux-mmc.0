From: Suman Tripathi <stripathi@apm.com>
Subject: Re: [PATCH v2 RESEND 2/2] mmc: host: Add some quirks to be read from
 fdt in sdhci-pltm.c
Date: Wed, 29 Apr 2015 19:55:53 +0530
Message-ID: <CAOHikRD6enDS2VyYH4Nz_+wz_m2v-61QyBDLixZxm-Y0qYtojA@mail.gmail.com>
References: <1429630959-32649-1-git-send-email-stripathi@apm.com>
 <6927395.c8hJ4o34f5@wuerfel>
 <CAOHikRAYtPt67-ZOFz890v46v28gtvQDPhgH1qA8d4xoSaQ7+Q@mail.gmail.com>
 <17258495.kJWOqBBcrn@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3606084246666415688=="
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <17258495.kJWOqBBcrn@wuerfel>
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Mark Langsdorf <mlangsdo@redhat.com>, Jon Masters <jcm@redhat.com>, Anton Vorontsov <anton@enomsg.org>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, patches <patches@apm.com>, Don Dutile <ddutile@redhat.com>, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

--===============3606084246666415688==
Content-Type: multipart/alternative; boundary=047d7ba9713cb31b550514ddc164

--047d7ba9713cb31b550514ddc164
Content-Type: text/plain; charset=UTF-8

On Wed, Apr 29, 2015 at 2:45 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> On Wednesday 29 April 2015 12:34:41 Suman Tripathi wrote:
> > On Tue, Apr 28, 2015 at 1:19 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Monday 27 April 2015 21:25:20 Suman Tripathi wrote:
> > >> > On Monday 27 April 2015 20:33:25 Suman Tripathi wrote:
> > >> > > > On Tuesday 21 April 2015 21:12:39 Suman Tripathi wrote:
> > >> > > > > +                       host->quirks |=
> SDHCI_QUIRK_BROKEN_DMA;
> > >> > > > > +
> > >> > > > > +               if (of_get_property(np, "no-cmd23", NULL))
> > >> > > > > +                       host->quirks2 |=
> SDHCI_QUIRK2_HOST_NO_CMD23;
> > >> > > > >
> > >> > > > >                 if (of_get_property(np, "no-1-8-v", NULL))
> > >> > > > >
> > >> > > > >                         host->quirks2 |=
> SDHCI_QUIRK2_NO_1_8_V;
> > >> > > >
> > >> > > > Any property you add needs to be documented in the DT binding.
> > >> > > > If possible, add generic properties for each bug you have
> mmc.txt
> > >> > > > rather than the driver specific sdhci.txt, and implement the
> > >> > >
> > >> > > I will add the binding in mmc.txt. I thought this was present but
> not.
> > >> > >
> > >> > > > parsing in a common function that is used for all mmc hosts.
> > >> > >
> > >> > > As per mine understanding the sdhci_get_of_porperty is a common
> > >> > > parsing function  . Am I wrong ??
> > >>
> > >
> > > A small side note: please fix your email client to use proper
> attribution
> > > of the citations. The way you reply, nobody knows what you are saying
> > > compare to what you quote. Also, reduce the quotation to the parts you
> > > are replying to.
> > >
> >
> > Okay. Sorry for that. I fixed it.
>
> Ok, much better.
>
> > >> > No, this is only used for sdhci, not for the other controllers.
> > >>
> > >> But our's is a SHCI variant so I added it in this file.
> > >
> > > That's my point: a lot of the bugs are independent of the specific
> > > host controller and could happen with any one of them. We want to
> > > ensure that nobody tries to add another property with similar
> > > semantics and a different name just because they are using a
> > > different driver.
> >
> > Then I am not finding a reason why we have sdhci_get_of_property
> function ?? .
> >  I added a generic names like broken-adma that everyone can reuse it.
> > I made mistake of not adding it in the binding.
> >
> > For eg : broken-cd is not added by me but I can use it. So I added
> > something like broken-adma as it was not present.
>
> The common mmc_of_parse() handles "broken-cd", and the
> sdhci_get_of_property()
> does so too. This is really a mistake we made earlier when it was added
> to sdhi instead of the common code. We should remove the parsing for
> that property from the sdhci driver and have the core handle it always,
> but that require someone to do it and ensure that no subtle ABI changes
> are introduced on the way.
>

I was not aware of the mmc_of_parse() . Agree now.

>
> For new properties, the right way is to add it to the common function only.
>
> > >> 2. We need to support PIO mode as of now because DMA or ADMA requires
> > >> some kind of translation driver that I am working on.
> > >
> > > But this does not describe the hardware properties. Don't add
> properties
> > > that describe the lack of a kernel driver. If you can't do DMA yet,
> > > use a dma-ranges property that lists one empty range to prevent
> > > dma_set_mask() from working, so it will fall back to PIO mode. You
> > > may have to fix the driver if that doesn't already work.
> > >
> >
> > The generic sdhc framework doesn't have this capabiltiy. It uses the
> > quirks to identify the broken DMA and ADMA modes even
> > if the controller is capable of.
> >
> > > What kind of driver do you need here?
> >
> > For DMA and adma we need some 32 bit to 64 bit translation driver.
> > The existing arasan driver only support 32 bit.
>
> Ok, that sounds like a very simple case: The width of the DMA is determined
> from DT by looking at the dma-ranges properties. If it doesn't work, one
> of these steps that are supposed to happen are broken and you should
> try to find out which one that is and fix it:
>
> - The parent node of the sdhci device in DT must not claim to support
>   64 bit if the bus is only 32-bit wide. A dma-ranges property containing
>   "<0 0 1 0>" would describe a bus that has a 32-bit DMA address range that
>   is 1:1 mapped to the root bus, which is the default.


> - The ARM64 code must check that property in a call to dma_set_mask()
>   or dma_set_mask_and_coherent(), and not allow a mask to be set that
>   exceeds the size of the dma-ranges property.
>
> - The sdhci driver must call dma_set_mask() or dma_set_mask_and_coherent()
>   with the mask that is claimed by the device (usually 32 bit or 64 bit)
>   and check the result.
>
> - If the call to dma_set_mask() for the 64-bit mask fails, the driver must
>   fall back to using the 32-bit mask and not attempt to use the 64-bit
>   DMA registers.
>
This is the behavior we require anyway, and if this all works, you don't
> need the extra quirks.
>
> The above assumes that the limitation is enforced by the bus (e.g. an
> AHB bus can only do 32-bit DMA). It would be a little different if you
> have a 64-bit AXI bus and the Arasan device itself is limited to 32-bit
> independent of the width of the bus it is connected to. Can you find out
> which of these two cases you have?
>

We have 64 bit AXI and Arasan device or controller is 32 bit . So there is
64 bit AXI to 32 bit AHB translation.


> > >> 3. The version of arasan variant we have in our SoC doesn't have the
> > >> HISPD  bit field in HI-SPEED SD card. So this makes HI-SPEED sdcard
> > >> work.
> > >>
> > >> 4. NO_CMD23 is required for eMMC cards.
> > >>
> > >> These are not new properties.  Only the fact is I am using it for our
> > >> SoC from dtb. These quirks are already there in mmc common framework.
> > >> Nothing is new.
> > >
> > > Are you sure that you have version 8.9a of the Arasan SDHCI? This
> sounds
> >
> > No We are using 4.9a ARASAN SDHCI
>
> Ok, then add a compatible string for this version to the arasan binding,
> and set the quirks flags only for the 4.9a version and not for the 8.9a
> version.
>

Okay

>
>         Arnd
>



-- 
Thanks,
with regards,
Suman Tripathi

--047d7ba9713cb31b550514ddc164
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Wed, Apr 29, 2015 at 2:45 PM, Arnd Bergmann <span dir=3D"ltr">&lt;<a=
 href=3D"mailto:arnd@arndb.de" target=3D"_blank">arnd@arndb.de</a>&gt;</spa=
n> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex"><span class=3D"">On Wednesday 2=
9 April 2015 12:34:41 Suman Tripathi wrote:<br>
&gt; On Tue, Apr 28, 2015 at 1:19 AM, Arnd Bergmann &lt;<a href=3D"mailto:a=
rnd@arndb.de">arnd@arndb.de</a>&gt; wrote:<br>
&gt; &gt; On Monday 27 April 2015 21:25:20 Suman Tripathi wrote:<br>
&gt; &gt;&gt; &gt; On Monday 27 April 2015 20:33:25 Suman Tripathi wrote:<b=
r>
&gt; &gt;&gt; &gt; &gt; &gt; On Tuesday 21 April 2015 21:12:39 Suman Tripat=
hi wrote:<br>
&gt; &gt;&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0host-&gt;quirks |=3D SDHCI_QUI=
RK_BROKEN_DMA;<br>
&gt; &gt;&gt; &gt; &gt; &gt; &gt; +<br>
&gt; &gt;&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0if (of_get_property(np, &quot;no-cmd23&quot;, NULL))<br>
&gt; &gt;&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0host-&gt;quirks2 |=3D SDHCI_QU=
IRK2_HOST_NO_CMD23;<br>
&gt; &gt;&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt;&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0if (of_get_property(np, &quot;no-1-8-v&quot;, NULL))<br=
>
&gt; &gt;&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt;&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0host-&gt;quirks2 |=3D SDHCI=
_QUIRK2_NO_1_8_V;<br>
&gt; &gt;&gt; &gt; &gt; &gt;<br>
&gt; &gt;&gt; &gt; &gt; &gt; Any property you add needs to be documented in=
 the DT binding.<br>
&gt; &gt;&gt; &gt; &gt; &gt; If possible, add generic properties for each b=
ug you have mmc.txt<br>
&gt; &gt;&gt; &gt; &gt; &gt; rather than the driver specific sdhci.txt, and=
 implement the<br>
&gt; &gt;&gt; &gt; &gt;<br>
&gt; &gt;&gt; &gt; &gt; I will add the binding in mmc.txt. I thought this w=
as present but not.<br>
&gt; &gt;&gt; &gt; &gt;<br>
&gt; &gt;&gt; &gt; &gt; &gt; parsing in a common function that is used for =
all mmc hosts.<br>
&gt; &gt;&gt; &gt; &gt;<br>
&gt; &gt;&gt; &gt; &gt; As per mine understanding the sdhci_get_of_porperty=
 is a common<br>
&gt; &gt;&gt; &gt; &gt; parsing function=C2=A0 . Am I wrong ??<br>
&gt; &gt;&gt;<br>
&gt; &gt;<br>
&gt; &gt; A small side note: please fix your email client to use proper att=
ribution<br>
&gt; &gt; of the citations. The way you reply, nobody knows what you are sa=
ying<br>
&gt; &gt; compare to what you quote. Also, reduce the quotation to the part=
s you<br>
&gt; &gt; are replying to.<br>
&gt; &gt;<br>
&gt;<br>
&gt; Okay. Sorry for that. I fixed it.<br>
<br>
</span>Ok, much better.<br>
<span class=3D""><br>
&gt; &gt;&gt; &gt; No, this is only used for sdhci, not for the other contr=
ollers.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; But our&#39;s is a SHCI variant so I added it in this file.<b=
r>
&gt; &gt;<br>
&gt; &gt; That&#39;s my point: a lot of the bugs are independent of the spe=
cific<br>
&gt; &gt; host controller and could happen with any one of them. We want to=
<br>
&gt; &gt; ensure that nobody tries to add another property with similar<br>
&gt; &gt; semantics and a different name just because they are using a<br>
&gt; &gt; different driver.<br>
&gt;<br>
&gt; Then I am not finding a reason why we have sdhci_get_of_property funct=
ion ?? .<br>
&gt;=C2=A0 I added a generic names like broken-adma that everyone can reuse=
 it.<br>
&gt; I made mistake of not adding it in the binding.<br>
&gt;<br>
&gt; For eg : broken-cd is not added by me but I can use it. So I added<br>
&gt; something like broken-adma as it was not present.<br>
<br>
</span>The common mmc_of_parse() handles &quot;broken-cd&quot;, and the sdh=
ci_get_of_property()<br>
does so too. This is really a mistake we made earlier when it was added<br>
to sdhi instead of the common code. We should remove the parsing for<br>
that property from the sdhci driver and have the core handle it always,<br>
but that require someone to do it and ensure that no subtle ABI changes<br>
are introduced on the way.<br></blockquote><div>=C2=A0</div><div>I was not =
aware of the mmc_of_parse() . Agree now.</div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
">
<br>
For new properties, the right way is to add it to the common function only.=
<br>
<span class=3D""><br>
&gt; &gt;&gt; 2. We need to support PIO mode as of now because DMA or ADMA =
requires<br>
&gt; &gt;&gt; some kind of translation driver that I am working on.<br>
&gt; &gt;<br>
&gt; &gt; But this does not describe the hardware properties. Don&#39;t add=
 properties<br>
&gt; &gt; that describe the lack of a kernel driver. If you can&#39;t do DM=
A yet,<br>
&gt; &gt; use a dma-ranges property that lists one empty range to prevent<b=
r>
&gt; &gt; dma_set_mask() from working, so it will fall back to PIO mode. Yo=
u<br>
&gt; &gt; may have to fix the driver if that doesn&#39;t already work.<br>
&gt; &gt;<br>
&gt;<br>
&gt; The generic sdhc framework doesn&#39;t have this capabiltiy. It uses t=
he<br>
&gt; quirks to identify the broken DMA and ADMA modes even<br>
&gt; if the controller is capable of.<br>
&gt;<br>
&gt; &gt; What kind of driver do you need here?<br>
&gt;<br>
&gt; For DMA and adma we need some 32 bit to 64 bit translation driver.<br>
&gt; The existing arasan driver only support 32 bit.<br>
<br>
</span>Ok, that sounds like a very simple case: The width of the DMA is det=
ermined<br>
from DT by looking at the dma-ranges properties. If it doesn&#39;t work, on=
e<br>
of these steps that are supposed to happen are broken and you should<br>
try to find out which one that is and fix it:<br>
<br>
- The parent node of the sdhci device in DT must not claim to support<br>
=C2=A0 64 bit if the bus is only 32-bit wide. A dma-ranges property contain=
ing<br>
=C2=A0 &quot;&lt;0 0 1 0&gt;&quot; would describe a bus that has a 32-bit D=
MA address range that<br>
=C2=A0 is 1:1 mapped to the root bus, which is the default.=C2=A0</blockquo=
te><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex">
<br>
- The ARM64 code must check that property in a call to dma_set_mask()<br>
=C2=A0 or dma_set_mask_and_coherent(), and not allow a mask to be set that<=
br>
=C2=A0 exceeds the size of the dma-ranges property.<br>
<br>
- The sdhci driver must call dma_set_mask() or dma_set_mask_and_coherent()<=
br>
=C2=A0 with the mask that is claimed by the device (usually 32 bit or 64 bi=
t)<br>
=C2=A0 and check the result.<br>
<br>
- If the call to dma_set_mask() for the 64-bit mask fails, the driver must<=
br>
=C2=A0 fall back to using the 32-bit mask and not attempt to use the 64-bit=
<br>
=C2=A0 DMA registers.=C2=A0<br></blockquote><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
This is the behavior we require anyway, and if this all works, you don&#39;=
t<br>
need the extra quirks.<br>
<br>
The above assumes that the limitation is enforced by the bus (e.g. an<br>
AHB bus can only do 32-bit DMA). It would be a little different if you<br>
have a 64-bit AXI bus and the Arasan device itself is limited to 32-bit<br>
independent of the width of the bus it is connected to. Can you find out<br=
>
which of these two cases you have?=C2=A0<br></blockquote><div><br></div><di=
v>We have 64 bit AXI and Arasan device or controller is 32 bit . So there i=
s 64 bit AXI to 32 bit AHB translation.=C2=A0</div><div><br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex">
<span class=3D""><br>
&gt; &gt;&gt; 3. The version of arasan variant we have in our SoC doesn&#39=
;t have the<br>
&gt; &gt;&gt; HISPD=C2=A0 bit field in HI-SPEED SD card. So this makes HI-S=
PEED sdcard<br>
&gt; &gt;&gt; work.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; 4. NO_CMD23 is required for eMMC cards.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; These are not new properties.=C2=A0 Only the fact is I am usi=
ng it for our<br>
&gt; &gt;&gt; SoC from dtb. These quirks are already there in mmc common fr=
amework.<br>
&gt; &gt;&gt; Nothing is new.<br>
&gt; &gt;<br>
&gt; &gt; Are you sure that you have version 8.9a of the Arasan SDHCI? This=
 sounds<br>
&gt;<br>
&gt; No We are using 4.9a ARASAN SDHCI<br>
<br>
</span>Ok, then add a compatible string for this version to the arasan bind=
ing,<br>
and set the quirks flags only for the 4.9a version and not for the 8.9a<br>
version.<br></blockquote><div>=C2=A0</div><div>Okay=C2=A0</div><blockquote =
class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid=
;padding-left:1ex">
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Arnd<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div class=3D"gmail_signature"><div dir=3D"ltr"><div>Thanks,</div><div>wi=
th regards,</div>Suman Tripathi</div></div>
</div></div>

--047d7ba9713cb31b550514ddc164--

--===============3606084246666415688==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXhwcGMt
ZGV2IG1haWxpbmcgbGlzdApMaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZwpodHRwczovL2xp
c3RzLm96bGFicy5vcmcvbGlzdGluZm8vbGludXhwcGMtZGV2

--===============3606084246666415688==--
