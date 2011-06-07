From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH v3 2/4] mmc: support sdhci-pxav2.c
Date: Tue, 7 Jun 2011 14:03:53 +0800
Message-ID: <BANLkTink=-CVNDSQ96zXvOfRcZqY9S6tLQ@mail.gmail.com>
References: <1307094606-8692-1-git-send-email-zhangfei.gao@marvell.com>
	<8B77F7FC-7D30-44E2-A262-EA0EFA2D45A2@marvell.com>
	<F07D64EA-88E7-4BF2-B677-3A01215923DD@marvell.com>
	<5FF51201-93F0-4A45-A93A-A60BD4AD444F@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:34617 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750815Ab1FGGDy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Jun 2011 02:03:54 -0400
Received: by vxi39 with SMTP id 39so3310505vxi.19
        for <linux-mmc@vger.kernel.org>; Mon, 06 Jun 2011 23:03:53 -0700 (PDT)
In-Reply-To: <5FF51201-93F0-4A45-A93A-A60BD4AD444F@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: Zhangfei Gao <zgao6@marvell.com>, Shawn Guo <shawn.guo@linaro.org>, Eric Miao <eric.y.miao@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@fluxnic.net>, Qiming Wu <wuqm@marvell.com>, Jun Nie <njun@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Wolfram Sang <w.sang@pengutronix.de>, Haojian Zhuang <haojian.zhuang@gmail.com>, Raymond Wu <xywu@marvell.com>, Chris Ball <cjb@laptop.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Sat, Jun 4, 2011 at 8:04 AM, Philip Rakity <prakity@marvell.com> wro=
te:
>
>>
>>
>> On Jun 3, 2011, at 11:42 AM, Philip Rakity wrote:
>>
>>>
>>> On Jun 3, 2011, at 2:50 AM, Zhangfei Gao wrote:
>>>
>>>> =A0 =A0 SDHCI driver for pxav2 SoCs, such as pxa910, the driver ba=
sed on sdhci-pltfm to handle resource etc.
>>>>
>>>> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
>>>> Signed-off-by: Jun Nie <njun@marvell.com>
>>>> Signed-off-by: Qiming Wu <wuqm@marvell.com>
>>>> ---
>>>> drivers/mmc/host/Kconfig =A0 =A0 =A0 | =A0 11 ++
>>>> drivers/mmc/host/Makefile =A0 =A0 =A0| =A0 =A01 +
>>>> drivers/mmc/host/sdhci-pxav2.c | =A0261 ++++++++++++++++++++++++++=
++++++++++++++
>>>> 3 files changed, 273 insertions(+), 0 deletions(-)
>>>> create mode 100644 drivers/mmc/host/sdhci-pxav2.c
>>>>
>>>> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
>>>> index 4ee869a..1a53d59 100644
>>>> --- a/drivers/mmc/host/Kconfig
>>>> +++ b/drivers/mmc/host/Kconfig
>>>> @@ -192,6 +192,17 @@ config MMC_SDHCI_PXAV3
>>>>
>>>> =A0 =A0 =A0 If unsure, say N.
>>>>
>>>> +config MMC_SDHCI_PXAV2
>>>> + =A0 tristate "Marvell PXAV2 SD Host Controller support"
>>>> + =A0 select MMC_SDHCI
>>>> + =A0 select MMC_SDHCI_PLTFM
>>>> + =A0 help
>>>> + =A0 =A0 This selects the Marvell(R) PXAV2 SD Host Controller.
>>>> + =A0 =A0 If you have a PXAV2 platform (such as pxa910) with SD Ho=
st Controller
>>>> + =A0 =A0 and a card slot, say Y or M here.
>>>> +
>>>> + =A0 =A0 If unsure, say N.
>>>> +
>>>> config MMC_SDHCI_SPEAR
>>>> =A0 =A0 tristate "SDHCI support on ST SPEAr platform"
>>>> =A0 =A0 depends on MMC_SDHCI && PLAT_SPEAR
>>>> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
>>>> index 9131a27..cf95330 100644
>>>> --- a/drivers/mmc/host/Makefile
>>>> +++ b/drivers/mmc/host/Makefile
>>>> @@ -10,6 +10,7 @@ obj-$(CONFIG_MMC_MXS) =A0 =A0 =A0 =A0 =A0 =A0 +=3D=
 mxs-mmc.o
