From: Matthew Leon <matthewleon@linux.com>
Subject: Re: [PATCH mmc-next v3 3/3] mmc: sdhci-of-dwcmshc: solve 128MB DMA
 boundary limitation
Date: Mon, 30 Jul 2018 03:11:59 +0000
Message-ID: <01010164e92bcc18-d4fd119e-62e5-4aba-a6e3-9d5787f31a1b-000000@us-west-2.amazonses.com>
References: <20180730104228.28b58bd0@xhacker.debian> <20180730104636.1a3e6c81@xhacker.debian>
 <01010164e91d7bda-aa616cbf-7bb2-4fe4-85e5-a18e16433fde-000000@us-west-2.amazonses.com>
 <20180730105954.6c365a7b@xhacker.debian>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary="000000000000e2ee1c05722ed231"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180730105954.6c365a7b@xhacker.debian>
Sender: linux-kernel-owner@vger.kernel.org
To: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

--000000000000e2ee1c05722ed231
Content-Type: text/plain; charset="UTF-8"

 >> Hey Jisheng,

>Hi,

>>

>In LKML, we'd better not top post.

Noted. My apologies.

>> Shouldn't we be splitting until all DMA blocks are less than 128M
boundary?
>> I am a noob, but I think we should be prepared for boundaries that when
>> split in two, will still be greater than 128M. Feel free to disagree but
>> please explain why I may be wrong. Thank-you.

>the limitation is "DMA addr can't span 128MB boundary" rather than "must be
>less than 128MB", they are different.

>And the max transfer size of one DMA desc is 64KB.

>thanks

I have misspoken. What if the DMA transfer size is 1024M? If we split in
two, then we have 2 transfers, each of which span 512M. So wouldn't we need
to split again to have 4 transfers, each of which span 128M?

Sincerely,
Matthew Leon


On Sun, Jul 29, 2018 at 10:59 PM, Jisheng Zhang <Jisheng.Zhang@synaptics.com
> wrote:

