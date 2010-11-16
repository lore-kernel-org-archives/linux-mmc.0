From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: Re: [PATCH v2 1/1]sdhci-pxa: support tune_timming for various cards
Date: Tue, 16 Nov 2010 13:52:41 +0800
Message-ID: <AANLkTikLmKbtCO2A9t=Ayr-uAQyC0W9Xb2DNiSYvBQ2v@mail.gmail.com>
References: <AANLkTi=h1p98z542H=EzFaqnHmEDkQDPZ5QmCQGo4Cik@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:56988 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753940Ab0KPFwn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Nov 2010 00:52:43 -0500
Received: by wwa36 with SMTP id 36so359203wwa.1
        for <linux-mmc@vger.kernel.org>; Mon, 15 Nov 2010 21:52:41 -0800 (PST)
In-Reply-To: <AANLkTi=h1p98z542H=EzFaqnHmEDkQDPZ5QmCQGo4Cik@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Eric Miao <eric.y.miao@gmail.com>

On Thu, Nov 11, 2010 at 9:19 PM, zhangfei gao <zhangfei.gao@gmail.com> =
wrote:
> Hi, Chirs & Eric
>
> Thanks for review, here is updated version.
> 1. After clk_gating is enabled, set_clock will transfer clock=3D0, so
> clk_disable will be called, currently set_clock will never transfer
> clock=3D0.
> Later tune_timing only occurs once clock is started, currently it wil=
l
> happen when clock is changed.
>
> 2. if pdata is NULL, on-chip device can not be detected, but SD card
> is workable, though some card may have crc error at 50M.
>
>
> From 553b84abee56f36ee166564f7ce3c617950e194f Mon Sep 17 00:00:00 200=
1
> From: Zhangfei Gao <zhangfei.gao@marvell.com>
> Date: Tue, 2 Nov 2010 07:37:44 -0400
> Subject: [PATCH] sdhci-pxa: support tune_timing for various cards
>
> =A0 =A0 =A0 =A01. Add pdata check, in case pdata is NULL
> =A0 =A0 =A0 =A02. Add tune_timing to adjust read data/command timing =
without
> performance impact when crc error, as a result
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0a, sd could work at 50M
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0b, emmc could work at ddr50 mode
> =A0 =A0 =A0 =A03. Remove clock_enable checking, since clock gating is=
 still on-going