>>>> obj-$(CONFIG_MMC_SDHCI) =A0 =A0 =A0 =A0 =A0 =A0 +=3D sdhci.o
>>>> obj-$(CONFIG_MMC_SDHCI_PCI) +=3D sdhci-pci.o
>>>> obj-$(CONFIG_MMC_SDHCI_PXAV3) =A0 =A0 =A0 +=3D sdhci-pxav3.o
>>>> +obj-$(CONFIG_MMC_SDHCI_PXAV2) =A0 =A0 =A0+=3D sdhci-pxav2.o
>>>> obj-$(CONFIG_MMC_SDHCI_S3C) +=3D sdhci-s3c.o
>>>> obj-$(CONFIG_MMC_SDHCI_SPEAR) =A0 =A0 =A0 +=3D sdhci-spear.o
>>>> obj-$(CONFIG_MMC_WBSD) =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D wbsd.o
>>>> diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdh=
ci-pxav2.c
>>>> new file mode 100644
>>>> index 0000000..759f526
>>>> --- /dev/null
>>>> +++ b/drivers/mmc/host/sdhci-pxav2.c
>>>> @@ -0,0 +1,261 @@
>>>> +/*
>>>> + * Copyright (C) 2010 Marvell International Ltd.
>>>> + * =A0 =A0 =A0 =A0 Zhangfei Gao <zhangfei.gao@marvell.com>
>>>> + * =A0 =A0 =A0 =A0 Kevin Wang <dwang4@marvell.com>
>>>> + * =A0 =A0 =A0 =A0 Jun Nie <njun@marvell.com>
>>>> + * =A0 =A0 =A0 =A0 Qiming Wu <wuqm@marvell.com>
>>>> + * =A0 =A0 =A0 =A0 Philip Rakity <prakity@marvell.com>
>>>> + *
>>>> + * This software is licensed under the terms of the GNU General P=
ublic
>>>> + * License version 2, as published by the Free Software Foundatio=
n, and
>>>> + * may be copied, distributed, and modified under those terms.
>>>> + *
>>>> + * This program is distributed in the hope that it will be useful=
,
>>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See th=
e
>>>> + * GNU General Public License for more details.
>>>> + *
>>>> + */
>>>> +
>>>> +#include <linux/err.h>
>>>> +#include <linux/init.h>
>>>> +#include <linux/platform_device.h>
>>>> +#include <linux/clk.h>
>>>> +#include <linux/io.h>
>>>> +#include <linux/gpio.h>
>>>> +#include <linux/mmc/card.h>
>>>> +#include <linux/mmc/host.h>
>>>> +#include <plat/sdhci.h>
>>>> +#include <linux/slab.h>
>>>> +#include "sdhci.h"
>>>> +#include "sdhci-pltfm.h"
>>>> +
>>>> +#define SD_FIFO_PARAM =A0 =A0 =A0 =A0 =A0 =A0 =A00xe0
>>>> +#define DIS_PAD_SD_CLK_GATE =A0 =A0 =A0 =A00x0400 /* Turn on/off =
Dynamic SD Clock Gating */
>>>> +#define CLK_GATE_ON =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x0200 /* Disa=
ble/enable Clock Gate */
>>>> +#define CLK_GATE_CTL =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x0100 /* Clock =
Gate Control */
>>>> +#define CLK_GATE_SETTING_BITS =A0 =A0 =A0(DIS_PAD_SD_CLK_GATE | \
>>>> + =A0 =A0 =A0 =A0 =A0 CLK_GATE_ON | CLK_GATE_CTL)
>>>> +
>>>> +#define SD_CLOCK_BURST_SIZE_SETUP =A00xe6
>>>> +#define SDCLK_SEL_SHIFT =A0 =A0 =A0 =A0 =A0 =A08
>>>> +#define SDCLK_SEL_MASK =A0 =A0 =A0 =A0 =A0 =A0 0x3
>>>> +#define SDCLK_DELAY_SHIFT =A010
>>>> +#define SDCLK_DELAY_MASK =A0 0x3c
>>>> +
>>>> +#define SDHCI_HOST_CONTROL 0x28
>>
>
>
> This definition should come from the sdhci.h include file since it is=
 part of the sd host controller spec.
