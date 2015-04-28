From: Suman Tripathi <stripathi@apm.com>
Subject: Re: [PATCH v2 RESEND 2/2] mmc: host: Add some quirks to be read from
 fdt in sdhci-pltm.c
Date: Tue, 28 Apr 2015 22:23:47 +0530
Message-ID: <CAOHikRDaE0vNE4e6==s=xcDVUOKDA_dgWUrKOjbiWN67jY_K+g@mail.gmail.com>
References: <1429630959-32649-1-git-send-email-stripathi@apm.com>
 <5771531.b7UhrXUGmv@wuerfel>
 <CAOHikRDX7RZUkHFUmNs0kY+aYqXra5i=3cukpjz5yOECkcffbQ@mail.gmail.com>
 <6927395.c8hJ4o34f5@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1330957128891051784=="
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <6927395.c8hJ4o34f5@wuerfel>
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

--===============1330957128891051784==
Content-Type: multipart/alternative; boundary=f46d04462ea2cf0cce0514cbb484

--f46d04462ea2cf0cce0514cbb484
Content-Type: text/plain; charset=UTF-8

On Monday 27 April 2015 21:25:20 Suman Tripathi wrote:
> > On Monday 27 April 2015 20:33:25 Suman Tripathi wrote:
> > > > On Tuesday 21 April 2015 21:12:39 Suman Tripathi wrote:
> > > > > +                       host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
> > > > > +
> > > > > +               if (of_get_property(np, "no-cmd23", NULL))
> > > > > +                       host->quirks2 |=
SDHCI_QUIRK2_HOST_NO_CMD23;
> > > > >
> > > > >                 if (of_get_property(np, "no-1-8-v", NULL))
> > > > >
> > > > >                         host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
> > > >
> > > > Any property you add needs to be documented in the DT binding.
> > > > If possible, add generic properties for each bug you have mmc.txt
> > > > rather than the driver specific sdhci.txt, and implement the
> > >
> > > I will add the binding in mmc.txt. I thought this was present but not.
> > >
> > > > parsing in a common function that is used for all mmc hosts.
> > >
> > > As per mine understanding the sdhci_get_of_porperty is a common
> > > parsing function  . Am I wrong ??
>

A small side note: please fix your email client to use proper attribution
of the citations. The way you reply, nobody knows what you are saying
compare to what you quote. Also, reduce the quotation to the parts you
are replying to.

Ok .  sorry for that ..

> > No, this is only used for sdhci, not for the other controllers.
>
> But our's is a SHCI variant so I added it in this file.

That's my point: a lot of the bugs are independent of the specific
host controller and could happen with any one of them. We want to
ensure that nobody tries to add another property with similar
semantics and a different name just because they are using a
different driver.

Then I am not finding a reason why we have sdhci_get_of_property function
?? .
 I added a generic names like broken-adma that everyone can reuse it.  I
made mistake of not adding it in the binding.

For eg : broken-cd is not added by me but I can use it. So I added
something like broken-adma as it was not present.

> > > An alternative would be to set all these bits based on the compatible
> > > string of your host, if that is the only one that has all these bugs.
> >
> > The host driver  (arasan) is reused but this quirks are needed due to
> > board issues. so I have a control over dtb only to fix this.
>
> What is the nature of the bug on that board? Is there a different
> way to describe that without introducing six new properties?
>
> Sorry it is board and IP as well SoC errata's,
>
> 1. Delay after power is required due to some voltage issues that will
> be fixed in next board revision

This is clearly not sdhci-specific, so make that a generic property
for all mmc.
okay.

> 2. We need to support PIO mode as of now because DMA or ADMA requires
> some kind of translation driver that I am working on.

But this does not describe the hardware properties. Don't add properties
that describe the lack of a kernel driver. If you can't do DMA yet,
use a dma-ranges property that lists one empty range to prevent
dma_set_mask() from working, so it will fall back to PIO mode. You
may have to fix the driver if that doesn't already work.

The generic sdhc framework doesn't have this capabiltiy. It uses the quirks
to identify the broken DMA and ADMA modes even
if the controller is capable of.

What kind of driver do you need here?
For DMA and adma we need some 32 bit to 64 bit translation driver.  The
existing arasan driver only support 32 bit.

> 3. The version of arasan variant we have in our SoC doesn't have the
> HISPD  bit field in HI-SPEED SD card. So this makes HI-SPEED sdcard
> work.
>
> 4. NO_CMD23 is required for eMMC cards.
>
> These are not new properties.  Only the fact is I am using it for our
> SoC from dtb. These quirks are already there in mmc common framework.
> Nothing is new.

