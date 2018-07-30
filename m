From: Matthew Leon <matthewleon@linux.com>
Subject: Re: [PATCH mmc-next v3 3/3] mmc: sdhci-of-dwcmshc: solve 128MB DMA
 boundary limitation
Date: Mon, 30 Jul 2018 02:56:20 +0000
Message-ID: <01010164e91d7bda-aa616cbf-7bb2-4fe4-85e5-a18e16433fde-000000@us-west-2.amazonses.com>
References: <20180730104228.28b58bd0@xhacker.debian> <20180730104636.1a3e6c81@xhacker.debian>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary="00000000000001ea2605722e9bb0"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180730104636.1a3e6c81@xhacker.debian>
Sender: linux-kernel-owner@vger.kernel.org
To: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

--00000000000001ea2605722e9bb0
Content-Type: text/plain; charset="UTF-8"

Hey Jisheng,

Shouldn't we be splitting until all DMA blocks are less than 128M boundary?
I am a noob, but I think we should be prepared for boundaries that when
split in two, will still be greater than 128M. Feel free to disagree but
please explain why I may be wrong. Thank-you.

Sincerely,
Matthew Leon

On Sun, Jul 29, 2018 at 10:46 PM, Jisheng Zhang <Jisheng.Zhang@synaptics.com
> wrote:

> When using DMA, if the DMA addr spans 128MB boundary, we have to split
> the DMA transfer into two so that each one doesn't exceed the boundary.
>
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 43 +++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c
> b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 1b7cd144fb01..e890fc8f5284 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -8,21 +8,52 @@
>   */
>
>  #include <linux/clk.h>
> +#include <linux/mm.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/sizes.h>
>
>  #include "sdhci-pltfm.h"
>
> +#define BOUNDARY_OK(addr, len) \
> +       ((addr | (SZ_128M - 1)) == ((addr + len - 1) | (SZ_128M - 1)))
> +
>  struct dwcmshc_priv {
>         struct clk      *bus_clk;
>  };
>
> +/*
> + * if DMA addr spans 128MB boundary, we split the DMA transfer into two
> + * so that the DMA transfer doesn't exceed the boundary.
> + */
> +static unsigned int dwcmshc_adma_write_desc(struct sdhci_host *host,
> +                                           void *desc, dma_addr_t addr,
> +                                           int len, unsigned int cmd)
> +{
> +       int tmplen, offset;
> +
> +       if (likely(!len || BOUNDARY_OK(addr, len)))
> +               return _sdhci_adma_write_desc(host, desc, addr, len, cmd);
> +
> +       offset = addr & (SZ_128M - 1);
> +       tmplen = SZ_128M - offset;
> +       _sdhci_adma_write_desc(host, desc, addr, tmplen, cmd);
> +
> +       addr += tmplen;
> +       len -= tmplen;
> +       desc += host->desc_sz;
> +       _sdhci_adma_write_desc(host, desc, addr, len, cmd);
> +
> +       return host->desc_sz * 2;
> +}
> +
>  static const struct sdhci_ops sdhci_dwcmshc_ops = {
>         .set_clock              = sdhci_set_clock,
>         .set_bus_width          = sdhci_set_bus_width,
>         .set_uhs_signaling      = sdhci_set_uhs_signaling,
>         .get_max_clock          = sdhci_pltfm_clk_get_max_clock,
>         .reset                  = sdhci_reset,
> +       .adma_write_desc        = dwcmshc_adma_write_desc,
>  };
>
>  static const struct sdhci_pltfm_data sdhci_dwcmshc_pdata = {
> @@ -36,12 +67,24 @@ static int dwcmshc_probe(struct platform_device *pdev)
>         struct sdhci_host *host;
>         struct dwcmshc_priv *priv;
>         int err;
> +       u32 extra;
>
>         host = sdhci_pltfm_init(pdev, &sdhci_dwcmshc_pdata,
>                                 sizeof(struct dwcmshc_priv));
>         if (IS_ERR(host))
>                 return PTR_ERR(host);
>
> +       /*
> +        * The DMA descriptor table number is calculated as the maximum
> +        * number of segments times 2, to allow for an alignment
> +        * descriptor for each segment, plus 1 for a nop end descriptor,
> +        * plus extra number for cross 128M boundary handling.
> +        */
> +       extra = DIV_ROUND_UP(totalram_pages, SZ_128M / PAGE_SIZE);
> +       if (extra > SDHCI_MAX_SEGS)
> +               extra = SDHCI_MAX_SEGS;
> +       host->adma_table_num = SDHCI_MAX_SEGS * 2 + 1 + extra;
> +
>         pltfm_host = sdhci_priv(host);
>         priv = sdhci_pltfm_priv(pltfm_host);
>
> --
> 2.18.0
>
>

--00000000000001ea2605722e9bb0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hey Jisheng,</div><div><br></div><div>Shouldn&#39;t w=
e be splitting until all DMA blocks are less than 128M boundary? I am a noo=
b, but I think we should be prepared for boundaries that when split in two,=
 will still be greater than 128M. Feel free to disagree but please explain =
why I may be wrong. Thank-you.<br></div><div><br></div><div>Sincerely,</div=
><div>Matthew Leon<br></div></div><div class=3D"gmail_extra"><br><div class=
=3D"gmail_quote">On Sun, Jul 29, 2018 at 10:46 PM, Jisheng Zhang <span dir=
=3D"ltr">&lt;<a href=3D"mailto:Jisheng.Zhang@synaptics.com" target=3D"_blan=
k">Jisheng.Zhang@synaptics.com</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">When using DMA, if the DMA addr spans 128MB boundary, we have=
 to split<br>
the DMA transfer into two so that each one doesn&#39;t exceed the boundary.=
<br>
<br>
Signed-off-by: Jisheng Zhang &lt;<a href=3D"mailto:Jisheng.Zhang@synaptics.=
com">Jisheng.Zhang@synaptics.com</a>&gt;<br>
---<br>
=C2=A0drivers/mmc/host/sdhci-of-<wbr>dwcmshc.c | 43 +++++++++++++++++++++++=
++++++<br>
=C2=A01 file changed, 43 insertions(+)<br>
<br>
diff --git a/drivers/mmc/host/sdhci-of-<wbr>dwcmshc.c b/drivers/mmc/host/sd=
hci-of-<wbr>dwcmshc.c<br>
index 1b7cd144fb01..e890fc8f5284 100644<br>
--- a/drivers/mmc/host/sdhci-of-<wbr>dwcmshc.c<br>
+++ b/drivers/mmc/host/sdhci-of-<wbr>dwcmshc.c<br>
@@ -8,21 +8,52 @@<br>
=C2=A0 */<br>
<br>
=C2=A0#include &lt;linux/clk.h&gt;<br>
+#include &lt;linux/mm.h&gt;<br>
=C2=A0#include &lt;linux/module.h&gt;<br>
=C2=A0#include &lt;linux/of.h&gt;<br>
+#include &lt;linux/sizes.h&gt;<br>
<br>
=C2=A0#include &quot;sdhci-pltfm.h&quot;<br>
<br>
+#define BOUNDARY_OK(addr, len) \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0((addr | (SZ_128M - 1)) =3D=3D ((addr + len - 1=
) | (SZ_128M - 1)))<br>
+<br>
=C2=A0struct dwcmshc_priv {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct clk=C2=A0 =C2=A0 =C2=A0 *bus_clk;<br>
=C2=A0};<br>
<br>
+/*<br>
+ * if DMA addr spans 128MB boundary, we split the DMA transfer into two<br=
>
+ * so that the DMA transfer doesn&#39;t exceed the boundary.<br>
+ */<br>
+static unsigned int dwcmshc_adma_write_desc(struct sdhci_host *host,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0void *desc, dma_addr_t addr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0int len, unsigned int cmd)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int tmplen, offset;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (likely(!len || BOUNDARY_OK(addr, len)))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return _sdhci_adma_=
write_desc(host, desc, addr, len, cmd);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0offset =3D addr &amp; (SZ_128M - 1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tmplen =3D SZ_128M - offset;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0_sdhci_adma_write_desc(host, desc, addr, tmplen=
, cmd);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0addr +=3D tmplen;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0len -=3D tmplen;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0desc +=3D host-&gt;desc_sz;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0_sdhci_adma_write_desc(host, desc, addr, len, c=
md);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return host-&gt;desc_sz * 2;<br>
+}<br>
+<br>
=C2=A0static const struct sdhci_ops sdhci_dwcmshc_ops =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .set_clock=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =3D sdhci_set_clock,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .set_bus_width=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =3D sdhci_set_bus_width,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .set_uhs_signaling=C2=A0 =C2=A0 =C2=A0 =3D sdhc=
i_set_uhs_signaling,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .get_max_clock=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =3D sdhci_pltfm_clk_get_max_clock,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .reset=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =3D sdhci_reset,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.adma_write_desc=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D=
 dwcmshc_adma_write_desc,<br>
