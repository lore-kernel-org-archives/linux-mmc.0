From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [patch 2/2] mmc: add support of sdhci-pxa driver
Date: Sun, 26 Sep 2010 20:39:57 +0800
Message-ID: <AANLkTim4aJok6=HcopkObi3WrUatiZgK-KZTfhoHwgF7@mail.gmail.com>
References: <AANLkTi=XBbW=R4HQYp5fLVE5eUXHNtzGh1Qf+XyBUSCH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:44844 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757673Ab0IZMkS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 26 Sep 2010 08:40:18 -0400
Received: by qyk33 with SMTP id 33so6312486qyk.19
        for <linux-mmc@vger.kernel.org>; Sun, 26 Sep 2010 05:40:17 -0700 (PDT)
In-Reply-To: <AANLkTi=XBbW=R4HQYp5fLVE5eUXHNtzGh1Qf+XyBUSCH@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Wolfram Sang <w.sang@pengutronix.de>, Haojian Zhuang <haojian.zhuang@gmail.com>

On Sun, Sep 26, 2010 at 6:56 PM, zhangfei gao <zhangfei.gao@gmail.com> =
wrote:
> Assume the sdhci-pltfm call back are accepted
>
> From f7e1cc9975cbed2d993d4209eae36f8f300fb18c Mon Sep 17 00:00:00 200=
1
> From: Zhangfei Gao <zhangfei.gao@marvell.com>
> Date: Sun, 26 Sep 2010 17:13:43 -0400
> Subject: [PATCH 2/2] mmc: add support of sdhci-pxa driver
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Support Marvell PXA168/PXA910/MMP2 SD Host=
 Controller
>
> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>

Zhangfei,

Patch looks good to me, except for a few minor issues as I commented
below. Please have a look again.

> ---
> =C2=A0arch/arm/plat-pxa/include/plat/sdhci.h | =C2=A0 32 +++++++
> =C2=A0drivers/mmc/host/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | =C2=A0 11 +++
> =C2=A0drivers/mmc/host/Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| =C2=A0 =C2=A01 +
> =C2=A0drivers/mmc/host/sdhci-pxa.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 | =C2=A0143 ++++++++++++++++++++++++++++++++

I prefer we rename it to something like sdhci-mmp.c and the 'pxa' in th=
e source
code to 'mmp' to cause less confusion with pxamci.c?

> =C2=A04 files changed, 187 insertions(+), 0 deletions(-)
> =C2=A0create mode 100644 arch/arm/plat-pxa/include/plat/sdhci.h
> =C2=A0create mode 100644 drivers/mmc/host/sdhci-pxa.c
>
> diff --git a/arch/arm/plat-pxa/include/plat/sdhci.h
> b/arch/arm/plat-pxa/include/plat/sdhci.h
> new file mode 100644
> index 0000000..3d5f5ef
> --- /dev/null
> +++ b/arch/arm/plat-pxa/include/plat/sdhci.h
> @@ -0,0 +1,32 @@
> +/* arch/arm/plat-pxa/include/plat/sdhci.h
> + *
> + * Copyright 2010 Marvell
> + * =C2=A0 =C2=A0 Zhangfei Gao <zhangfei.gao@marvell.com>
> + *
> + * PXA Platform - SDHCI platform data definitions
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#ifndef __PLAT_PXA_SDHCI_H
> +#define __PLAT_PXA_SDHCI_H __FILE__

typo

> +
> +/* pxa specific quirks */
> +/* Card alwayes wired to host, like emmc */
> +#define PXA_QUIRK_BROKEN_CARD_DETECTION (1<<0)
> +/* Require clock free running */
> +#define =C2=A0 =C2=A0 =C2=A0 =C2=A0PXA_QUIRK_DISABLE_CLOCK_GATING (1=
<<1)

tabs/space

> +
> +/**
> + * struct pxa_sdhci_platdata() - Platform device data for PXA SDHCI
> + * @max_speed: The maximum speed supported.
> + * @pxa_quirks: specific quirk of pxa
> +*/
> +struct sdhci_pxa_platdata {
> + =C2=A0 =C2=A0 =C2=A0 unsigned int =C2=A0 =C2=A0max_speed;
> + =C2=A0 =C2=A0 =C2=A0 unsigned int =C2=A0 =C2=A0pxa_quirk;
> +};

'unsigned int quirk' should be enough here, no need for a pxa_ prefix.

> +
> +#endif /* __PLAT_PXA_SDHCI_H */
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 6f12d5d..9510976 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -158,6 +158,17 @@ config MMC_SDHCI_S3C
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0If unsure, say N.
>
> +config MMC_SDHCI_PXA
> + =C2=A0 =C2=A0 =C2=A0 tristate "Marvell PXA168/PXA910/MMP2 SD Host C=
ontroller support"
> + =C2=A0 =C2=A0 =C2=A0 depends on ARCH_PXA || ARCH_MMP