Are you sure that you have version 8.9a of the Arasan SDHCI?
Yes
This sounds
like version specific quirks, so they are probably present in each
SoC that uses the same version.
Not sure.

On Tue, Apr 28, 2015 at 1:19 AM, Arnd Bergmann <arnd@arndb.de> wrote:

> On Monday 27 April 2015 21:25:20 Suman Tripathi wrote:
> > > On Monday 27 April 2015 20:33:25 Suman Tripathi wrote:
> > > > > On Tuesday 21 April 2015 21:12:39 Suman Tripathi wrote:
> > > > > > +                       host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
> > > > > > +
> > > > > > +               if (of_get_property(np, "no-cmd23", NULL))
> > > > > > +                       host->quirks2 |=
> SDHCI_QUIRK2_HOST_NO_CMD23;
> > > > > >
> > > > > >                 if (of_get_property(np, "no-1-8-v", NULL))
> > > > > >
> > > > > >                         host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
> > > > >
> > > > > Any property you add needs to be documented in the DT binding.
> > > > > If possible, add generic properties for each bug you have mmc.txt
> > > > > rather than the driver specific sdhci.txt, and implement the
> > > >
> > > > I will add the binding in mmc.txt. I thought this was present but
> not.
> > > >
> > > > > parsing in a common function that is used for all mmc hosts.
> > > >
> > > > As per mine understanding the sdhci_get_of_porperty is a common
> > > > parsing function  . Am I wrong ??
> >
>
> A small side note: please fix your email client to use proper attribution
> of the citations. The way you reply, nobody knows what you are saying
> compare to what you quote. Also, reduce the quotation to the parts you
> are replying to.
>
> > > No, this is only used for sdhci, not for the other controllers.
> >
> > But our's is a SHCI variant so I added it in this file.
>
> That's my point: a lot of the bugs are independent of the specific
> host controller and could happen with any one of them. We want to
> ensure that nobody tries to add another property with similar
> semantics and a different name just because they are using a
> different driver.
>
> > > > An alternative would be to set all these bits based on the compatible
> > > > string of your host, if that is the only one that has all these bugs.
> > >
> > > The host driver  (arasan) is reused but this quirks are needed due to
> > > board issues. so I have a control over dtb only to fix this.
> >
> > What is the nature of the bug on that board? Is there a different
> > way to describe that without introducing six new properties?
> >
> > Sorry it is board and IP as well SoC errata's,
> >
> > 1. Delay after power is required due to some voltage issues that will
> > be fixed in next board revision
>
> This is clearly not sdhci-specific, so make that a generic property
> for all mmc.
>
> > 2. We need to support PIO mode as of now because DMA or ADMA requires
> > some kind of translation driver that I am working on.
>
> But this does not describe the hardware properties. Don't add properties
> that describe the lack of a kernel driver. If you can't do DMA yet,
> use a dma-ranges property that lists one empty range to prevent
> dma_set_mask() from working, so it will fall back to PIO mode. You
> may have to fix the driver if that doesn't already work.
>
> What kind of driver do you need here?
>
> > 3. The version of arasan variant we have in our SoC doesn't have the
> > HISPD  bit field in HI-SPEED SD card. So this makes HI-SPEED sdcard
> > work.
> >
> > 4. NO_CMD23 is required for eMMC cards.
> >
> > These are not new properties.  Only the fact is I am using it for our
> > SoC from dtb. These quirks are already there in mmc common framework.
> > Nothing is new.
>
> Are you sure that you have version 8.9a of the Arasan SDHCI? This sounds
> like version specific quirks, so they are probably present in each
> SoC that uses the same version.
>
>         Arnd
>



-- 
Thanks,
with regards,
Suman Tripathi

--f46d04462ea2cf0cce0514cbb484
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span style=3D"font-size:12.8000001907349px">On Monday 27 =
April 2015 21:25:20 Suman Tripathi wrote:<br>&gt; &gt; On Monday 27 April 2=
015 20:33:25 Suman Tripathi wrote:<br>&gt; &gt; &gt; &gt; On Tuesday 21 Apr=
il 2015 21:12:39 Suman Tripathi wrote:<br></span><span style=3D"font-size:1=
2.8000001907349px">&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0host-&gt;quirks |=3D=
 SDHCI_QUIRK_BROKEN_DMA;<br>&gt; &gt; &gt; &gt; &gt; +<br>&gt; &gt; &gt; &g=
t; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (of_get_=
property(np, &quot;no-cmd23&quot;, NULL))<br>&gt; &gt; &gt; &gt; &gt; +=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0host-&gt;quirks2 |=3D SDHCI_QUIRK2_HOST_NO_CMD23;<br>&gt; &gt; &gt; &=
gt; &gt;<br>&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0if (of_get_property(np, &quot;no-1-8-v&quot;, NULL)=
)<br>&gt; &gt; &gt; &gt; &gt;<br>&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ho=
st-&gt;quirks2 |=3D SDHCI_QUIRK2_NO_1_8_V;<br>&gt; &gt; &gt; &gt;<br>&gt; &=
gt; &gt; &gt; Any property you add needs to be documented in the DT binding=
.<br>&gt; &gt; &gt; &gt; If possible, add generic properties for each bug y=
ou have=C2=A0<span>mmc</span>.txt<br>&gt; &gt; &gt; &gt; rather than the dr=
iver specific sdhci.txt, and implement the<br>&gt; &gt; &gt;<br>&gt; &gt; &=
gt; I will add the binding in=C2=A0<span>mmc</span>.txt. I thought this was=
 present but not.<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; &gt; parsing in a com=
mon function that is used for all=C2=A0<span>mmc</span>=C2=A0hosts.<br>&gt;=
 &gt; &gt;<br>&gt; &gt; &gt; As per mine understanding the sdhci_get_of_por=
perty is a common<br>&gt; &gt; &gt; parsing function=C2=A0 . Am I wrong ??<=
br>&gt;<br><br></span><span style=3D"font-size:12.8000001907349px">A small =
side note: please fix your email client to use proper attribution</span><br=
 style=3D"font-size:12.8000001907349px"><span style=3D"font-size:12.8000001=
907349px">of the citations. The way you reply, nobody knows what you are sa=
ying</span><br style=3D"font-size:12.8000001907349px"><span style=3D"font-s=
ize:12.8000001907349px">compare to what you quote. Also, reduce the quotati=
on to the parts you</span><br style=3D"font-size:12.8000001907349px"><span =
style=3D"font-size:12.8000001907349px">are replying to.</span><div><br></di=
v><div>Ok . =C2=A0sorry for that ..<br style=3D"font-size:12.8000001907349p=
x"><span style=3D"font-size:12.8000001907349px"><br>&gt; &gt; No, this is o=
nly used for sdhci, not for the other controllers.<br>&gt;<br>&gt; But our&=
#39;s is a SHCI variant so I added it in this file.<br><br></span><span sty=
le=3D"font-size:12.8000001907349px">That&#39;s my point: a lot of the bugs =
are independent of the specific</span><br style=3D"font-size:12.80000019073=
49px"><span style=3D"font-size:12.8000001907349px">host controller and coul=
d happen with any one of them. We want to</span><br style=3D"font-size:12.8=
000001907349px"><span style=3D"font-size:12.8000001907349px">ensure that no=
body tries to add another property with similar</span><br style=3D"font-siz=
e:12.8000001907349px"><span style=3D"font-size:12.8000001907349px">semantic=
s and a different name just because they are using a</span><br style=3D"fon=
t-size:12.8000001907349px"><span style=3D"font-size:12.8000001907349px">dif=
ferent driver.</span></div><div><br></div><div>Then I am not finding a reas=
on why we have sdhci_get_of_property function ?? .</div><div>=C2=A0I added =
a generic names like broken-adma that everyone can reuse it.=C2=A0 I made m=
istake of not adding it in the binding.</div><div><br></div><div>For eg : b=
roken-cd is not added by me but I can use it. So I added something like bro=
ken-adma as it was not present.</div><div><span style=3D"font-size:12.80000=
01907349px"><br>&gt; &gt; &gt; An alternative would be to set all these bit=
s based on the compatible<br>&gt; &gt; &gt; string of your host, if that is=
 the only one that has all these bugs.<br>&gt; &gt;<br>&gt; &gt; The host d=
river=C2=A0 (arasan) is reused but this quirks are needed due to<br>&gt; &g=
t; board issues. so I have a control over dtb only to fix this.<br>&gt;<br>=
&gt; What is the nature of the bug on that board? Is there a different<br>&=
gt; way to describe that without introducing six new properties?<br>&gt;<br=
>&gt; Sorry it is board and IP as well SoC errata&#39;s,<br>&gt;<br>&gt; 1.=
 Delay after power is required due to some voltage issues that will<br>&gt;=
 be fixed in next board revision<br><br></span><span style=3D"font-size:12.=
