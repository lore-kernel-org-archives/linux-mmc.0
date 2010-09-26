From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [patch 2/2] mmc: add support of sdhci-pxa driver
Date: Sun, 26 Sep 2010 23:05:32 +0800
Message-ID: <AANLkTimmr8ajiFaqW6iJAnDpJhyD+oqE+2qOwU3sfJxa@mail.gmail.com>
References: <AANLkTi=XBbW=R4HQYp5fLVE5eUXHNtzGh1Qf+XyBUSCH@mail.gmail.com>
	<AANLkTim4aJok6=HcopkObi3WrUatiZgK-KZTfhoHwgF7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33410 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752675Ab0IZPFd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 26 Sep 2010 11:05:33 -0400
Received: by iwn5 with SMTP id 5so3944367iwn.19
        for <linux-mmc@vger.kernel.org>; Sun, 26 Sep 2010 08:05:32 -0700 (PDT)
In-Reply-To: <AANLkTim4aJok6=HcopkObi3WrUatiZgK-KZTfhoHwgF7@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Wolfram Sang <w.sang@pengutronix.de>, Haojian Zhuang <haojian.zhuang@gmail.com>

On Sun, Sep 26, 2010 at 8:39 PM, Eric Miao <eric.y.miao@gmail.com> wrot=
e:
> On Sun, Sep 26, 2010 at 6:56 PM, zhangfei gao <zhangfei.gao@gmail.com=
> wrote:
>> Assume the sdhci-pltfm call back are accepted
>>
>> From f7e1cc9975cbed2d993d4209eae36f8f300fb18c Mon Sep 17 00:00:00 20=
01
>> From: Zhangfei Gao <zhangfei.gao@marvell.com>
>> Date: Sun, 26 Sep 2010 17:13:43 -0400
>> Subject: [PATCH 2/2] mmc: add support of sdhci-pxa driver
>>
>> =A0 =A0 =A0 =A0Support Marvell PXA168/PXA910/MMP2 SD Host Controller
>>
>> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
>
> Zhangfei,
>
> Patch looks good to me, except for a few minor issues as I commented
> below. Please have a look again.
>
>> ---
>> =A0arch/arm/plat-pxa/include/plat/sdhci.h | =A0 32 +++++++
>> =A0drivers/mmc/host/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 11 +++
>> =A0drivers/mmc/host/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A01 +
>> =A0drivers/mmc/host/sdhci-pxa.c =A0 =A0 =A0 =A0 =A0 | =A0143 +++++++=
+++++++++++++++++++++++++
>
> I prefer we rename it to something like sdhci-mmp.c and the 'pxa' in =
the source
> code to 'mmp' to cause less confusion with pxamci.c?

pxamci.c is used for pxa25x/26x/27x, while sdhci-pxa.c is used for
pxa168/pxa910/mmp2.
>
>> =A04 files changed, 187 insertions(+), 0 deletions(-)
>> =A0create mode 100644 arch/arm/plat-pxa/include/plat/sdhci.h
>> =A0create mode 100644 drivers/mmc/host/sdhci-pxa.c
>>
>> diff --git a/arch/arm/plat-pxa/include/plat/sdhci.h
>> b/arch/arm/plat-pxa/include/plat/sdhci.h
>> new file mode 100644
>> index 0000000..3d5f5ef
>> --- /dev/null
>> +++ b/arch/arm/plat-pxa/include/plat/sdhci.h
>> @@ -0,0 +1,32 @@
>> +/* arch/arm/plat-pxa/include/plat/sdhci.h
>> + *
>> + * Copyright 2010 Marvell
>> + * =A0 =A0 Zhangfei Gao <zhangfei.gao@marvell.com>
>> + *
>> + * PXA Platform - SDHCI platform data definitions
>> + *
>> + * This program is free software; you can redistribute it and/or mo=
dify
>> + * it under the terms of the GNU General Public License version 2 a=
s
>> + * published by the Free Software Foundation.
>> +*/
>> +
>> +#ifndef __PLAT_PXA_SDHCI_H
>> +#define __PLAT_PXA_SDHCI_H __FILE__
>
> typo
>
>> +
>> +/* pxa specific quirks */
>> +/* Card alwayes wired to host, like emmc */
>> +#define PXA_QUIRK_BROKEN_CARD_DETECTION (1<<0)
>> +/* Require clock free running */
>> +#define =A0 =A0 =A0 =A0PXA_QUIRK_DISABLE_CLOCK_GATING (1<<1)
>
> tabs/space
>
>> +
>> +/**
>> + * struct pxa_sdhci_platdata() - Platform device data for PXA SDHCI
>> + * @max_speed: The maximum speed supported.
>> + * @pxa_quirks: specific quirk of pxa
>> +*/
>> +struct sdhci_pxa_platdata {
>> + =A0 =A0 =A0 unsigned int =A0 =A0max_speed;
>> + =A0 =A0 =A0 unsigned int =A0 =A0pxa_quirk;
>> +};
>
> 'unsigned int quirk' should be enough here, no need for a pxa_ prefix=
=2E
 To distinguish the pxa->quirk, which used for transfer to sdhci,c
