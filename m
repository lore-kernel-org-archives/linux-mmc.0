From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [PATCH 1/1]sdhci-pxa: support tune_timming for various cards
Date: Tue, 9 Nov 2010 22:33:29 +0800
Message-ID: <AANLkTimWJRycUpg2PcW6apUKfEO7675rB4kC9Nv7N-4C@mail.gmail.com>
References: <AANLkTinyu5j0KpZ5AWuE0yOvAaFNBkM+bSfiLqpNcS+_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:40637 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751320Ab0KIOdv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Nov 2010 09:33:51 -0500
Received: by iwn10 with SMTP id 10so1335081iwn.19
        for <linux-mmc@vger.kernel.org>; Tue, 09 Nov 2010 06:33:51 -0800 (PST)
In-Reply-To: <AANLkTinyu5j0KpZ5AWuE0yOvAaFNBkM+bSfiLqpNcS+_@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Haojian Zhuang <haojian.zhuang@gmail.com>

On Tue, Nov 9, 2010 at 10:17 PM, zhangfei gao <zhangfei.gao@gmail.com> =
wrote:
> Haojian,
>
> Would you help review, since arch/arm/plat-pxa/include/plat/sdhci.h i=
s
> updated, thanks
>
> From 6619812b749aa12ebf0efbe057366c2f99051bfe Mon Sep 17 00:00:00 200=
1
> From: Zhangfei Gao <zhangfei.gao@marvell.com>
> Date: Tue, 2 Nov 2010 07:37:44 -0400
> Subject: [PATCH] sdhci-pxa: support tune_timming for various cards
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A01. Add pdata check, in case pdata is NULL
> =C2=A0 =C2=A0 =C2=A0 =C2=A02. Add tune_timming to adjust read data/co=
mmand timming without
> performance impact when crc error, as a result
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0a, sd could wo=
rk at 50M
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0b, emmc could =
work at ddr50 mode
> =C2=A0 =C2=A0 =C2=A0 =C2=A03. Remove clock_enable checking, since clo=
ck gating is still on-going
> in core stack.
>
> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
> ---
> =C2=A0arch/arm/plat-pxa/include/plat/sdhci.h | =C2=A0 =C2=A02 +
> =C2=A0drivers/mmc/host/sdhci-pxa.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 | =C2=A0 51 +++++++++++++++++++++++--------
> =C2=A02 files changed, 40 insertions(+), 13 deletions(-)
>
> diff --git a/arch/arm/plat-pxa/include/plat/sdhci.h
> b/arch/arm/plat-pxa/include/plat/sdhci.h
> index fc5ceab..8c340b1 100644
> --- a/arch/arm/plat-pxa/include/plat/sdhci.h
> +++ b/arch/arm/plat-pxa/include/plat/sdhci.h
> @@ -24,11 +24,13 @@
> =C2=A0* @max_speed: the maximum speed supported
> =C2=A0* @quirks: quirks of specific device
> =C2=A0* @flags: flags for platform requirement
> + * @clk_delay: clk_delay vlaue to tunning various cards
> =C2=A0*/
> =C2=A0struct sdhci_pxa_platdata {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int =C2=A0 =C2=A0max_speed;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int =C2=A0 =C2=A0quirks;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int =C2=A0 =C2=A0flags;
> + =C2=A0 =C2=A0 =C2=A0 unsigned int =C2=A0 =C2=A0clk_delay;
> =C2=A0};
>
> =C2=A0#endif /* __PLAT_PXA_SDHCI_H */
> diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-px=
a.c
> index 8455c46..cf514f8 100644
> --- a/drivers/mmc/host/sdhci-pxa.c
> +++ b/drivers/mmc/host/sdhci-pxa.c
> @@ -32,6 +32,11 @@
> =C2=A0#define SD_FIFO_PARAM =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x104
> =C2=A0#define DIS_PAD_SD_CLK_GATE =C2=A0 =C2=A00x400
>
> +#define SD_CLOCK_AND_BURST_SIZE_SETUP =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A00x10A
> +#define SDCLK_SEL =C2=A0 =C2=A0 =C2=A00x100
> +#define SDCLK_DELAY_SHIFT =C2=A0 =C2=A0 =C2=A09
> +#define SDCLK_DELAY_MASK =C2=A0 =C2=A0 =C2=A0 0x1f
> +
> =C2=A0struct sdhci_pxa {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct sdhci_host =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 *host;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct sdhci_pxa_platdata =C2=A0 =C2=A0 =C2=
=A0 *pdata;
> @@ -46,6 +51,26 @@ struct sdhci_pxa {
> =C2=A0* SDHCI core callbacks =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0*
> =C2=A0* =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *
> =C2=A0\**************************************************************=
***************/
> +static void tune_timming(struct sdhci_host *host)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct sdhci_pxa *pxa =3D sdhci_priv(host);
> +
> + =C2=A0 =C2=A0 =C2=A0 /*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* tune timming of read data/command when=
 crc error happen
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* No perfermance impact
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 if (pxa->pdata && 0 !=3D pxa->pdata->clk_delay=
) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u16 tmp;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tmp =3D readw(host=
->ioaddr + SD_CLOCK_AND_BURST_SIZE_SETUP);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tmp |=3D (pxa->pda=
ta->clk_delay & SDCLK_DELAY_MASK)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 << SDCL=
K_DELAY_SHIFT;

delay of cycles or nanoseconds or microseconds? I think it would be mor=
e
readable to have something like:

=2Eclk_delay_cycles or .clk_delay_ns or .clk_delay_ms and do a bit
translation here,
or you may want to add some comments to the unit of this delay.

And is this necessary to adjust the timing every time a set_clock is do=
ne? This
looks like a non-set-clock related action. Wondering whether it's
feasible to put
this in initialization.

> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tmp |=3D SDCLK_SEL=
;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 writew(tmp, host->=
ioaddr + SD_CLOCK_AND_BURST_SIZE_SETUP);
> + =C2=A0 =C2=A0 =C2=A0 }
> +

unnecessary new line here

> +}
> +
> =C2=A0static void set_clock(struct sdhci_host *host, unsigned int clo=
ck)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct sdhci_pxa *pxa =3D sdhci_priv(host)=
;
> @@ -57,15 +82,16 @@ static void set_clock(struct sdhci_host *host,
> unsigned int clock)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0pxa->clk_enable =3D 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (0 =3D=3D pxa->=
clk_enable) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if (pxa->pdata->flags & PXA_FLAG_DISABLE_CLOCK_GATING) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tmp =3D readl(host->ioaddr + SD_FIF=
O_PARAM);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tmp |=3D DIS_PAD_SD_CLK_GATE;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 writel(tmp, host->ioaddr + SD_FIFO_=
PARAM);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 }
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 clk_enable(pxa->clk);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 pxa->clk_enable =3D 1;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tune_timming(host)=
;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (pxa->pdata &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 pxa->pdata->flags & PXA_FLAG_DISABLE_CLOCK_GATING) {

I guess instead of having this if () statement everywhere, you may
want to encode
the information from pdata to 'struct sdhci_pxa' instead. And you also =
need to
consider the case if pxa->pdata =3D=3D NULL is allowed, and if it's all=
owed, what
is the default action.

> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 tmp =3D readl(host->ioaddr + SD_FIFO_PARAM);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 tmp |=3D DIS_PAD_SD_CLK_GATE;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 writel(tmp, host->ioaddr + SD_FIFO_PARAM);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 clk_enable(pxa->cl=
k);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pxa->clk_enable =3D=
 1;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0}
>
> @@ -138,13 +164,13 @@ static int __devinit sdhci_pxa_probe(struct
> platform_device *pdev)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0host->irq =3D irq;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0host->quirks =3D SDHCI_QUIRK_BROKEN_ADMA |=
 SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
>
> - =C2=A0 =C2=A0 =C2=A0 if (pxa->pdata->flags & PXA_FLAG_CARD_PERMANEN=
T) {
> + =C2=A0 =C2=A0 =C2=A0 if (pdata && pdata->flags & PXA_FLAG_CARD_PERM=
ANENT) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* on-chip dev=
ice */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0host->quirks |=
=3D SDHCI_QUIRK_BROKEN_CARD_DETECTION;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0host->mmc->cap=
s |=3D MMC_CAP_NONREMOVABLE;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> - =C2=A0 =C2=A0 =C2=A0 if (pdata->quirks)
> + =C2=A0 =C2=A0 =C2=A0 if (pdata && pdata->quirks)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0host->quirks |=
=3D pdata->quirks;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D sdhci_add_host(host);
> @@ -153,9 +179,8 @@ static int __devinit sdhci_pxa_probe(struct
> platform_device *pdev)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> - =C2=A0 =C2=A0 =C2=A0 if (pxa->pdata->max_speed)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host->mmc->f_max =3D=
 pxa->pdata->max_speed;
> -
> + =C2=A0 =C2=A0 =C2=A0 if (pdata && pdata->max_speed)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host->mmc->f_max =3D=
 pdata->max_speed;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0platform_set_drvdata(pdev, host);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> --
> 1.7.0.4
>
