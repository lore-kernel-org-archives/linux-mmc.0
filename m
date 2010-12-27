From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH 2/2] sdhci-pxa add call back interface to share sdhci-pxa
Date: Mon, 27 Dec 2010 02:09:27 -0500
Message-ID: <AANLkTikEUb9DLmWbdHsW_R42czELg_W28vUrJ=ohV6f=@mail.gmail.com>
References: <AANLkTi=ECyTAPntMfp_F4Kp2A3UCntLxyWJcbpS3WFP3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63871 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052Ab0L0HJ3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Dec 2010 02:09:29 -0500
Received: by fxm20 with SMTP id 20so8947784fxm.19
        for <linux-mmc@vger.kernel.org>; Sun, 26 Dec 2010 23:09:27 -0800 (PST)
In-Reply-To: <AANLkTi=ECyTAPntMfp_F4Kp2A3UCntLxyWJcbpS3WFP3@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

On Fri, Dec 3, 2010 at 1:31 AM, zhangfei gao <zhangfei.gao@gmail.com> w=
rote:
> From fb5927afac7cbb44805093816bea51dde33da1e5 Mon Sep 17 00:00:00 200=
1
> From: Zhangfei Gao <zhangfei.gao@marvell.com>
> Date: Tue, 30 Nov 2010 05:43:29 -0500
> Subject: [PATCH 2/2] sdhci-pxa: add call back interface to share sdhc=
i-pxa
>
> =A0 =A0 =A0 =A0Call back functions is added to support mmp2, pxa910, =
pxa168 and pxa955
>
> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
> CC: RaymondWu <xywu@marvell.com>
> CC: Jun Nie <njun@marvell.com>
> CC: Philip Rakity <prakity@marvell.com>
> ---
> =A0arch/arm/plat-pxa/include/plat/sdhci.h | =A0 44 +++++++++++++++++
> =A0drivers/mmc/host/sdhci-pxa.c =A0 =A0 =A0 =A0 =A0 | =A0 83 ++++++++=
+++++++++++++-----------
> =A02 files changed, 98 insertions(+), 29 deletions(-)
>
> diff --git a/arch/arm/plat-pxa/include/plat/sdhci.h
> b/arch/arm/plat-pxa/include/plat/sdhci.h
> index 1ab332e..4ce3b05 100644
> --- a/arch/arm/plat-pxa/include/plat/sdhci.h
> +++ b/arch/arm/plat-pxa/include/plat/sdhci.h
> @@ -13,9 +13,14 @@
> =A0#ifndef __PLAT_PXA_SDHCI_H
> =A0#define __PLAT_PXA_SDHCI_H
>
> +#include <linux/mmc/sdhci.h>
> +#include <linux/platform_device.h>
> +
> =A0/* pxa specific flag */
> =A0/* Require clock free running */
> =A0#define PXA_FLAG_DISABLE_CLOCK_GATING (1<<0)
> +/* card alwayes wired to host, like on-chip emmc */
> +#define PXA_FLAG_CARD_PERMANENT =A0 =A0 =A0 =A0(1<<1)
>
> =A0/* Board design supports 8-bit data on SD/SDIO BUS */
> =A0#define PXA_FLAG_SD_8_BIT_CAPABLE_SLOT (1<<2)
> @@ -25,11 +30,50 @@
> =A0* @max_speed: the maximum speed supported
> =A0* @quirks: quirks of specific device
> =A0* @flags: flags for platform requirement
> + * @clk_delay_cycles:
> + * =A0 =A0 mmp2: each step is roughly 100ps, 5bits width
> + * =A0 =A0 pxa910 & pxa168: each step is 1ns, 4bits width
> + * @clk_delay_enable: enable clk_delay or not, used on pxa910 & pxa1=
68
> + * @clk_delay_sel: select clk_delay, used on pxa910 & pxa168
> + * =A0 =A0 0: choose feedback clk
> + * =A0 =A0 1: choose feedback clk + delay value
> + * =A0 =A0 2: choose internal clk
> + * @ext_cd_gpio: gpio pin used for external CD line
> + * @ext_cd_gpio_invert: invert values for external CD gpio line
> + * @soc_set_timing: set timing for specific soc
> + * @ext_cd_init: Initialize external card detect subsystem
> + * @ext_cd_cleanup: Cleanup external card detect subsystem
> + * @soc_set_ops: overwrite host ops with soc specific ops
> =A0*/
> +struct sdhci_pxa;
> =A0struct sdhci_pxa_platdata {
> =A0 =A0 =A0 =A0unsigned int =A0 =A0max_speed;
> =A0 =A0 =A0 =A0unsigned int =A0 =A0quirks;
> =A0 =A0 =A0 =A0unsigned int =A0 =A0flags;
> + =A0 =A0 =A0 unsigned int =A0 =A0clk_delay_cycles;
> + =A0 =A0 =A0 unsigned int =A0 =A0clk_delay_sel;
> + =A0 =A0 =A0 unsigned int =A0 =A0ext_cd_gpio;
> + =A0 =A0 =A0 bool =A0 =A0 =A0 =A0 =A0 =A0ext_cd_gpio_invert;
> + =A0 =A0 =A0 bool =A0 =A0 =A0 =A0 =A0 =A0clk_delay_enable;
> +
> + =A0 =A0 =A0 void (*soc_set_timing)(struct sdhci_host *host,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct sdhci_pxa_platda=
ta *pdata);
> + =A0 =A0 =A0 int (*ext_cd_init)(void (*notify_func)(struct platform_=
device *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int state), void *data);
> + =A0 =A0 =A0 int (*ext_cd_cleanup)(void (*notify_func)(struct platfo=
rm_device *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int state), void *data);
> + =A0 =A0 =A0 void (*soc_set_ops)(struct sdhci_pxa *pxa);
> +};
> +
> +struct sdhci_pxa {
> + =A0 =A0 =A0 struct sdhci_host =A0 =A0 =A0 =A0 =A0 =A0 =A0 *host;
> + =A0 =A0 =A0 struct sdhci_pxa_platdata =A0 =A0 =A0 *pdata;
> + =A0 =A0 =A0 struct clk =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*=
clk;
> + =A0 =A0 =A0 struct resource =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *res;
> + =A0 =A0 =A0 struct sdhci_ops =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*ops;
> +
> + =A0 =A0 =A0 u8 =A0 =A0 =A0clk_enable;
> + =A0 =A0 =A0 u8 =A0 =A0 =A0power_mode;
> =A0};
>
> =A0#endif /* __PLAT_PXA_SDHCI_H */
> diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-px=
a.c
> index 5a61208..f79dccf 100644
> --- a/drivers/mmc/host/sdhci-pxa.c
> +++ b/drivers/mmc/host/sdhci-pxa.c
> @@ -24,32 +24,22 @@
> =A0#include <linux/clk.h>
> =A0#include <linux/io.h>
> =A0#include <linux/err.h>
> +#include <linux/slab.h>
> =A0#include <plat/sdhci.h>
> =A0#include "sdhci.h"
>
> =A0#define DRIVER_NAME =A0 =A0"sdhci-pxa"
>
> -#define SD_FIFO_PARAM =A0 =A0 =A0 =A0 =A00x104
> -#define DIS_PAD_SD_CLK_GATE =A0 =A00x400
> -
> -struct sdhci_pxa {
> - =A0 =A0 =A0 struct sdhci_host =A0 =A0 =A0 =A0 =A0 =A0 =A0 *host;
> - =A0 =A0 =A0 struct sdhci_pxa_platdata =A0 =A0 =A0 *pdata;
> - =A0 =A0 =A0 struct clk =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*=
clk;
> - =A0 =A0 =A0 struct resource =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *res;
> -
> - =A0 =A0 =A0 u8 clk_enable;
> -};
> -
> =A0/*****************************************************************=
************\
> =A0* =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 *
> =A0* SDHCI core callbacks =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*
> =A0* =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 *
> =A0\*****************************************************************=
************/
> +
> =A0static void set_clock(struct sdhci_host *host, unsigned int clock)
> =A0{
> =A0 =A0 =A0 =A0struct sdhci_pxa *pxa =3D sdhci_priv(host);
> - =A0 =A0 =A0 u32 tmp =3D 0;
> + =A0 =A0 =A0 struct sdhci_pxa_platdata *pdata =3D pxa->pdata;
>
> =A0 =A0 =A0 =A0if (clock =3D=3D 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (pxa->clk_enable) {
> @@ -57,21 +47,31 @@ static void set_clock(struct sdhci_host *host,
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
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pdata && pdata->soc_set_timing)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->soc_set_timing(h=
ost, pdata);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_enable(pxa->clk);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pxa->clk_enable =3D 1;
> =A0 =A0 =A0 =A0}
> =A0}
>
> -static struct sdhci_ops sdhci_pxa_ops =3D {
> - =A0 =A0 =A0 .set_clock =3D set_clock,
> -};
> +static void sdhci_pxa_notify_change(struct platform_device *dev, int=
 state)
> +{
> + =A0 =A0 =A0 struct sdhci_host *host =3D platform_get_drvdata(dev);
> + =A0 =A0 =A0 unsigned long flags;
> +
> + =A0 =A0 =A0 if (host) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&host->lock, flags);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (state) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&dev->dev, "car=
d inserted.\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->flags &=3D ~SDHCI=
_DEVICE_DEAD;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&dev->dev, "car=
d removed.\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->flags |=3D SDHCI_=
DEVICE_DEAD;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tasklet_schedule(&host->card_tasklet);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&host->lock, fla=
gs);
> + =A0 =A0 =A0 }
> +}
>
> =A0/*****************************************************************=
************\
> =A0* =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 *
> @@ -111,6 +111,12 @@ static int __devinit sdhci_pxa_probe(struct
> platform_device *pdev)
> =A0 =A0 =A0 =A0pxa->pdata =3D pdata;
> =A0 =A0 =A0 =A0pxa->clk_enable =3D 0;
>
> + =A0 =A0 =A0 pxa->ops =3D kzalloc(sizeof(struct sdhci_ops), GFP_KERN=
EL);
> + =A0 =A0 =A0 if (!pxa->ops) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0pxa->clk =3D clk_get(dev, "PXA-SDHCLK");
> =A0 =A0 =A0 =A0if (IS_ERR(pxa->clk)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(dev, "failed to get io clock\n=
");
> @@ -134,32 +140,46 @@ static int __devinit sdhci_pxa_probe(struct
> platform_device *pdev)
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0host->hw_name =3D "MMC";
> - =A0 =A0 =A0 host->ops =3D &sdhci_pxa_ops;
> =A0 =A0 =A0 =A0host->irq =3D irq;
> =A0 =A0 =A0 =A0host->quirks =3D SDHCI_QUIRK_BROKEN_ADMA | SDHCI_QUIRK=
_BROKEN_TIMEOUT_VAL;
>
> - =A0 =A0 =A0 if (pdata->quirks)
> + =A0 =A0 =A0 if (pdata && pdata->flags & PXA_FLAG_CARD_PERMANENT) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* on-chip device */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->quirks |=3D SDHCI_QUIRK_BROKEN_CA=
RD_DETECTION;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->mmc->caps |=3D MMC_CAP_NONREMOVAB=
LE;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (pdata && pdata->quirks)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->quirks |=3D pdata->quirks;
>
> =A0 =A0 =A0 =A0/* If slot design supports 8 bit data, indicate this t=
o MMC. */
> =A0 =A0 =A0 =A0if (pdata->flags & PXA_FLAG_SD_8_BIT_CAPABLE_SLOT)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->mmc->caps |=3D MMC_CAP_8_BIT_DAT=
A;
>
> + =A0 =A0 =A0 if (pdata && pdata->soc_set_ops)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->soc_set_ops(pxa);
> +
> + =A0 =A0 =A0 pxa->ops->set_clock =3D set_clock;
> + =A0 =A0 =A0 host->ops =3D pxa->ops;
> +
> =A0 =A0 =A0 =A0ret =3D sdhci_add_host(host);
> =A0 =A0 =A0 =A0if (ret) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&pdev->dev, "failed to add hos=
t\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 if (pxa->pdata->max_speed)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->mmc->f_max =3D pxa->pdata->max_sp=
eed;
> + =A0 =A0 =A0 if (pdata && pdata->max_speed)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->mmc->f_max =3D pdata->max_speed;
>
> + =A0 =A0 =A0 if (pdata && pdata->ext_cd_init)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->ext_cd_init(&sdhci_pxa_notify_ch=
ange, pdata);
> =A0 =A0 =A0 =A0platform_set_drvdata(pdev, host);
>
> =A0 =A0 =A0 =A0return 0;
> =A0out:
> =A0 =A0 =A0 =A0if (host) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clk_put(pxa->clk);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(pxa->ops);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (host->ioaddr)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0iounmap(host->ioaddr);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (pxa->res)
> @@ -173,18 +193,23 @@ out:
>
> =A0static int __devexit sdhci_pxa_remove(struct platform_device *pdev=
)
> =A0{
> + =A0 =A0 =A0 struct sdhci_pxa_platdata *pdata =3D pdev->dev.platform=
_data;
> =A0 =A0 =A0 =A0struct sdhci_host *host =3D platform_get_drvdata(pdev)=
;
> =A0 =A0 =A0 =A0struct sdhci_pxa *pxa =3D sdhci_priv(host);
> =A0 =A0 =A0 =A0int dead =3D 0;
> =A0 =A0 =A0 =A0u32 scratch;
>
> =A0 =A0 =A0 =A0if (host) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pdata && pdata->ext_cd_cleanup)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->ext_cd_cleanup(&=
sdhci_pxa_notify_change, pdata);
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0scratch =3D readl(host->ioaddr + SDHCI=
_INT_STATUS);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (scratch =3D=3D (u32)-1)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dead =3D 1;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sdhci_remove_host(host, dead);
>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(pxa->ops);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (host->ioaddr)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0iounmap(host->ioaddr);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (pxa->res)
> --
> 1.7.0.4
>