> On Mon, 30 Jul 2018 02:56:20 +0000 Matthew Leon <matthewleon@linux.com>
> wrote:
>
> > Hey Jisheng,
>
> Hi,
>
> >
>
> In LKML, we'd better not top post.
>
> > Shouldn't we be splitting until all DMA blocks are less than 128M
> boundary?
> > I am a noob, but I think we should be prepared for boundaries that when
> > split in two, will still be greater than 128M. Feel free to disagree but
> > please explain why I may be wrong. Thank-you.
>
> the limitation is "DMA addr can't span 128MB boundary" rather than "must be
> less than 128MB", they are different.
>
> And the max transfer size of one DMA desc is 64KB.
>
> thanks
>
> >
> > Sincerely,
> > Matthew Leon
> >
> > On Sun, Jul 29, 2018 at 10:46 PM, Jisheng Zhang <
> Jisheng.Zhang@synaptics.com
> > > wrote:
> >
> > > When using DMA, if the DMA addr spans 128MB boundary, we have to split
> > > the DMA transfer into two so that each one doesn't exceed the boundary.
> > >
> > > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> > > ---
> > >  drivers/mmc/host/sdhci-of-dwcmshc.c | 43
> +++++++++++++++++++++++++++++
> > >  1 file changed, 43 insertions(+)
> > >
> > > diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c
> > > b/drivers/mmc/host/sdhci-of-dwcmshc.c
> > > index 1b7cd144fb01..e890fc8f5284 100644
> > > --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> > > +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> > > @@ -8,21 +8,52 @@
> > >   */
> > >
> > >  #include <linux/clk.h>
> > > +#include <linux/mm.h>
> > >  #include <linux/module.h>
> > >  #include <linux/of.h>
> > > +#include <linux/sizes.h>
> > >
> > >  #include "sdhci-pltfm.h"
> > >
> > > +#define BOUNDARY_OK(addr, len) \
> > > +       ((addr | (SZ_128M - 1)) == ((addr + len - 1) | (SZ_128M - 1)))
> > > +
> > >  struct dwcmshc_priv {
> > >         struct clk      *bus_clk;
> > >  };
> > >
> > > +/*
> > > + * if DMA addr spans 128MB boundary, we split the DMA transfer into
> two
> > > + * so that the DMA transfer doesn't exceed the boundary.
> > > + */
> > > +static unsigned int dwcmshc_adma_write_desc(struct sdhci_host *host,
> > > +                                           void *desc, dma_addr_t
> addr,
> > > +                                           int len, unsigned int cmd)
> > > +{
> > > +       int tmplen, offset;
> > > +
> > > +       if (likely(!len || BOUNDARY_OK(addr, len)))
> > > +               return _sdhci_adma_write_desc(host, desc, addr, len,
> cmd);
> > > +
> > > +       offset = addr & (SZ_128M - 1);
> > > +       tmplen = SZ_128M - offset;
> > > +       _sdhci_adma_write_desc(host, desc, addr, tmplen, cmd);
> > > +
> > > +       addr += tmplen;
> > > +       len -= tmplen;
> > > +       desc += host->desc_sz;
> > > +       _sdhci_adma_write_desc(host, desc, addr, len, cmd);
> > > +
> > > +       return host->desc_sz * 2;
> > > +}
> > > +
> > >  static const struct sdhci_ops sdhci_dwcmshc_ops = {
> > >         .set_clock              = sdhci_set_clock,
> > >         .set_bus_width          = sdhci_set_bus_width,
> > >         .set_uhs_signaling      = sdhci_set_uhs_signaling,
> > >         .get_max_clock          = sdhci_pltfm_clk_get_max_clock,
> > >         .reset                  = sdhci_reset,
> > > +       .adma_write_desc        = dwcmshc_adma_write_desc,
> > >  };
> > >
> > >  static const struct sdhci_pltfm_data sdhci_dwcmshc_pdata = {
> > > @@ -36,12 +67,24 @@ static int dwcmshc_probe(struct platform_device
> *pdev)
> > >         struct sdhci_host *host;
> > >         struct dwcmshc_priv *priv;
> > >         int err;
> > > +       u32 extra;
> > >
> > >         host = sdhci_pltfm_init(pdev, &sdhci_dwcmshc_pdata,
> > >                                 sizeof(struct dwcmshc_priv));
> > >         if (IS_ERR(host))
> > >                 return PTR_ERR(host);
> > >
> > > +       /*
> > > +        * The DMA descriptor table number is calculated as the maximum
> > > +        * number of segments times 2, to allow for an alignment
> > > +        * descriptor for each segment, plus 1 for a nop end
> descriptor,
> > > +        * plus extra number for cross 128M boundary handling.
> > > +        */
> > > +       extra = DIV_ROUND_UP(totalram_pages, SZ_128M / PAGE_SIZE);
> > > +       if (extra > SDHCI_MAX_SEGS)
> > > +               extra = SDHCI_MAX_SEGS;
> > > +       host->adma_table_num = SDHCI_MAX_SEGS * 2 + 1 + extra;
> > > +
> > >         pltfm_host = sdhci_priv(host);
> > >         priv = sdhci_pltfm_priv(pltfm_host);
> > >
> > > --
> > > 2.18.0
> > >
> > >
>
>

--000000000000e2ee1c05722ed231
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">
<span class=3D"gmail-im">&gt;&gt; Hey Jisheng,<br>
<br>&gt;Hi,<br>
<br>
&gt;&gt; <br>
<br>
&gt;In LKML, we&#39;d better not top post.<br>
<span class=3D"gmail-m_8245690094374767092gmail-im"></span><div><br></div><=
/span><div>Noted. My apologies.<br></div><span class=3D"gmail-im"><div><br>=
</div><span class=3D"gmail-m_8245690094374767092gmail-im">
&gt;&gt; Shouldn&#39;t we be splitting until all DMA blocks are less than 1=
28M boundary?<br>
&gt;&gt; I am a noob, but I think we should be prepared for boundaries that=
 when<br>
&gt;&gt; split in two, will still be greater than 128M. Feel free to disagr=
ee but<br>
&gt;&gt; please explain why I may be wrong. Thank-you.<br>
<br>
</span>&gt;the limitation is &quot;DMA addr can&#39;t span 128MB boundary&q=
uot; rather than &quot;must be<br>
&gt;less than 128MB&quot;, they are different.<br>
<br>
&gt;And the max transfer size of one DMA desc is 64KB.<br>
<br><div>
&gt;thanks <br></div><div><br></div></span><div>I have misspoken. What=20
if the DMA transfer size is 1024M? If we split in two, then we have 2=20
transfers, each of which span 512M. So wouldn&#39;t we need to split again=
=20
to have 4 transfers, each of which span 128M?</div><div><br></div><div>Sinc=
erely,<br></div><div>Matthew Leon</div>

<br></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Sun,=
 Jul 29, 2018 at 10:59 PM, Jisheng Zhang <span dir=3D"ltr">&lt;<a href=3D"m=
ailto:Jisheng.Zhang@synaptics.com" target=3D"_blank">Jisheng.Zhang@synaptic=
s.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Mon, 30 Ju=
l 2018 02:56:20 +0000 Matthew Leon &lt;<a href=3D"mailto:matthewleon@linux.=
com">matthewleon@linux.com</a>&gt; wrote:<br>
<br>
&gt; Hey Jisheng,<br>
<br>
Hi,<br>
<br>
&gt; <br>
<br>
In LKML, we&#39;d better not top post.<br>
<span class=3D""><br>
&gt; Shouldn&#39;t we be splitting until all DMA blocks are less than 128M =
boundary?<br>
&gt; I am a noob, but I think we should be prepared for boundaries that whe=
n<br>
&gt; split in two, will still be greater than 128M. Feel free to disagree b=
ut<br>
&gt; please explain why I may be wrong. Thank-you.<br>
<br>
</span>the limitation is &quot;DMA addr can&#39;t span 128MB boundary&quot;=
 rather than &quot;must be<br>
less than 128MB&quot;, they are different.<br>
<br>
And the max transfer size of one DMA desc is 64KB.<br>
<br>
thanks<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt; <br>
&gt; Sincerely,<br>
&gt; Matthew Leon<br>
&gt; <br>
&gt; On Sun, Jul 29, 2018 at 10:46 PM, Jisheng Zhang &lt;<a href=3D"mailto:=
Jisheng.Zhang@synaptics.com">Jisheng.Zhang@synaptics.com</a><br>
&gt; &gt; wrote:=C2=A0 <br>
&gt; <br>
&gt; &gt; When using DMA, if the DMA addr spans 128MB boundary, we have to =
split<br>
&gt; &gt; the DMA transfer into two so that each one doesn&#39;t exceed the=
 boundary.<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Jisheng Zhang &lt;<a href=3D"mailto:Jisheng.Zhang@=
synaptics.com">Jisheng.Zhang@synaptics.com</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 drivers/mmc/host/sdhci-of-<wbr>dwcmshc.c | 43 +++++++++++++=
++++++++++++++++<br>
&gt; &gt;=C2=A0 1 file changed, 43 insertions(+)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/drivers/mmc/host/sdhci-of-<wbr>dwcmshc.c<br>
&gt; &gt; b/drivers/mmc/host/sdhci-of-<wbr>dwcmshc.c<br>
&gt; &gt; index 1b7cd144fb01..e890fc8f5284 100644<br>
&gt; &gt; --- a/drivers/mmc/host/sdhci-of-<wbr>dwcmshc.c<br>
&gt; &gt; +++ b/drivers/mmc/host/sdhci-of-<wbr>dwcmshc.c<br>
&gt; &gt; @@ -8,21 +8,52 @@<br>
&gt; &gt;=C2=A0 =C2=A0*/<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 #include &lt;linux/clk.h&gt;<br>
&gt; &gt; +#include &lt;linux/mm.h&gt;<br>
&gt; &gt;=C2=A0 #include &lt;linux/module.h&gt;<br>
&gt; &gt;=C2=A0 #include &lt;linux/of.h&gt;<br>
&gt; &gt; +#include &lt;linux/sizes.h&gt;<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 #include &quot;sdhci-pltfm.h&quot;<br>
&gt; &gt;<br>
&gt; &gt; +#define BOUNDARY_OK(addr, len) \<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0((addr | (SZ_128M - 1)) =3D=3D ((addr=
 + len - 1) | (SZ_128M - 1)))<br>