Only on ARCH_MMP or is this also used in PXA950+?

> + =C2=A0 =C2=A0 =C2=A0 depends on MMC_SDHCI_PLTFM
> + =C2=A0 =C2=A0 =C2=A0 help
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 This selects the Marvell(R) PXA168/PXA9=
10/MMP2 SD Host Controller.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 If you have a PXA168/PXA910/MMP2 platfo=
rm with SD Host Controller and a
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 card slot,say Y or M here.
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 If unsure, say N.
> +
> =C2=A0config MMC_SDHCI_SPEAR
> =C2=A0 =C2=A0 =C2=A0 =C2=A0tristate "SDHCI support on ST SPEAr platfo=
rm"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0depends on MMC_SDHCI && PLAT_SPEAR
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index ef32c32..d166493 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -38,6 +38,7 @@ obj-$(CONFIG_MMC_USHC) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0+=3D ushc.o
> =C2=A0obj-$(CONFIG_MMC_SDHCI_PLTFM) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0+=3D sdhci-platform.o
> =C2=A0sdhci-platform-y =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 :=3D sdhci-plt=
fm.o
> =C2=A0sdhci-platform-$(CONFIG_MMC_SDHCI_CNS3XXX) =C2=A0 =C2=A0 +=3D s=
dhci-cns3xxx.o
> +sdhci-platform-$(CONFIG_MMC_SDHCI_PXA) =C2=A0 =C2=A0 =C2=A0 =C2=A0 +=
=3D sdhci-pxa.o
>
> =C2=A0obj-$(CONFIG_MMC_SDHCI_OF) =C2=A0 =C2=A0 +=3D sdhci-of.o
> =C2=A0sdhci-of-y =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 :=3D sdhci-of-core.o
> diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-px=
a.c
> new file mode 100644
> index 0000000..12ede18
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-pxa.c
> @@ -0,0 +1,143 @@
> +/* linux/drivers/mmc/host/sdhci-pxa.c
> + *
> + * Copyright 2010 Marvell
> + * =C2=A0 =C2=A0 =C2=A0Zhangfei Gao <zhangfei.gao@marvell.com>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +/* Supports:
> + * SDHCI support for MMP2/PXA910/PXA168
> + *
> + * Based on =C2=A0sdhci-pltfm.c
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/platform_device.h>
> +#include <linux/mmc/host.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/err.h>
> +#include <plat/sdhci.h>
> +#include <linux/sdhci-pltfm.h>
> +#include "sdhci.h"
> +#include "sdhci-pltfm.h"
> +
> +#define SD_FIFO_PARAM =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x104
> +#define DIS_PAD_SD_CLK_GATE =C2=A0 =C2=A00x400
> +
> +struct sdhci_pxa {
> + =C2=A0 =C2=A0 =C2=A0 struct sdhci_pxa_platdata =C2=A0 =C2=A0 =C2=A0=
 *pdata;
> + =C2=A0 =C2=A0 =C2=A0 struct clk =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*clk;
> +
> + =C2=A0 =C2=A0 =C2=A0 u32 quirks;
> + =C2=A0 =C2=A0 =C2=A0 u8 clk_enable;
> +};
> +
> +/*******************************************************************=
**********\
> + * =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *
> + * SDHCI core callbacks =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*
> + * =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *
> +\*******************************************************************=
**********/
> +static void sdhci_pxa_set_clock(struct sdhci_host *host, unsigned in=
t clock)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct sdhci_pxa *pxa =3D sdhci_priv(host);
> + =C2=A0 =C2=A0 =C2=A0 u32 tmp =3D 0;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (clock =3D=3D 0) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (pxa->clk_enabl=
e) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 clk_disable(pxa->clk);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 pxa->clk_enable =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 } else {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (0 =3D=3D pxa->=
clk_enable) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if (pxa->pdata->pxa_quirk

Better copy this 'pxa_quirk' over to pxa->quirks at initialization?

> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 & PXA_Q=
UIRK_DISABLE_CLOCK_GATING) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tmp =3D readl(host->ioaddr + SD_FIF=
O_PARAM);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tmp |=3D DIS_PAD_SD_CLK_GATE;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 writel(tmp, host->ioaddr + SD_FIFO_=
PARAM);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 clk_enable(pxa->clk);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 pxa->clk_enable =3D 1;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 }
> +}
> +
> +static struct sdhci_ops sdhci_pxa_ops =3D {
> + =C2=A0 =C2=A0 =C2=A0 .set_clock =C2=A0 =C2=A0 =C2=A0=3D sdhci_pxa_s=
et_clock,
> +};
> +
> +/*******************************************************************=
**********\
> + * =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *
> + * sdhci-pltfm callbacks =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*
> + * =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *
> +\*******************************************************************=
**********/
> +static int sdhci_pxa_init(struct sdhci_host *host, struct
> sdhci_pltfm_data *pdata, void* priv_pdata)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct sdhci_pxa *pxa =3D sdhci_priv(host);
> + =C2=A0 =C2=A0 =C2=A0 struct device *dev =3D mmc_dev(host->mmc);
> +
> + =C2=A0 =C2=A0 =C2=A0 pxa->pdata =3D priv_pdata;
> + =C2=A0 =C2=A0 =C2=A0 pxa->clk_enable =3D 0;
> +
> + =C2=A0 =C2=A0 =C2=A0 pxa->clk =3D clk_get(dev, "PXA-SDHCLK");
> + =C2=A0 =C2=A0 =C2=A0 if (IS_ERR(pxa->clk)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(dev, "clk =
err\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENODEV;
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 clk_enable(pxa->clk);
> + =C2=A0 =C2=A0 =C2=A0 dev_dbg(dev, "SDHC clock:%lu\n", clk_get_rate(=
pxa->clk));
> +
> + =C2=A0 =C2=A0 =C2=A0 pxa->clk_enable =3D 0;

Shouldn't this be 1 as you've called clk_enable()? And if the .set_cloc=
k
logic is all right, we can simply leave the clock enabling/disabling to
that function.

Or if the power consumption difference doesn't differ that much, I'd
rather to see simpler solution to this: clk_enable() at probe, and clk_=
disable()
at remove?

> + =C2=A0 =C2=A0 =C2=A0 pxa->quirks =3D pdata->quirks;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (pxa->pdata->pxa_quirk & PXA_QUIRK_BROKEN_C=
ARD_DETECTION)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pxa->quirks |=3D S=
DHCI_QUIRK_BROKEN_CARD_DETECTION;

Why not just use SDHCI_QUIRK_BROKEN_CARD_DETECTION in
pdata->pxa_quirk?

> +
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +}
> +
> +static unsigned int sdhci_pxa_get_quirk(struct sdhci_host *host)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct sdhci_pxa *pxa =3D sdhci_priv(host);
> +
> + =C2=A0 =C2=A0 =C2=A0 return pxa->quirks;
> +}
> +
> +static void sdhci_pxa_set_max_speed(struct sdhci_host *host)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct sdhci_pxa *pxa =3D sdhci_priv(host);
> +
> + =C2=A0 =C2=A0 =C2=A0 if (pxa->pdata->max_speed)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host->mmc->f_max =3D=
 pxa->pdata->max_speed;