>
>> +
>> +#endif /* __PLAT_PXA_SDHCI_H */
>> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
>> index 6f12d5d..9510976 100644
>> --- a/drivers/mmc/host/Kconfig
>> +++ b/drivers/mmc/host/Kconfig
>> @@ -158,6 +158,17 @@ config MMC_SDHCI_S3C
>>
>> =A0 =A0 =A0 =A0 =A0If unsure, say N.
>>
>> +config MMC_SDHCI_PXA
>> + =A0 =A0 =A0 tristate "Marvell PXA168/PXA910/MMP2 SD Host Controlle=
r support"
>> + =A0 =A0 =A0 depends on ARCH_PXA || ARCH_MMP
>
> Only on ARCH_MMP or is this also used in PXA950+?
>
>> + =A0 =A0 =A0 depends on MMC_SDHCI_PLTFM
>> + =A0 =A0 =A0 help
>> + =A0 =A0 =A0 =A0 This selects the Marvell(R) PXA168/PXA910/MMP2 SD =
Host Controller.
>> + =A0 =A0 =A0 =A0 If you have a PXA168/PXA910/MMP2 platform with SD =
Host Controller and a
>> + =A0 =A0 =A0 =A0 card slot,say Y or M here.
>> +
>> + =A0 =A0 =A0 =A0 If unsure, say N.
>> +
>> =A0config MMC_SDHCI_SPEAR
>> =A0 =A0 =A0 =A0tristate "SDHCI support on ST SPEAr platform"
>> =A0 =A0 =A0 =A0depends on MMC_SDHCI && PLAT_SPEAR
>> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
>> index ef32c32..d166493 100644
>> --- a/drivers/mmc/host/Makefile
>> +++ b/drivers/mmc/host/Makefile
>> @@ -38,6 +38,7 @@ obj-$(CONFIG_MMC_USHC) =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0+=3D ushc.o
>> =A0obj-$(CONFIG_MMC_SDHCI_PLTFM) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
+=3D sdhci-platform.o
>> =A0sdhci-platform-y =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 :=3D sdhci-pltfm.o
>> =A0sdhci-platform-$(CONFIG_MMC_SDHCI_CNS3XXX) =A0 =A0 +=3D sdhci-cns=
3xxx.o
>> +sdhci-platform-$(CONFIG_MMC_SDHCI_PXA) =A0 =A0 =A0 =A0 +=3D sdhci-p=
xa.o
>>
>> =A0obj-$(CONFIG_MMC_SDHCI_OF) =A0 =A0 +=3D sdhci-of.o
>> =A0sdhci-of-y =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 :=3D sdhci-of-core.o
>> diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-p=
xa.c
>> new file mode 100644
>> index 0000000..12ede18
>> --- /dev/null
>> +++ b/drivers/mmc/host/sdhci-pxa.c
>> @@ -0,0 +1,143 @@
>> +/* linux/drivers/mmc/host/sdhci-pxa.c
>> + *
>> + * Copyright 2010 Marvell
>> + * =A0 =A0 =A0Zhangfei Gao <zhangfei.gao@marvell.com>
>> + *
>> + * This program is free software; you can redistribute it and/or mo=
dify
>> + * it under the terms of the GNU General Public License version 2 a=
s
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +/* Supports:
>> + * SDHCI support for MMP2/PXA910/PXA168
>> + *
>> + * Based on =A0sdhci-pltfm.c
>> + */
>> +
>> +#include <linux/delay.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/mmc/host.h>
>> +#include <linux/clk.h>
>> +#include <linux/io.h>
>> +#include <linux/err.h>
>> +#include <plat/sdhci.h>
>> +#include <linux/sdhci-pltfm.h>
>> +#include "sdhci.h"
>> +#include "sdhci-pltfm.h"
>> +
>> +#define SD_FIFO_PARAM =A0 =A0 =A0 =A0 =A00x104
>> +#define DIS_PAD_SD_CLK_GATE =A0 =A00x400
>> +
>> +struct sdhci_pxa {
>> + =A0 =A0 =A0 struct sdhci_pxa_platdata =A0 =A0 =A0 *pdata;
>> + =A0 =A0 =A0 struct clk =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
*clk;
>> +
>> + =A0 =A0 =A0 u32 quirks;
>> + =A0 =A0 =A0 u8 clk_enable;
>> +};
>> +
>> +/******************************************************************=
***********\
>> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 *
>> + * SDHCI core callbacks =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*
>> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 *
>> +\******************************************************************=
***********/
>> +static void sdhci_pxa_set_clock(struct sdhci_host *host, unsigned i=
nt clock)
>> +{
>> + =A0 =A0 =A0 struct sdhci_pxa *pxa =3D sdhci_priv(host);
>> + =A0 =A0 =A0 u32 tmp =3D 0;
>> +
>> + =A0 =A0 =A0 if (clock =3D=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pxa->clk_enable) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(pxa->clk);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pxa->clk_enable =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (0 =3D=3D pxa->clk_enable) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pxa->pdata->pxa_qu=
irk
>
> Better copy this 'pxa_quirk' over to pxa->quirks at initialization?

Some confusion here.
Since quirk is limited resource, we should not over-used, however, the
quirk method is good design and could be used to distinguish different
device for different usage.
pxa_quirk is used by our own driver, transfered from platform data,
for example, driver may understand free-running requirement from emmc.
pxa->quirks is used for transfer to sdhci.c, which contains  not only
the init quirks, but also some other requirement, such as
SDHCI_QUIRK_BROKEN_CARD_DETECTION, which only effective to on-chip
non-removalbe device.


>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 & PXA_QUIRK_DISABLE_CLOCK_GATING) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp =3D=
 readl(host->ioaddr + SD_FIFO_PARAM);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp |=3D=
 DIS_PAD_SD_CLK_GATE;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 writel=
