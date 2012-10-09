From: =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marek.vasut@gmail.com>
Subject: Re: [PATCH] mmc: mxs: fix build regression from mismerge
Date: Tue, 9 Oct 2012 17:42:14 +0200
Message-ID: <CAMqi2ZPvgu8M4F_fW01v5N6USn8=QP9brdMAEL34v_y69t8pbQ@mail.gmail.com>
References: <201210091537.23659.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2659645958222121645=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <201210091537.23659.arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Marek Vasut <marex@denx.de>, Shawn Guo <shawn.guo@linaro.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-mmc@vger.kernel.org, Attila Kinali <attila@kinali.ch>, Lauri Hintsala <lauri.hintsala@bluegiga.com>, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

--===============2659645958222121645==
Content-Type: multipart/alternative; boundary=20cf307cfd4aad24de04cba22e82

--20cf307cfd4aad24de04cba22e82
Content-Type: text/plain; charset=UTF-8

I sent a patch for that already, Chris was cced on it recently by Shawn
too. (Sorry for top posting, Android mail client)
Dne 9.10.2012 17:39 "Arnd Bergmann" <arnd@arndb.de> napsal(a):

> From all I can tell, the patches
>
> fc108d24 "mmc: mxs-mmc: fix deadlock caused by recursion loop"
> 829c1bf4 "mmc: spi: Pull out parts shared between MMC and SPI"
>
> came in through separate branches and cause this build error when
> combined.
>
> drivers/mmc/host/mxs-mmc.c: In function 'mxs_mmc_enable_sdio_irq':
> drivers/mmc/host/mxs-mmc.c:527:78: error: 'struct mxs_mmc_host' has no
> member named 'base'
> drivers/mmc/host/mxs-mmc.c:527:95: error: 'struct mxs_mmc_host' has no
> member named 'devid'
>
> This does the obvious missing change.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Attila Kinali <attila@kinali.ch>
> Cc: Lauri Hintsala <lauri.hintsala@bluegiga.com>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Chris Ball <cjb@laptop.org>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
>
> diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
> index bb4c2bf..80d1e6d 100644
> --- a/drivers/mmc/host/mxs-mmc.c
> +++ b/drivers/mmc/host/mxs-mmc.c
> @@ -525,7 +525,7 @@ static void mxs_mmc_enable_sdio_irq(struct mmc_host
> *mmc, int enable)
>                 writel(BM_SSP_CTRL0_SDIO_IRQ_CHECK,
>                        ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_SET);
>                 writel(BM_SSP_CTRL1_SDIO_IRQ_EN,
> -                      host->base + HW_SSP_CTRL1(host) +
> STMP_OFFSET_REG_SET);
> +                      ssp->base + HW_SSP_CTRL1(ssp) +
> STMP_OFFSET_REG_SET);
>         } else {
>                 writel(BM_SSP_CTRL0_SDIO_IRQ_CHECK,
>                        ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_CLR);
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>

--20cf307cfd4aad24de04cba22e82
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">I sent a patch for that already, Chris was cced on it recent=
ly by Shawn too. (Sorry for top posting, Android mail client)</p>
<div class=3D"gmail_quote">Dne 9.10.2012 17:39 &quot;Arnd Bergmann&quot; &l=
t;<a href=3D"mailto:arnd@arndb.de">arnd@arndb.de</a>&gt; napsal(a):<br type=
=3D"attribution"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">
>From all I can tell, the patches<br>
<br>
fc108d24 &quot;mmc: mxs-mmc: fix deadlock caused by recursion loop&quot;<br=
>
829c1bf4 &quot;mmc: spi: Pull out parts shared between MMC and SPI&quot;<br=
>
<br>
came in through separate branches and cause this build error when<br>
combined.<br>
<br>
drivers/mmc/host/mxs-mmc.c: In function &#39;mxs_mmc_enable_sdio_irq&#39;:<=
br>
drivers/mmc/host/mxs-mmc.c:527:78: error: &#39;struct mxs_mmc_host&#39; has=
 no member named &#39;base&#39;<br>
drivers/mmc/host/mxs-mmc.c:527:95: error: &#39;struct mxs_mmc_host&#39; has=
 no member named &#39;devid&#39;<br>
<br>
This does the obvious missing change.<br>
<br>
Signed-off-by: Arnd Bergmann &lt;<a href=3D"mailto:arnd@arndb.de">arnd@arnd=
b.de</a>&gt;<br>
Cc: Attila Kinali &lt;<a href=3D"mailto:attila@kinali.ch">attila@kinali.ch<=
/a>&gt;<br>
Cc: Lauri Hintsala &lt;<a href=3D"mailto:lauri.hintsala@bluegiga.com">lauri=
.hintsala@bluegiga.com</a>&gt;<br>
Cc: Marek Vasut &lt;<a href=3D"mailto:marex@denx.de">marex@denx.de</a>&gt;<=
br>
Cc: Chris Ball &lt;<a href=3D"mailto:cjb@laptop.org">cjb@laptop.org</a>&gt;=
<br>
Cc: Shawn Guo &lt;<a href=3D"mailto:shawn.guo@linaro.org">shawn.guo@linaro.=
org</a>&gt;<br>
Cc: Mark Brown &lt;<a href=3D"mailto:broonie@opensource.wolfsonmicro.com">b=
roonie@opensource.wolfsonmicro.com</a>&gt;<br>
<br>
diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c<br>
index bb4c2bf..80d1e6d 100644<br>
--- a/drivers/mmc/host/mxs-mmc.c<br>
+++ b/drivers/mmc/host/mxs-mmc.c<br>
@@ -525,7 +525,7 @@ static void mxs_mmc_enable_sdio_irq(struct mmc_host *mm=
c, int enable)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 writel(BM_SSP_CTRL0=
_SDIO_IRQ_CHECK,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ssp-&gt;base + HW_SSP_CTRL0 + STMP_OFFSET_REG_SET);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 writel(BM_SSP_CTRL1=
_SDIO_IRQ_EN,<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0host-&gt;base + HW_SSP_CTRL1(host) + STMP_OFFSET_REG_SET);<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0ssp-&gt;base + HW_SSP_CTRL1(ssp) + STMP_OFFSET_REG_SET);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 writel(BM_SSP_CTRL0=
_SDIO_IRQ_CHECK,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ssp-&gt;base + HW_SSP_CTRL0 + STMP_OFFSET_REG_CLR);<br>
<br>
_______________________________________________<br>
linux-arm-kernel mailing list<br>
<a href=3D"mailto:linux-arm-kernel@lists.infradead.org">linux-arm-kernel@li=
sts.infradead.org</a><br>
<a href=3D"http://lists.infradead.org/mailman/listinfo/linux-arm-kernel" ta=
rget=3D"_blank">http://lists.infradead.org/mailman/listinfo/linux-arm-kerne=
l</a><br>
</blockquote></div>

--20cf307cfd4aad24de04cba22e82--


--===============2659645958222121645==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2659645958222121645==--