8000001907349px">This is clearly not sdhci-specific, so make that a generic=
 property</span><br style=3D"font-size:12.8000001907349px"><span style=3D"f=
ont-size:12.8000001907349px">for all=C2=A0</span><span style=3D"font-size:1=
2.8000001907349px;background-color:rgb(255,255,255)">mmc</span><span style=
=3D"font-size:12.8000001907349px">.</span></div><div>okay.<br style=3D"font=
-size:12.8000001907349px"><span style=3D"font-size:12.8000001907349px"><br>=
&gt; 2. We need to support PIO mode as of now because DMA or ADMA requires<=
br>&gt; some kind of translation driver that I am working on.<br><br></span=
><span style=3D"font-size:12.8000001907349px">But this does not describe th=
e hardware properties. Don&#39;t add properties</span><br style=3D"font-siz=
e:12.8000001907349px"><span style=3D"font-size:12.8000001907349px">that des=
cribe the lack of a kernel driver. If you can&#39;t do DMA yet,</span><br s=
tyle=3D"font-size:12.8000001907349px"><span style=3D"font-size:12.800000190=
7349px">use a dma-ranges property that lists one empty range to prevent</sp=
an><br style=3D"font-size:12.8000001907349px"><span style=3D"font-size:12.8=
000001907349px">dma_set_mask() from working, so it will fall back to PIO mo=
de. You</span><br style=3D"font-size:12.8000001907349px"><span style=3D"fon=
t-size:12.8000001907349px">may have to fix the driver if that doesn&#39;t a=
lready work.</span></div><div><br></div><div>The generic sdhc framework doe=
sn&#39;t have this capabiltiy. It uses the quirks to identify the broken DM=
A and ADMA modes even</div><div>if the controller is capable of.<br><br sty=
le=3D"font-size:12.8000001907349px"><span style=3D"font-size:12.80000019073=
49px">What kind of driver do you need here?</span></div><div>For DMA and ad=
ma we need some 32 bit to 64 bit translation driver.=C2=A0 The existing ara=
san driver only support 32 bit.<br style=3D"font-size:12.8000001907349px"><=
span style=3D"font-size:12.8000001907349px"><br>&gt; 3. The version of aras=
an variant we have in our SoC doesn&#39;t have the<br>&gt; HISPD=C2=A0 bit =
field in HI-SPEED SD card. So this makes HI-SPEED sdcard<br>&gt; work.<br>&=
gt;<br>&gt; 4. NO_CMD23 is required for eMMC cards.<br>&gt;<br>&gt; These a=
re not new properties.=C2=A0 Only the fact is I am using it for our<br>&gt;=
 SoC from dtb. These quirks are already there in=C2=A0<span>mmc</span>=C2=
=A0common framework.<br>&gt; Nothing is new.<br><br></span><span style=3D"f=
ont-size:12.8000001907349px">Are you sure that you have version 8.9a of the=
 Arasan SDHCI?=C2=A0</span></div><div><span style=3D"font-size:12.800000190=
7349px">Yes</span></div><div><span style=3D"font-size:12.8000001907349px">T=
his sounds</span><br style=3D"font-size:12.8000001907349px"><span style=3D"=
font-size:12.8000001907349px">like version specific quirks, so they are pro=
bably present in each</span><br style=3D"font-size:12.8000001907349px"><spa=
n style=3D"font-size:12.8000001907349px">SoC that uses the same version.</s=
pan></div><div><span style=3D"font-size:12.8000001907349px">Not sure.<br></=
span><div style=3D"font-size:12.8000001907349px"><div><img src=3D"https://s=
sl.gstatic.com/ui/v1/icons/mail/images/cleardot.gif"></div></div></div></di=
v><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Tue, Apr 28,=
 2015 at 1:19 AM, Arnd Bergmann <span dir=3D"ltr">&lt;<a href=3D"mailto:arn=