(tmp, host->ioaddr + SD_FIFO_PARAM);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_enable(pxa->clk);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pxa->clk_enable =3D 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 }
>> +}
>> +
>> +static struct sdhci_ops sdhci_pxa_ops =3D {
>> + =A0 =A0 =A0 .set_clock =A0 =A0 =A0=3D sdhci_pxa_set_clock,
>> +};
>> +
>> +/******************************************************************=
***********\
>> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 *
>> + * sdhci-pltfm callbacks =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*
>> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 *
>> +\******************************************************************=
***********/
>> +static int sdhci_pxa_init(struct sdhci_host *host, struct
>> sdhci_pltfm_data *pdata, void* priv_pdata)
>> +{
>> + =A0 =A0 =A0 struct sdhci_pxa *pxa =3D sdhci_priv(host);
>> + =A0 =A0 =A0 struct device *dev =3D mmc_dev(host->mmc);
>> +
>> + =A0 =A0 =A0 pxa->pdata =3D priv_pdata;
>> + =A0 =A0 =A0 pxa->clk_enable =3D 0;
>> +
>> + =A0 =A0 =A0 pxa->clk =3D clk_get(dev, "PXA-SDHCLK");
>> + =A0 =A0 =A0 if (IS_ERR(pxa->clk)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "clk err\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 clk_enable(pxa->clk);
>> + =A0 =A0 =A0 dev_dbg(dev, "SDHC clock:%lu\n", clk_get_rate(pxa->clk=
));
>> +
>> + =A0 =A0 =A0 pxa->clk_enable =3D 0;
>
> Shouldn't this be 1 as you've called clk_enable()? And if the .set_cl=
ock
> logic is all right, we can simply leave the clock enabling/disabling =
to
> that function.

Thanks for finding, the clk_enable(pxa->clk) is planed to be removed
here, just use .set_clock to do clock issue, though one small issue is
mmc stack would never set_clock(host, 0) to disalbe clock, will submit
patch later.

>
> Or if the power consumption difference doesn't differ that much, I'd
> rather to see simpler solution to this: clk_enable() at probe, and cl=
k_disable()
> at remove?
>
>> + =A0 =A0 =A0 pxa->quirks =3D pdata->quirks;
>> +
>> + =A0 =A0 =A0 if (pxa->pdata->pxa_quirk & PXA_QUIRK_BROKEN_CARD_DETE=
CTION)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pxa->quirks |=3D SDHCI_QUIRK_BROKEN_CA=
RD_DETECTION;
>
> Why not just use SDHCI_QUIRK_BROKEN_CARD_DETECTION in
> pdata->pxa_quirk?

SDHCI_QUIRK_BROKEN_CARD_DETECTION is defined in sdhci.h, which in
driver/mmc/host instead of include, what's more, quirk is limited
resource, and we should not touch quirk as much as possible.

>
>> +
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> +static unsigned int sdhci_pxa_get_quirk(struct sdhci_host *host)
>> +{
>> + =A0 =A0 =A0 struct sdhci_pxa *pxa =3D sdhci_priv(host);
>> +
>> + =A0 =A0 =A0 return pxa->quirks;
>> +}
>> +
>> +static void sdhci_pxa_set_max_speed(struct sdhci_host *host)
>> +{
>> + =A0 =A0 =A0 struct sdhci_pxa *pxa =3D sdhci_priv(host);
>> +
>> + =A0 =A0 =A0 if (pxa->pdata->max_speed)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->mmc->f_max =3D pxa->pdata->max_s=
peed;
>> +}
>> +
>> +static void sdhci_pxa_exit(struct sdhci_host *host)
>> +{
>> + =A0 =A0 =A0 struct sdhci_pxa *pxa =3D sdhci_priv(host);
>> +
>> + =A0 =A0 =A0 if (pxa->clk_enable)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(pxa->clk);
>> + =A0 =A0 =A0 clk_put(pxa->clk);
>> +}
>> +
>> +static struct sdhci_host *sdhci_pxa_alloc_host(struct device *dev)
>> +{
>> + =A0 =A0 =A0 return sdhci_alloc_host(dev, sizeof(struct sdhci_pxa))=
;
>> +}
>> +
>> +struct sdhci_pltfm_data sdhci_pxa_pdata =3D {
>> + =A0 =A0 =A0 .ops =A0 =A0=3D &sdhci_pxa_ops,
>> + =A0 =A0 =A0 .quirks =3D SDHCI_QUIRK_BROKEN_ADMA | SDHCI_QUIRK_BROK=
EN_TIMEOUT_VAL,
>> + =A0 =A0 =A0 .init =A0 =3D sdhci_pxa_init,
>> + =A0 =A0 =A0 .exit =A0 =3D sdhci_pxa_exit,
>> + =A0 =A0 =A0 .get_quirk =A0 =A0 =A0=3D sdhci_pxa_get_quirk,
>> + =A0 =A0 =A0 .set_max_speed =A0=3D sdhci_pxa_set_max_speed,
>> + =A0 =A0 =A0 .alloc_host =A0 =A0 =3D sdhci_pxa_alloc_host,
>> +};
>> +
>> +MODULE_DESCRIPTION("SDH controller driver for PXA168/PXA910/MMP2");
>> +MODULE_AUTHOR("Zhangfei Gao <zhangfei.gao@marvell.com>");
>> +MODULE_LICENSE("GPL v2");
>> --
>> 1.7.0.4
>>
>