=C2=A0};<br>
<br>
=C2=A0static const struct sdhci_pltfm_data sdhci_dwcmshc_pdata =3D {<br>
@@ -36,12 +67,24 @@ static int dwcmshc_probe(struct platform_device *pdev)<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct sdhci_host *host;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct dwcmshc_priv *priv;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int err;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 extra;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 host =3D sdhci_pltfm_init(pdev, &amp;sdhci_dwcm=
shc_pdata,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(struct dwcmshc_priv));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (IS_ERR(host))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return PTR_ERR(host=
);<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * The DMA descriptor table number is calculate=
d as the maximum<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * number of segments times 2, to allow for an =
alignment<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * descriptor for each segment, plus 1 for a no=
p end descriptor,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * plus extra number for cross 128M boundary ha=
ndling.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0extra =3D DIV_ROUND_UP(totalram_pages, SZ_128M =
/ PAGE_SIZE);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (extra &gt; SDHCI_MAX_SEGS)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0extra =3D SDHCI_MAX=
_SEGS;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0host-&gt;adma_table_num =3D SDHCI_MAX_SEGS * 2 =
+ 1 + extra;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pltfm_host =3D sdhci_priv(host);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 priv =3D sdhci_pltfm_priv(pltfm_host);<br>
<span class=3D"HOEnZb"><font color=3D"#888888">=C2=A0<br>
-- <br>
2.18.0<br>
<br>
</font></span></blockquote></div><br></div>

--00000000000001ea2605722e9bb0--