d@arndb.de" target=3D"_blank">arnd@arndb.de</a>&gt;</span> wrote:<br><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex"><span class=3D"">On Monday 27 April 2015 21:25:20 =
Suman Tripathi wrote:<br>
&gt; &gt; On Monday 27 April 2015 20:33:25 Suman Tripathi wrote:<br>
&gt; &gt; &gt; &gt; On Tuesday 21 April 2015 21:12:39 Suman Tripathi wrote:=
<br>
</span><span class=3D"">&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0host-&gt;quirks =
|=3D SDHCI_QUIRK_BROKEN_DMA;<br>
&gt; &gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0if (of_get_property(np, &quot;no-cmd23&quot;, NULL))<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0host-&gt;quirks2 |=3D SDHCI_QUIRK2_HOST_N=
O_CMD23;<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0if (of_get_property(np, &quot;no-1-8-v&quot;, NULL))<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0host-&gt;quirks2 |=3D SDHCI_QUIRK2=
_NO_1_8_V;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Any property you add needs to be documented in the DT b=
inding.<br>
&gt; &gt; &gt; &gt; If possible, add generic properties for each bug you ha=
ve mmc.txt<br>
&gt; &gt; &gt; &gt; rather than the driver specific sdhci.txt, and implemen=
t the<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; I will add the binding in mmc.txt. I thought this was presen=
t but not.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; parsing in a common function that is used for all mmc h=
osts.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; As per mine understanding the sdhci_get_of_porperty is a com=
mon<br>
&gt; &gt; &gt; parsing function=C2=A0 . Am I wrong ??<br>
&gt;<br>
<br>
</span>A small side note: please fix your email client to use proper attrib=
ution<br>
of the citations. The way you reply, nobody knows what you are saying<br>
compare to what you quote. Also, reduce the quotation to the parts you<br>
are replying to.<br>
<span class=3D""><br>
&gt; &gt; No, this is only used for sdhci, not for the other controllers.<b=
r>
&gt;<br>
&gt; But our&#39;s is a SHCI variant so I added it in this file.<br>
<br>
</span>That&#39;s my point: a lot of the bugs are independent of the specif=
ic<br>
host controller and could happen with any one of them. We want to<br>
ensure that nobody tries to add another property with similar<br>
semantics and a different name just because they are using a<br>
different driver.<br>
<span class=3D""><br>
&gt; &gt; &gt; An alternative would be to set all these bits based on the c=
ompatible<br>
&gt; &gt; &gt; string of your host, if that is the only one that has all th=
ese bugs.<br>
&gt; &gt;<br>
&gt; &gt; The host driver=C2=A0 (arasan) is reused but this quirks are need=
ed due to<br>
&gt; &gt; board issues. so I have a control over dtb only to fix this.<br>
&gt;<br>
&gt; What is the nature of the bug on that board? Is there a different<br>
&gt; way to describe that without introducing six new properties?<br>
&gt;<br>
&gt; Sorry it is board and IP as well SoC errata&#39;s,<br>
&gt;<br>
&gt; 1. Delay after power is required due to some voltage issues that will<=
br>
&gt; be fixed in next board revision<br>
<br>
</span>This is clearly not sdhci-specific, so make that a generic property<=
br>
for all mmc.<br>
<span class=3D""><br>
&gt; 2. We need to support PIO mode as of now because DMA or ADMA requires<=
br>
&gt; some kind of translation driver that I am working on.<br>
<br>
</span>But this does not describe the hardware properties. Don&#39;t add pr=
operties<br>
that describe the lack of a kernel driver. If you can&#39;t do DMA yet,<br>
use a dma-ranges property that lists one empty range to prevent<br>
dma_set_mask() from working, so it will fall back to PIO mode. You<br>
may have to fix the driver if that doesn&#39;t already work.<br>
<br>
What kind of driver do you need here?<br>
<span class=3D""><br>
&gt; 3. The version of arasan variant we have in our SoC doesn&#39;t have t=
he<br>
&gt; HISPD=C2=A0 bit field in HI-SPEED SD card. So this makes HI-SPEED sdca=
rd<br>
&gt; work.<br>
&gt;<br>
&gt; 4. NO_CMD23 is required for eMMC cards.<br>
&gt;<br>
&gt; These are not new properties.=C2=A0 Only the fact is I am using it for=
 our<br>
&gt; SoC from dtb. These quirks are already there in mmc common framework.<=
br>
&gt; Nothing is new.<br>
<br>
</span>Are you sure that you have version 8.9a of the Arasan SDHCI? This so=
unds<br>
like version specific quirks, so they are probably present in each<br>
SoC that uses the same version.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Arnd<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div class=3D"gmail_signature"><div dir=3D"ltr"><div>Thanks,</div><div>wi=
th regards,</div>Suman Tripathi</div></div>
</div>

--f46d04462ea2cf0cce0514cbb484--

--===============1330957128891051784==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXhwcGMt
ZGV2IG1haWxpbmcgbGlzdApMaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZwpodHRwczovL2xp
c3RzLm96bGFicy5vcmcvbGlzdGluZm8vbGludXhwcGMtZGV2

--===============1330957128891051784==--