> +}
> +
> +static void sdhci_pxa_exit(struct sdhci_host *host)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct sdhci_pxa *pxa =3D sdhci_priv(host);
> +
> + =C2=A0 =C2=A0 =C2=A0 if (pxa->clk_enable)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 clk_disable(pxa->c=
lk);
> + =C2=A0 =C2=A0 =C2=A0 clk_put(pxa->clk);
> +}
> +
> +static struct sdhci_host *sdhci_pxa_alloc_host(struct device *dev)
> +{
> + =C2=A0 =C2=A0 =C2=A0 return sdhci_alloc_host(dev, sizeof(struct sdh=
ci_pxa));
> +}
> +
> +struct sdhci_pltfm_data sdhci_pxa_pdata =3D {
> + =C2=A0 =C2=A0 =C2=A0 .ops =C2=A0 =C2=A0=3D &sdhci_pxa_ops,
> + =C2=A0 =C2=A0 =C2=A0 .quirks =3D SDHCI_QUIRK_BROKEN_ADMA | SDHCI_QU=
IRK_BROKEN_TIMEOUT_VAL,
> + =C2=A0 =C2=A0 =C2=A0 .init =C2=A0 =3D sdhci_pxa_init,
> + =C2=A0 =C2=A0 =C2=A0 .exit =C2=A0 =3D sdhci_pxa_exit,
> + =C2=A0 =C2=A0 =C2=A0 .get_quirk =C2=A0 =C2=A0 =C2=A0=3D sdhci_pxa_g=
et_quirk,
> + =C2=A0 =C2=A0 =C2=A0 .set_max_speed =C2=A0=3D sdhci_pxa_set_max_spe=
ed,
> + =C2=A0 =C2=A0 =C2=A0 .alloc_host =C2=A0 =C2=A0 =3D sdhci_pxa_alloc_=
host,
> +};
> +
> +MODULE_DESCRIPTION("SDH controller driver for PXA168/PXA910/MMP2");
> +MODULE_AUTHOR("Zhangfei Gao <zhangfei.gao@marvell.com>");
> +MODULE_LICENSE("GPL v2");
> --
> 1.7.0.4
>