> in core stack.
>
> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
> ---
> =A0arch/arm/plat-pxa/include/plat/sdhci.h | =A0 =A02 +
> =A0drivers/mmc/host/sdhci-pxa.c =A0 =A0 =A0 =A0 =A0 | =A0 47 ++++++++=
+++++++++++++++--------
> =A02 files changed, 37 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm/plat-pxa/include/plat/sdhci.h
> b/arch/arm/plat-pxa/include/plat/sdhci.h
> index fc5ceab..f6f46db 100644
> --- a/arch/arm/plat-pxa/include/plat/sdhci.h
> +++ b/arch/arm/plat-pxa/include/plat/sdhci.h
> @@ -24,11 +24,13 @@
> =A0* @max_speed: the maximum speed supported
> =A0* @quirks: quirks of specific device
> =A0* @flags: flags for platform requirement
> + * @clk_delay_cycles: 1 ~ 0x1f, each step is roughly 100ps, for tuni=
ng timing
> =A0*/
> =A0struct sdhci_pxa_platdata {
> =A0 =A0 =A0 =A0unsigned int =A0 =A0max_speed;
> =A0 =A0 =A0 =A0unsigned int =A0 =A0quirks;
> =A0 =A0 =A0 =A0unsigned int =A0 =A0flags;
> + =A0 =A0 =A0 unsigned int =A0 =A0clk_delay_cycles;
> =A0};
>
> =A0#endif /* __PLAT_PXA_SDHCI_H */
> diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-px=
a.c
> index 8455c46..2b665e4 100644
> --- a/drivers/mmc/host/sdhci-pxa.c
> +++ b/drivers/mmc/host/sdhci-pxa.c
> @@ -32,6 +32,11 @@
> =A0#define SD_FIFO_PARAM =A0 =A0 =A0 =A0 =A00x104
> =A0#define DIS_PAD_SD_CLK_GATE =A0 =A00x400
>
> +#define SD_CLOCK_AND_BURST_SIZE_SETUP =A0 =A0 =A0 =A0 =A00x10A
> +#define SDCLK_SEL =A0 =A0 =A00x100
> +#define SDCLK_DELAY_SHIFT =A0 =A0 =A09
> +#define SDCLK_DELAY_MASK =A0 =A0 =A0 0x1f
> +
> =A0struct sdhci_pxa {
> =A0 =A0 =A0 =A0struct sdhci_host =A0 =A0 =A0 =A0 =A0 =A0 =A0 *host;
> =A0 =A0 =A0 =A0struct sdhci_pxa_platdata =A0 =A0 =A0 *pdata;
> @@ -46,9 +51,28 @@ struct sdhci_pxa {
> =A0* SDHCI core callbacks =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*
> =A0* =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 *
> =A0\*****************************************************************=
************/
> +static inline void tune_timing(struct sdhci_host *host,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct =
sdhci_pxa_platdata *pdata)
> +{
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* tune timing of read data/command when crc error ha=
ppen
> + =A0 =A0 =A0 =A0* no performance impact
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (pdata && 0 !=3D pdata->clk_delay_cycles) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u16 tmp;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp =3D readw(host->ioaddr + SD_CLOCK_A=
ND_BURST_SIZE_SETUP);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp |=3D (pdata->clk_delay_cycles & SDC=
LK_DELAY_MASK)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 << SDCLK_DELAY_SHIFT;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp |=3D SDCLK_SEL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 writew(tmp, host->ioaddr + SD_CLOCK_AND=
_BURST_SIZE_SETUP);
> + =A0 =A0 =A0 }
> +}
> +
> =A0static void set_clock(struct sdhci_host *host, unsigned int clock)
> =A0{
> =A0 =A0 =A0 =A0struct sdhci_pxa *pxa =3D sdhci_priv(host);
> + =A0 =A0 =A0 struct sdhci_pxa_platdata *pdata =3D pxa->pdata;
> =A0 =A0 =A0 =A0u32 tmp =3D 0;
>
> =A0 =A0 =A0 =A0if (clock =3D=3D 0) {
> @@ -57,15 +81,14 @@ static void set_clock(struct sdhci_host *host,
> unsigned int clock)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pxa->clk_enable =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0} else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (0 =3D=3D pxa->clk_enable) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pxa->pdata->flags &=
 PXA_FLAG_DISABLE_CLOCK_GATING) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp =3D=
 readl(host->ioaddr + SD_FIFO_PARAM);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp |=3D=
 DIS_PAD_SD_CLK_GATE;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 writel(=
tmp, host->ioaddr + SD_FIFO_PARAM);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_enable(pxa->clk);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pxa->clk_enable =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tune_timing(host, pdata);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pdata && pdata->flags & PXA_FLAG_DI=
SABLE_CLOCK_GATING) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp =3D readl(host->ioa=
ddr + SD_FIFO_PARAM);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp |=3D DIS_PAD_SD_CLK=
_GATE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 writel(tmp, host->ioadd=
r + SD_FIFO_PARAM);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_enable(pxa->clk);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pxa->clk_enable =3D 1;
> =A0 =A0 =A0 =A0}
> =A0}
>
> @@ -138,13 +161,13 @@ static int __devinit sdhci_pxa_probe(struct
> platform_device *pdev)
> =A0 =A0 =A0 =A0host->irq =3D irq;
> =A0 =A0 =A0 =A0host->quirks =3D SDHCI_QUIRK_BROKEN_ADMA | SDHCI_QUIRK=
_BROKEN_TIMEOUT_VAL;
>
> - =A0 =A0 =A0 if (pxa->pdata->flags & PXA_FLAG_CARD_PERMANENT) {
> + =A0 =A0 =A0 if (pdata && pdata->flags & PXA_FLAG_CARD_PERMANENT) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* on-chip device */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->quirks |=3D SDHCI_QUIRK_BROKEN_C=
ARD_DETECTION;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->mmc->caps |=3D MMC_CAP_NONREMOVA=
BLE;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 if (pdata->quirks)
> + =A0 =A0 =A0 if (pdata && pdata->quirks)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->quirks |=3D pdata->quirks;
>
> =A0 =A0 =A0 =A0ret =3D sdhci_add_host(host);
> @@ -153,8 +176,8 @@ static int __devinit sdhci_pxa_probe(struct
> platform_device *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 if (pxa->pdata->max_speed)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->mmc->f_max =3D pxa->pdata->max_sp=
eed;
> + =A0 =A0 =A0 if (pdata && pdata->max_speed)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->mmc->f_max =3D pdata->max_speed;
>
> =A0 =A0 =A0 =A0platform_set_drvdata(pdev, host);
>
> --
> 1.7.0.4
>

Acked.