Thanks, will remove.
>
>> .
>>
>>>> +#define =A0SDHCI_CTRL_4BITBUS =A0 =A0 =A0 =A00x02
>>>> +
>>>> +#define SD_CE_ATA_2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00xea
>>>> +#define MMC_CARD =A0 =A0 =A0 =A0 =A0 0x1000
>>>> +#define MMC_WIDTH =A0 =A0 =A0 =A0 =A00x0100
>>>> +
>>>> +static void pxav2_set_private_registers(struct sdhci_host *host, =
u8 mask)
>>>> +{
>>>> + =A0 struct platform_device *pdev =3D to_platform_device(mmc_dev(=
host->mmc));
>>>> + =A0 struct sdhci_pxa_platdata *pdata =3D pdev->dev.platform_data=
;
>>>> +
>>>> + =A0 if (mask =3D=3D SDHCI_RESET_ALL) {
>>>> + =A0 =A0 =A0 =A0 =A0 u16 tmp =3D 0;
>>>> +
>>>> + =A0 =A0 =A0 =A0 =A0 /*
>>>> + =A0 =A0 =A0 =A0 =A0 =A0* tune timing of read data/command when c=
rc error happen
>>>> + =A0 =A0 =A0 =A0 =A0 =A0* no performance impact
>>>> + =A0 =A0 =A0 =A0 =A0 =A0*/
>>>> + =A0 =A0 =A0 =A0 =A0 if (pdata->clk_delay_sel =3D=3D 1) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp =3D readw(host->ioaddr +=
 SD_CLOCK_BURST_SIZE_SETUP);
>>>> +
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp &=3D ~(SDCLK_DELAY_MASK =
<< SDCLK_DELAY_SHIFT);
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp |=3D (pdata->clk_delay_c=
ycles & SDCLK_DELAY_MASK)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 << SDCLK_DEL=
AY_SHIFT;
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp &=3D ~(SDCLK_SEL_MASK <<=
 SDCLK_SEL_SHIFT);
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp |=3D (1 & SDCLK_SEL_MASK=
) << SDCLK_SEL_SHIFT;
>>>> +
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 writew(tmp, host->ioaddr + S=
D_CLOCK_BURST_SIZE_SETUP);
>>>> + =A0 =A0 =A0 =A0 =A0 }
>>>> +
>>>> + =A0 =A0 =A0 =A0 =A0 if (pdata->flags & PXA_FLAG_ENABLE_CLOCK_GAT=
ING) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp =3D readw(host->ioaddr +=
 SD_FIFO_PARAM);
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp &=3D ~CLK_GATE_SETTING_B=
ITS;
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 writew(tmp, host->ioaddr + S=
D_FIFO_PARAM);
>>>> + =A0 =A0 =A0 =A0 =A0 } else {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp =3D readw(host->ioaddr +=
 SD_FIFO_PARAM);
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp &=3D ~CLK_GATE_SETTING_B=
ITS;
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp |=3D CLK_GATE_SETTING_BI=
TS;
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 writew(tmp, host->ioaddr + S=
D_FIFO_PARAM);
>>>> + =A0 =A0 =A0 =A0 =A0 }
>>>> + =A0 }
>>>> +}
>>>> +
>>>> +static int pxav2_mmc_set_width(struct sdhci_host *host, int width=
)
>>>> +{
>>>> + =A0 u8 ctrl;
>>>> + =A0 u16 tmp;
>>>> +
>>>> + =A0 ctrl =3D readb(host->ioaddr + SDHCI_HOST_CONTROL);
>>>> + =A0 tmp =3D readw(host->ioaddr + SD_CE_ATA_2);
>>>> + =A0 if (width =3D=3D MMC_BUS_WIDTH_8) {
>>>> + =A0 =A0 =A0 =A0 =A0 ctrl &=3D ~SDHCI_CTRL_4BITBUS;
>>>> + =A0 =A0 =A0 =A0 =A0 tmp |=3D MMC_CARD | MMC_WIDTH;
>>>> + =A0 } else {
>>>> + =A0 =A0 =A0 =A0 =A0 tmp &=3D ~(MMC_CARD | MMC_WIDTH);
>>>> + =A0 =A0 =A0 =A0 =A0 if (width =3D=3D MMC_BUS_WIDTH_4)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl |=3D SDHCI_CTRL_4BITBUS=
;
>>>> + =A0 =A0 =A0 =A0 =A0 else
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl &=3D ~SDHCI_CTRL_4BITBU=
S;
>>>> + =A0 }
>>>> + =A0 writew(tmp, host->ioaddr + SD_CE_ATA_2);
>>>> + =A0 writeb(ctrl, host->ioaddr + SDHCI_HOST_CONTROL);
>>>> +
>>>> + =A0 return 0;
>>>> +}
>>>> +
>>>> +static unsigned int pxav2_get_ro(struct sdhci_host *host)
>>>> +{
>>>> + =A0 /* Micro SD does not support write-protect feature */
>>>> + =A0 return 0;
>>>> +}
>>>> +
>>>> +static u32 pxav2_get_max_clock(struct sdhci_host *host)
>>>> +{
>>>> + =A0 struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
>>>> +
>>>> + =A0 return clk_get_rate(pltfm_host->clk);
>>>> +}
>>>> +
>>>> +static struct sdhci_ops pxav2_sdhci_ops =3D {
>>>> + =A0 .get_ro =3D pxav2_get_ro,
>>>> + =A0 .get_max_clock =3D pxav2_get_max_clock,
>>>> + =A0 .platform_reset_exit =3D pxav2_set_private_registers,
>>>> + =A0 .platform_8bit_width =3D pxav2_mmc_set_width,
>>>> +};
>>>> +
>>>> +static int __devinit sdhci_pxav2_probe(struct platform_device *pd=
ev)
>>>> +{
>>>> + =A0 struct sdhci_pltfm_host *pltfm_host;
>>>> + =A0 struct sdhci_pxa_platdata *pdata =3D pdev->dev.platform_data=
;
>>>> + =A0 struct device *dev =3D &pdev->dev;
>>>> + =A0 struct sdhci_host *host =3D NULL;
>>>> + =A0 struct sdhci_pxa *pxa =3D NULL;
>>>> + =A0 int ret;
>>>> + =A0 struct clk *clk;
>>>> +
>>>> + =A0 pxa =3D kzalloc(sizeof(struct sdhci_pxa), GFP_KERNEL);
>>>> + =A0 if (!pxa)
>>>> + =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>>>> +
>>>> + =A0 host =3D sdhci_pltfm_init(pdev, NULL);
>>>> + =A0 if (IS_ERR(host)) {
>>>> + =A0 =A0 =A0 =A0 =A0 kfree(pxa);
>>>> + =A0 =A0 =A0 =A0 =A0 return PTR_ERR(host);
>>>> + =A0 }
>>>> + =A0 pltfm_host =3D sdhci_priv(host);
>>>> + =A0 pltfm_host->priv =3D pxa;
>>>> +
>>>> + =A0 clk =3D clk_get(dev, "PXA-SDHCLK");
>>>> + =A0 if (IS_ERR(clk)) {
>>>> + =A0 =A0 =A0 =A0 =A0 dev_err(dev, "failed to get io clock\n");
>>>> + =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(clk);
>>>> + =A0 =A0 =A0 =A0 =A0 goto err_clk_get;
>>>> + =A0 }
>>>> + =A0 pltfm_host->clk =3D clk;
>>>> + =A0 clk_enable(clk);
>>>> +
>>>> + =A0 host->quirks =3D SDHCI_QUIRK_BROKEN_ADMA
>>>> + =A0 =A0 =A0 =A0 =A0 | SDHCI_QUIRK_BROKEN_TIMEOUT_VAL
>>>> + =A0 =A0 =A0 =A0 =A0 | SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN;
>>>> +
>>>> + =A0 if (pdata) {
>>>> + =A0 =A0 =A0 =A0 =A0 if (pdata->flags & PXA_FLAG_CARD_PERMANENT) =
{
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* on-chip device */
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->quirks |=3D SDHCI_QUIR=
K_BROKEN_CARD_DETECTION;
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->mmc->caps |=3D MMC_CAP=
_NONREMOVABLE;
>>>> + =A0 =A0 =A0 =A0 =A0 }
>>>> +
>>>> + =A0 =A0 =A0 =A0 =A0 /* If slot design supports 8 bit data, indic=
ate this to MMC. */
>>>> + =A0 =A0 =A0 =A0 =A0 if (pdata->flags & PXA_FLAG_SD_8_BIT_CAPABLE=
_SLOT)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->mmc->caps |=3D MMC_CAP=
_8_BIT_DATA;
>>>> +
>>>> + =A0 =A0 =A0 =A0 =A0 if (pdata->quirks)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->quirks |=3D pdata->qui=
rks;
>>>> + =A0 =A0 =A0 =A0 =A0 if (pdata->host_caps)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->mmc->caps |=3D pdata->=
host_caps;
>>>> + =A0 =A0 =A0 =A0 =A0 if (pdata->pm_caps)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->mmc->pm_caps |=3D pdat=
a->pm_caps;
>>>> + =A0 }
>>>> +
>>>> + =A0 host->ops =3D &pxav2_sdhci_ops;
>>>> +
>>>> + =A0 ret =3D sdhci_add_host(host);
>>>> + =A0 if (ret) {
>>>> + =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to add host\n");
>>>> + =A0 =A0 =A0 =A0 =A0 goto err_add_host;
>>>> + =A0 }
>>>> +
>>>> + =A0 if (pdata && pdata->max_speed) {
>>>> + =A0 =A0 =A0 =A0 =A0 host->mmc->f_max =3D pdata->max_speed;
>>>> + =A0 =A0 =A0 =A0 =A0 if (!(host->mmc->f_max > 25000000))
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->mmc->caps &=3D ~(MMC_C=
AP_SD_HIGHSPEED |
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 MMC_CAP_MMC_HIGHSPEED);
>>>> + =A0 }
>>>
>>> This should be done before calling add_host. =A0Add the callback to=
 set f_max()
>>>
>>> https://patchwork.kernel.org/patch/742301/
This section is only for debug purpose, will be deleted as well as
max_speed, which are not must.
It may be confused to provide both get_f_max_clock and get_max_clock.

>>>
>>>
>>>
>>>
>>>> +
>>>> + =A0 platform_set_drvdata(pdev, host);
>>>> +
>>>>
>>>> + =A0 return 0;
>>>> +
>>>> +err_add_host:
>>>> + =A0 clk_disable(clk);
>>>> + =A0 clk_put(clk);
>>>> +err_clk_get:
>>>> + =A0 sdhci_pltfm_free(pdev);+ =A0 =A0 =A0 =A0kfree(pxa);
>>>> + =A0 return ret;
>>>> +}
>>>> +
>>>> +static int __devexit sdhci_pxav2_remove(struct platform_device *p=
dev)
>>>> +{
>>>> + =A0 struct sdhci_host *host =3D platform_get_drvdata(pdev);
>>>> + =A0 struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
>>>> + =A0 struct sdhci_pxa *pxa =3D pltfm_host->priv;
>>>> +
>>>> + =A0 sdhci_remove_host(host, 1);
>>>> +
>>>> + =A0 clk_disable(pltfm_host->clk);
>>>> + =A0 clk_put(pltfm_host->clk);
>>>> + =A0 sdhci_pltfm_free(pdev);
>>>> + =A0 kfree(pxa);
>>>> +
>>>> + =A0 platform_set_drvdata(pdev, NULL);
>>>> +
>>>> + =A0 return 0;
>>>> +}
>>>> +
>>>> +static struct platform_driver sdhci_pxav2_driver =3D {
>>>> + =A0 .driver =A0 =A0 =A0 =A0 =3D {
>>>> + =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "sdhci-pxav2",
>>>> + =A0 =A0 =A0 =A0 =A0 .owner =A0=3D THIS_MODULE,
>>>> + =A0 },
>>>> + =A0 .probe =A0 =A0 =A0 =A0 =A0=3D sdhci_pxav2_probe,
>>>> + =A0 .remove =A0 =A0 =A0 =A0 =3D __devexit_p(sdhci_pxav2_remove),
>>>> +#ifdef CONFIG_PM
>>>> + =A0 .suspend =A0 =A0 =A0 =A0=3D sdhci_pltfm_suspend,
>>>> + =A0 .resume =A0 =A0 =A0 =A0 =3D sdhci_pltfm_resume,
>>>> +#endif
>>>
>>> could you please post to mmc mailing list code that sets up sdhci-p=
xav2.
The test code on pxa910 and pxa921 are reusing Jun's patch.
Jun will update the resource name accordingly.

>>>
>>>> +};
>>>> +static int __init sdhci_pxav2_init(void)
>>>> +{
>>>> + =A0 return platform_driver_register(&sdhci_pxav2_driver);
>>>> +}
>>>> +
>>>> +static void __exit sdhci_pxav2_exit(void)
>>>> +{
>>>> + =A0 platform_driver_unregister(&sdhci_pxav2_driver);
>>>> +}
>>>> +
>>>> +module_init(sdhci_pxav2_init);
>>>> +module_exit(sdhci_pxav2_exit);
>>>> +
>>>> +MODULE_DESCRIPTION("SDHCI driver for pxav2");
>>>> +MODULE_AUTHOR("Marvell International Ltd.");
>>>> +MODULE_LICENSE("GPL v2");
>>>> +
>>>> --
>>>> 1.7.0.4
>>>>
>>>
>>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