&gt; &gt; +<br>
&gt; &gt;=C2=A0 struct dwcmshc_priv {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct clk=C2=A0 =C2=A0 =C2=A0 *=
bus_clk;<br>
&gt; &gt;=C2=A0 };<br>
&gt; &gt;<br>
&gt; &gt; +/*<br>
&gt; &gt; + * if DMA addr spans 128MB boundary, we split the DMA transfer i=
nto two<br>
&gt; &gt; + * so that the DMA transfer doesn&#39;t exceed the boundary.<br>
&gt; &gt; + */<br>
&gt; &gt; +static unsigned int dwcmshc_adma_write_desc(struct sdhci_host *h=
ost,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0void *desc, dma_addr_t addr,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0int len, unsigned int cmd)<br>
&gt; &gt; +{<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0int tmplen, offset;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (likely(!len || BOUNDARY_OK(addr, =
len)))<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return _s=
dhci_adma_write_desc(host, desc, addr, len, cmd);<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0offset =3D addr &amp; (SZ_128M - 1);<=
br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0tmplen =3D SZ_128M - offset;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0_sdhci_adma_write_desc(host, desc, ad=
dr, tmplen, cmd);<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0addr +=3D tmplen;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0len -=3D tmplen;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0desc +=3D host-&gt;desc_sz;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0_sdhci_adma_write_desc(host, desc, ad=
dr, len, cmd);<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0return host-&gt;desc_sz * 2;<br>
&gt; &gt; +}<br>
&gt; &gt; +<br>
&gt; &gt;=C2=A0 static const struct sdhci_ops sdhci_dwcmshc_ops =3D {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.set_clock=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D sdhci_set_clock,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.set_bus_width=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =3D sdhci_set_bus_width,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.set_uhs_signaling=C2=A0 =C2=A0 =
=C2=A0 =3D sdhci_set_uhs_signaling,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.get_max_clock=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =3D sdhci_pltfm_clk_get_max_clock,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.reset=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D sdhci_reset,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0.adma_write_desc=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =3D dwcmshc_adma_write_desc,<br>
&gt; &gt;=C2=A0 };<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 static const struct sdhci_pltfm_data sdhci_dwcmshc_pdata =
=3D {<br>
&gt; &gt; @@ -36,12 +67,24 @@ static int dwcmshc_probe(struct platform_devi=
ce *pdev)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct sdhci_host *host;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct dwcmshc_priv *priv;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int err;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 extra;<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0host =3D sdhci_pltfm_init(pdev, =
&amp;sdhci_dwcmshc_pdata,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeof(struct dwcmshc_p=
riv));<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (IS_ERR(host))<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retu=
rn PTR_ERR(host);<br>
&gt; &gt;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * The DMA descriptor table number is=
 calculated as the maximum<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * number of segments times 2, to all=
ow for an alignment<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * descriptor for each segment, plus =
1 for a nop end descriptor,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * plus extra number for cross 128M b=
oundary handling.<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0extra =3D DIV_ROUND_UP(totalram_pages=
, SZ_128M / PAGE_SIZE);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (extra &gt; SDHCI_MAX_SEGS)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0extra =3D=
 SDHCI_MAX_SEGS;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0host-&gt;adma_table_num =3D SDHCI_MAX=
_SEGS * 2 + 1 + extra;<br>
&gt; &gt; +<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pltfm_host =3D sdhci_priv(host);=
<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0priv =3D sdhci_pltfm_priv(pltfm_=
host);<br>
&gt; &gt;<br>
&gt; &gt; --<br>
&gt; &gt; 2.18.0<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 <br>
<br>
</div></div></blockquote></div><br></div>

--000000000000e2ee1c05722ed231--
