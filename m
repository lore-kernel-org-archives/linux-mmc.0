From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH] mmc: support sdhci-mmp2
Date: Mon, 30 May 2011 09:15:17 -0400
Message-ID: <BANLkTi=0VRXmqFrf-HuAoj4JAdg8KiF4qA@mail.gmail.com>
References: <1306156882-12124-1-git-send-email-zhangfei.gao@marvell.com>
	<F4CA7B04-7898-4C6A-814E-DE84588E3C94@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:41089 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753490Ab1E3NPS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 30 May 2011 09:15:18 -0400
Received: by vxi39 with SMTP id 39so2631032vxi.19
        for <linux-mmc@vger.kernel.org>; Mon, 30 May 2011 06:15:17 -0700 (PDT)
In-Reply-To: <F4CA7B04-7898-4C6A-814E-DE84588E3C94@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: Zhangfei Gao <zgao6@marvell.com>, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@fluxnic.net>, Wolfram Sang <w.sang@pengutronix.de>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jun Nie <njun@marvell.com>, Raymond Wu <xywu@marvell.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Mark Brown <mark.brown314@gmail.com>, Shawn Guo <shawn.guo@linaro.org>

On Sat, May 28, 2011 at 1:00 AM, Philip Rakity <prakity@marvell.com> wr=
ote:
>
> Hi Zhangfei,
>
>
> comments below. (based on V1 patch but change to V2 affect (3<<1) typ=
o.
>
> Philip and Mark.

Thanks for review.
>
>
> On May 23, 2011, at 6:21 AM, Zhangfei Gao wrote:
>
>> =A0 =A0 =A0 =A0Delete sdhci-pxa.c and replace with sdhci-mmp2.c spec=
ificlly for mmp2
>>
>> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
>> ---
>> arch/arm/plat-pxa/include/plat/sdhci.h | =A0 43 ++++-
>> drivers/mmc/host/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A09 +-
>> drivers/mmc/host/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02 +-
>> drivers/mmc/host/sdhci-mmp2.c =A0 =A0 =A0 =A0 =A0| =A0304 ++++++++++=
++++++++++++++++++++++
>> drivers/mmc/host/sdhci-pxa.c =A0 =A0 =A0 =A0 =A0 | =A0303 ----------=
---------------------
>> 5 files changed, 349 insertions(+), 312 deletions(-)
>> create mode 100644 drivers/mmc/host/sdhci-mmp2.c
>> delete mode 100644 drivers/mmc/host/sdhci-pxa.c
>>
>> diff --git a/arch/arm/plat-pxa/include/plat/sdhci.h b/arch/arm/plat-=
pxa/include/plat/sdhci.h
>> index 1ab332e..92becc0 100644
>> --- a/arch/arm/plat-pxa/include/plat/sdhci.h
>> +++ b/arch/arm/plat-pxa/include/plat/sdhci.h
>> @@ -13,23 +13,58 @@
>> #ifndef __PLAT_PXA_SDHCI_H
>> #define __PLAT_PXA_SDHCI_H
>>
>> +#include <linux/mmc/sdhci.h>
>> +#include <linux/platform_device.h>
>> +
>> /* pxa specific flag */
>> /* Require clock free running */
>> #define PXA_FLAG_DISABLE_CLOCK_GATING (1<<0)
>> -
>> +/* card alwayes wired to host, like on-chip emmc */
>> +#define PXA_FLAG_CARD_PERMANENT =A0 =A0 =A0 =A0(1<<1)
>> /* Board design supports 8-bit data on SD/SDIO BUS */
>> #define PXA_FLAG_SD_8_BIT_CAPABLE_SLOT (1<<2)
>> +/* card not use wp, such as micro sd card */
>> +#define PXA_FLAG_CARD_NO_WP =A0 =A0(3<<1)
>
> do you mean (1<<3) ?
already update in v2.
>>
>> +struct sdhci_pxa;
>> /*
>> =A0* struct pxa_sdhci_platdata() - Platform device data for PXA SDHC=
I
>> - * @max_speed: the maximum speed supported
>> - * @quirks: quirks of specific device
>> =A0* @flags: flags for platform requirement
>> + * @clk_delay_cycles:
>> + * =A0 =A0 mmp2: each step is roughly 100ps, 5bits width
>> + * =A0 =A0 pxa910: each step is 1ns, 4bits width
>> + * @clk_delay_sel: select clk_delay, used on pxa910
>> + * =A0 =A0 0: choose feedback clk
>> + * =A0 =A0 1: choose feedback clk + delay value
>> + * =A0 =A0 2: choose internal clk
>> + * @ext_cd_gpio: gpio pin used for external CD line
>> + * @ext_cd_gpio_invert: invert values for external CD gpio line
>> + * @clk_delay_enable: enable clk_delay or not, used on pxa910
>> + * @max_speed: the maximum speed supported
>> + * @host_caps: Standard MMC host capabilities bit field.
>> + * @quirks: quirks of platfrom
>> + * @pm_caps: pm_caps of platfrom
>> =A0*/
>> struct sdhci_pxa_platdata {
>> + =A0 =A0 =A0 unsigned int =A0 =A0flags;
>> + =A0 =A0 =A0 unsigned int =A0 =A0clk_delay_cycles;
>> + =A0 =A0 =A0 unsigned int =A0 =A0clk_delay_sel;
>> + =A0 =A0 =A0 unsigned int =A0 =A0ext_cd_gpio;
>> + =A0 =A0 =A0 bool =A0 =A0 =A0 =A0 =A0 =A0ext_cd_gpio_invert;
>> + =A0 =A0 =A0 bool =A0 =A0 =A0 =A0 =A0 =A0clk_delay_enable;
>
> move up 2 lines to be next to other clk_ values.
fine.
>
>> =A0 =A0 =A0 =A0unsigned int =A0 =A0max_speed;
>> + =A0 =A0 =A0 unsigned int =A0 =A0host_caps;
>> =A0 =A0 =A0 =A0unsigned int =A0 =A0quirks;
>> - =A0 =A0 =A0 unsigned int =A0 =A0flags;
>> + =A0 =A0 =A0 unsigned int =A0 =A0pm_caps;
>> +};
>> +
>> +struct sdhci_pxa {
>> + =A0 =A0 =A0 struct sdhci_pxa_platdata =A0 =A0 =A0 *pdata;
>> + =A0 =A0 =A0 struct clk =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
*clk;
>> + =A0 =A0 =A0 struct sdhci_ops =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*ops;
>> +
>> + =A0 =A0 =A0 u8 =A0 =A0 =A0clk_enable;
>> + =A0 =A0 =A0 u8 =A0 =A0 =A0power_mode;
>> };
>>
>> #endif /* __PLAT_PXA_SDHCI_H */
>> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
>> index 862235e..1e520e3 100644
>> --- a/drivers/mmc/host/Kconfig
>> +++ b/drivers/mmc/host/Kconfig
>> @@ -181,14 +181,15 @@ config MMC_SDHCI_S3C
>>
>> =A0 =A0 =A0 =A0 =A0If unsure, say N.
>>
>> -config MMC_SDHCI_PXA
>> - =A0 =A0 =A0 tristate "Marvell PXA168/PXA910/MMP2 SD Host Controlle=
r support"
>> +config MMC_SDHCI_MMP2
>> + =A0 =A0 =A0 tristate "Marvell MMP2 SD Host Controller support"
>> =A0 =A0 =A0 =A0depends on ARCH_PXA || ARCH_MMP
>> =A0 =A0 =A0 =A0select MMC_SDHCI
>> + =A0 =A0 =A0 select MMC_SDHCI_PLTFM
>> =A0 =A0 =A0 =A0select MMC_SDHCI_IO_ACCESSORS
>> =A0 =A0 =A0 =A0help
>> - =A0 =A0 =A0 =A0 This selects the Marvell(R) PXA168/PXA910/MMP2 SD =
Host Controller.
>> - =A0 =A0 =A0 =A0 If you have a PXA168/PXA910/MMP2 platform with SD =
Host Controller
>> + =A0 =A0 =A0 =A0 This selects the Marvell(R) MMP2 SD Host Controlle=
r.
>> + =A0 =A0 =A0 =A0 If you have a MMP2 platform with SD Host Controlle=
r
>> =A0 =A0 =A0 =A0 =A0and a card slot, say Y or M here.
>>
>
> This needs to be specific to MMP2 =A0-- depends on CPU_MMP2 ?
> code can be selected for pxa9xx and pxa168 where this code cannot wor=
k.
>
> deleting MMC_SDHCI_PXA breaks existing configs since it is renamed.
> would it better to leave this and mark it as obsolete but let it stil=
l compile
> mmp2 sd code?
>
> In some sense all of this is backwards. =A0Once the SoC is known (pxa=
910 or mmp2),
> it knows that SDHCI controller it supports. =A0It should set a config=
 option
> like USES_MRVL_V3_SD_CONTROLLER. =A0The Kconfig entry in mmc/host sho=
uld
> depend on THAT selection to allow the user to enable the SD option.
>
> MMC_SDHCI_IO_ACCESSORS not needed
>
Will take Arnd advice, remove dependency and only select MMC_SDHCI and
MMC_SDHCI_PLTFM
>
>>
>
>
>> =A0 =A0 =A0 =A0 =A0If unsure, say N.
>> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
>> index 4933004..f8650e0 100644
>> --- a/drivers/mmc/host/Makefile
>> +++ b/drivers/mmc/host/Makefile
>> @@ -9,7 +9,7 @@ obj-$(CONFIG_MMC_MXC) =A0 =A0 =A0 =A0 =A0 +=3D mxcmm=
c.o
>> obj-$(CONFIG_MMC_MXS) =A0 =A0 =A0 =A0 =A0+=3D mxs-mmc.o
>> obj-$(CONFIG_MMC_SDHCI) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D sdhci.o
>> obj-$(CONFIG_MMC_SDHCI_PCI) =A0 =A0+=3D sdhci-pci.o
>> -obj-$(CONFIG_MMC_SDHCI_PXA) =A0 =A0+=3D sdhci-pxa.o
>> +obj-$(CONFIG_MMC_SDHCI_MMP2) =A0 +=3D sdhci-mmp2.o
>> obj-$(CONFIG_MMC_SDHCI_S3C) =A0 =A0+=3D sdhci-s3c.o
>> obj-$(CONFIG_MMC_SDHCI_SPEAR) =A0+=3D sdhci-spear.o
>> obj-$(CONFIG_MMC_WBSD) =A0 =A0 =A0 =A0 +=3D wbsd.o
>> diff --git a/drivers/mmc/host/sdhci-mmp2.c b/drivers/mmc/host/sdhci-=
mmp2.c
>> new file mode 100644
>> index 0000000..566d525
>> --- /dev/null
>> +++ b/drivers/mmc/host/sdhci-mmp2.c
>
> It is probably better to NOT name the file sdhci-mmp2.c but
> something like sdchi-pxaV3.c since other SoC's may use this controlle=
r.
fine
>
>> @@ -0,0 +1,304 @@
>> +/*
>> + * Copyright (C) 2010 Marvell International Ltd.
>> + *
>> + * This software is licensed under the terms of the GNU General Pub=
lic
>> + * License version 2, as published by the Free Software Foundation,=
 and
>> + * may be copied, distributed, and modified under those terms.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the
>> + * GNU General Public License for more details.
>> + *
>> + */
>> +
>> +#include <linux/err.h>
>> +#include <linux/init.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/clk.h>
>> +#include <linux/io.h>
>> +#include <linux/gpio.h>
>> +#include <linux/mmc/card.h>
>> +#include <linux/mmc/host.h>
>> +#include <plat/sdhci.h>
>> +#include <linux/slab.h>
>> +#include "sdhci.h"
>> +#include "sdhci-pltfm.h"
>> +
>> +#define MMP2_SD_FIFO_PARAM =A0 =A0 =A0 =A0 =A0 =A0 0x104
>> +#define MMP2_DIS_PAD_SD_CLK_GATE =A0 =A0 =A0 0x400
>> +
>> +#define MMP2_SD_CLOCK_AND_BURST_SIZE_SETUP =A0 =A0 =A0 =A0 =A0 =A0 =
0x10A
>> +#define MMP2_SDCLK_SEL 0x100
>> +#define MMP2_SDCLK_DELAY_SHIFT 9
>> +#define MMP2_SDCLK_DELAY_MASK =A00x1f
>> +
>> +#define SD_CFG_FIFO_PARAM =A0 =A0 =A0 0x100
>> +#define SDCFG_GEN_PAD_CLK_ON =A0 (1<<6)
>> +#define SDCFG_GEN_PAD_CLK_CNT_MASK =A0 =A0 0xFF
>> +#define SDCFG_GEN_PAD_CLK_CNT_SHIFT =A0 =A024
>> +
>> +#define SD_SPI_MODE =A0 =A0 =A0 =A0 =A00x108
>> +#define SD_CE_ATA_1 =A0 =A0 =A0 =A0 =A00x10C
>> +
>> +#define SD_CE_ATA_2 =A0 =A0 =A0 =A0 =A00x10E
>> +#define SDCE_MISC_INT =A0 =A0 =A0 =A0 =A0(1<<2)
>> +#define SDCE_MISC_INT_EN =A0 =A0 =A0 (1<<1)
>> +
>> +static void mmp2_soc_set_timing(struct sdhci_host *host,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct=
 sdhci_pxa_platdata *pdata)
>> +{
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* tune timing of read data/command when crc error h=
appen
>> + =A0 =A0 =A0 =A0* no performance impact
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 if (pdata && 0 !=3D pdata->clk_delay_cycles) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u16 tmp;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp =3D readw(host->ioaddr + MMP2_SD_C=
LOCK_AND_BURST_SIZE_SETUP);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp |=3D (pdata->clk_delay_cycles & MM=
P2_SDCLK_DELAY_MASK)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 << MMP2_SDCLK_DELAY_SHIFT;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp |=3D MMP2_SDCLK_SEL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 writew(tmp, host->ioaddr + MMP2_SD_CLO=
CK_AND_BURST_SIZE_SETUP);
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* disable clock gating per some cards requirement
>> + =A0 =A0 =A0 =A0*/
>> +
>> + =A0 =A0 =A0 if (pdata && pdata->flags & PXA_FLAG_DISABLE_CLOCK_GAT=
ING) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 tmp =3D 0;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp =3D readl(host->ioaddr + MMP2_SD_F=
IFO_PARAM);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp |=3D MMP2_DIS_PAD_SD_CLK_GATE;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 writel(tmp, host->ioaddr + MMP2_SD_FIF=
O_PARAM);
>> + =A0 =A0 =A0 }
>> +}
>
> One cannot know what card if being inserted or removed by a user
> so the safest choice is to leave clock gating OFF by default.
>
> PXA_FLAG_DISABLE_CLOCK_GATING should be renamed
> to
> PXA_FLAG_ENABLE_CLOCK_GATING.
>
> If you have a card which is permanent then the flags should be used
> to ENABLE clock gating. =A0Otherwise clock gating should be left OFF =
by default.
Still in check.

>
> The above code should be called via the call back added to sdhci.c fo=
r
> reset processing at the end of a reset and tested against a RESET_ALL=
=2E
> The RESET_ALL will reset the private register space.
OK, it also workable to put in platform_reset_exit.
>
>
>> +
>> +static unsigned int mmp2_get_ro(struct sdhci_host *host)
>> +{
>> + =A0 =A0 =A0 /* Micro SD does not support write-protect feature */
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> +static void mmp2_set_clock(struct sdhci_host *host, unsigned int cl=
ock)
>> +{
>> + =A0 =A0 =A0 struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(hos=
t);
>> + =A0 =A0 =A0 struct sdhci_pxa *pxa =3D pltfm_host->priv;
>> +
>> + =A0 =A0 =A0 if (clock)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmp2_soc_set_timing(host, pxa->pdata);
>> +}
>> +
>
>
> This code should be called via reset callback and mmp2_soc_set_timing=
 added here
> and prototype changed to
> +static void mmp2_set_private_registers(struct sdhci_host *host, unsi=
gned int reset_flag)
>
> =A0and used as
>
> =A0 =A0 =A0 =A0if (reset_flag =3D=3D RESET_ALL)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmp2_soc_set_timing(host, pxa->pdata);
> =A0 =A0 =A0 =A0}
>
>
>> +static int mmp2_set_uhs_signaling(struct sdhci_host *host, unsigned=
 int uhs)
>> +{
>> + =A0 =A0 =A0 u16 ctrl_2;
>> +
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* Set V18_EN -- UHS modes do not work without this.
>> + =A0 =A0 =A0 =A0* does not change signaling voltage
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 ctrl_2 =3D sdhci_readw(host, SDHCI_HOST_CONTROL2);
>> +
>> + =A0 =A0 =A0 /* Select Bus Speed Mode for host */
>> + =A0 =A0 =A0 ctrl_2 &=3D ~SDHCI_CTRL_UHS_MASK;
>> + =A0 =A0 =A0 switch (uhs) {
>> + =A0 =A0 =A0 case MMC_TIMING_UHS_SDR12:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl_2 |=3D SDHCI_CTRL_UHS_SDR12;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 case MMC_TIMING_UHS_SDR25:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl_2 |=3D SDHCI_CTRL_UHS_SDR25;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 case MMC_TIMING_UHS_SDR50:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl_2 |=3D SDHCI_CTRL_UHS_SDR50 | SDH=
CI_CTRL_VDD_180;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 case MMC_TIMING_UHS_SDR104:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl_2 |=3D SDHCI_CTRL_UHS_SDR104 | SD=
HCI_CTRL_VDD_180;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 case MMC_TIMING_UHS_DDR50:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl_2 |=3D SDHCI_CTRL_UHS_DDR50 | SDH=
CI_CTRL_VDD_180;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
>> + =A0 =A0 =A0 dev_dbg(mmc_dev(host->mmc),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%s:%s uhs =3D %d, ctrl_2 =3D %04X\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, mmc_hostname(host->mmc), uhs=
, ctrl_2);
>> +
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> +static int __devinit sdhci_mmp2_probe(struct platform_device *pdev)
>> +{
>> + =A0 =A0 =A0 struct sdhci_pltfm_host *pltfm_host;
>> + =A0 =A0 =A0 struct sdhci_pxa_platdata *pdata =3D pdev->dev.platfor=
m_data;
>> + =A0 =A0 =A0 struct device *dev =3D &pdev->dev;
>> + =A0 =A0 =A0 struct sdhci_host *host =3D NULL;
>> + =A0 =A0 =A0 struct sdhci_pxa *pxa =3D NULL;
>> + =A0 =A0 =A0 int ret;
>> + =A0 =A0 =A0 struct clk *clk;
>> +
>> + =A0 =A0 =A0 pxa =3D kzalloc(sizeof(struct sdhci_pxa), GFP_KERNEL);
>> + =A0 =A0 =A0 if (!pxa) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 pxa->ops =3D kzalloc(sizeof(struct sdhci_ops), GFP_KER=
NEL);
> why is =A0pxa->ops needed ?
>
>> + =A0 =A0 =A0 if (!pxa->ops) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 pxa->pdata =3D pdata;
>> +
>> + =A0 =A0 =A0 clk =3D clk_get(dev, "PXA-SDHCLK");
>> + =A0 =A0 =A0 if (IS_ERR(clk)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "failed to get io clock\n=
");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(clk);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 pxa->clk =3D clk;
>> + =A0 =A0 =A0 clk_enable(clk);
>> +
>> + =A0 =A0 =A0 host =3D sdhci_pltfm_init(pdev, NULL);
>> + =A0 =A0 =A0 if (IS_ERR(host))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PTR_ERR(host);
>> +
>> + =A0 =A0 =A0 pltfm_host =3D sdhci_priv(host);
>> + =A0 =A0 =A0 pltfm_host->priv =3D pxa;
>> +
>> + =A0 =A0 =A0 host->quirks =3D SDHCI_QUIRK_BROKEN_ADMA
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 | SDHCI_QUIRK_BROKEN_TIMEOUT_VAL

>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 | SDHCI_QUIRK_32BIT_DMA_ADDR
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 | SDHCI_QUIRK_32BIT_DMA_SIZE
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 | SDHCI_QUIRK_32BIT_ADMA_SIZE
my understand is mmp2 do not have such limitation?

>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 | SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC;
This quirk also not must?
>> +
>> + =A0 =A0 =A0 /* enable 1/8V DDR capable */
>> + =A0 =A0 =A0 host->mmc->caps |=3D MMC_CAP_1_8V_DDR;
>
>
> missing cap for bus width testing CMD19 works on MMP2
Will do the test of CMD19.

> ADMA is fine for SD/eMMC -- SDMA is best for SDIO. =A0SDHCI_QUIRK_BRO=
KEN_ADMA
> is best passed via pdata->quirks.
>
>
>> +
>> + =A0 =A0 =A0 if (pdata && pdata->flags & PXA_FLAG_CARD_PERMANENT) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* on-chip device */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->quirks |=3D SDHCI_QUIRK_BROKEN_C=
ARD_DETECTION;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->mmc->caps |=3D MMC_CAP_NONREMOVA=
BLE;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 /* If slot design supports 8 bit data, indicate this t=
o MMC. */
>> + =A0 =A0 =A0 if (pdata->flags & PXA_FLAG_SD_8_BIT_CAPABLE_SLOT)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->mmc->caps |=3D MMC_CAP_8_BIT_DAT=
A;
>> +
>> + =A0 =A0 =A0 if (pdata && pdata->quirks)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->quirks |=3D pdata->quirks;
>> + =A0 =A0 =A0 if (pdata && pdata->host_caps)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->mmc->caps |=3D pdata->host_caps;
>> + =A0 =A0 =A0 if (pdata && pdata->pm_caps)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->mmc->pm_caps |=3D pdata->pm_caps=
;
>> +
>> + =A0 =A0 =A0 pxa->ops->set_clock =3D mmp2_set_clock;
>
> see comment about using reset callback instead of set_clock.
fine.
>
>> + =A0 =A0 =A0 pxa->ops->set_uhs_signaling =3D mmp2_set_uhs_signaling=
;
>> + =A0 =A0 =A0 if (pdata && pdata->flags & PXA_FLAG_CARD_NO_WP)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pxa->ops->get_ro =3D mmp2_get_ro;
>
> need 74 clock code --- I pasted it at the end the code. =A0The reason=
 the code is
> needed is that SOME eMMC chips require 74 clocks. =A0The chips you ha=
ve tested with
> do not need the clocks but JEDEC =A0Spec JESD84-A441-1 requires the c=
locks be
> generated.
>
>
>> +
>> + =A0 =A0 =A0 host->ops =3D pxa->ops;
>> +
>> + =A0 =A0 =A0 ret =3D sdhci_add_host(host);
>> + =A0 =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to add hos=
t\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 platform_set_drvdata(pdev, host);
>> +
>> + =A0 =A0 =A0 return 0;
>> +out:
>> + =A0 =A0 =A0 if (host) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(pltfm_host->clk);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_put(pltfm_host->clk);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_pltfm_free(pdev);
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 if (pxa)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(pxa->ops);
>> + =A0 =A0 =A0 kfree(pxa);
>> +
>> + =A0 =A0 =A0 return ret;
>> +}
>> +
>> +static int __devexit sdhci_mmp2_remove(struct platform_device *pdev=
)
>> +{
>> + =A0 =A0 =A0 struct sdhci_pxa_platdata *pdata =3D pdev->dev.platfor=
m_data;
>> + =A0 =A0 =A0 struct sdhci_host *host =3D platform_get_drvdata(pdev)=
;
>> + =A0 =A0 =A0 struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(hos=
t);
>> + =A0 =A0 =A0 struct sdhci_pxa *pxa =3D pltfm_host->priv;
>> + =A0 =A0 =A0 int dead =3D 0;
>> + =A0 =A0 =A0 u32 scratch;
>> +
>> + =A0 =A0 =A0 if (host) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 scratch =3D readl(host->ioaddr + SDHCI=
_INT_STATUS);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (scratch =3D=3D (u32)-1)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dead =3D 1;
>
> not sure that this is the correct test -- will masked interrupts show
> up as set in the INT_STATUS register ? =A0from the code in sdhci.c an=
d from
> my testing I have never seen -1 set.
>
> The test in sdhci.c is for 0x0 or for 0xffffffff is for a
> shared interrupt line to know if the interrupt is for this controller=
=2E
(u32)-1 is same as 0xffffffff
>
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_remove_host(host, dead);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(pxa->clk);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_put(pxa->clk);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_pltfm_free(pdev);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 platform_set_drvdata(pdev, NULL);
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 if (pxa)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(pxa->ops);
>> + =A0 =A0 =A0 kfree(pxa);
>> +
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> +#ifdef CONFIG_PM
>> +static int sdhci_mmp2_suspend(struct platform_device *dev, pm_messa=
ge_t state)
>> +{
>> + =A0 =A0 =A0 struct sdhci_host *host =3D platform_get_drvdata(dev);
>> +
>> + =A0 =A0 =A0 return sdhci_suspend_host(host, state);
>> +}
>> +
>> +static int sdhci_mmp2_resume(struct platform_device *dev)
>> +{
>> + =A0 =A0 =A0 struct sdhci_host *host =3D platform_get_drvdata(dev);
>> +
>> + =A0 =A0 =A0 return sdhci_resume_host(host);
>> +}
>> +#else
>> +#define sdhci_mmp2_suspend =A0 =A0 NULL
>> +#define sdhci_mmp2_resume =A0 =A0 =A0NULL
>> +#endif
>> +
>> +
>> +static struct platform_driver sdhci_mmp2_driver =3D {
>> + =A0 =A0 =A0 .driver =A0 =A0 =A0 =A0 =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "sdhci-mmp2",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0=3D THIS_MODULE,
>> + =A0 =A0 =A0 },
>> + =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D sdhci_mmp2_probe,
>> + =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D __devexit_p(sdhci_mmp2_rem=
ove),
>> +#ifdef CONFIG_PM
>> + =A0 =A0 =A0 .suspend =A0 =A0 =A0 =A0=3D sdhci_mmp2_suspend,
>> + =A0 =A0 =A0 .resume =A0 =A0 =A0 =A0 =3D sdhci_mmp2_resume,
>> +#endif
>> +};
>> +static int __init sdhci_mmp2_init(void)
>> +{
>> + =A0 =A0 =A0 return platform_driver_register(&sdhci_mmp2_driver);
>> +}
>> +
>> +static void __exit sdhci_mmp2_exit(void)
>> +{
>> + =A0 =A0 =A0 platform_driver_unregister(&sdhci_mmp2_driver);
>> +}
>> +
>> +module_init(sdhci_mmp2_init);
>> +module_exit(sdhci_mmp2_exit);
>> +
>> +MODULE_DESCRIPTION("SDHCI driver for mmp2");
>> +MODULE_AUTHOR("Marvell International Ltd.");
>> +MODULE_LICENSE("GPL v2");
>> +
>> diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-p=
xa.c
>> deleted file mode 100644
>> index 089c9a6..0000000
>> --- a/drivers/mmc/host/sdhci-pxa.c
>> +++ /dev/null
>> @@ -1,303 +0,0 @@
>> -/* linux/drivers/mmc/host/sdhci-pxa.c
>> - *
>> - * Copyright (C) 2010 Marvell International Ltd.
>> - * =A0 =A0 =A0 =A0 =A0 =A0 Zhangfei Gao <zhangfei.gao@marvell.com>
>> - * =A0 =A0 =A0 =A0 =A0 =A0 Kevin Wang <dwang4@marvell.com>
>> - * =A0 =A0 =A0 =A0 =A0 =A0 Mingwei Wang <mwwang@marvell.com>
>> - * =A0 =A0 =A0 =A0 =A0 =A0 Philip Rakity <prakity@marvell.com>
>> - * =A0 =A0 =A0 =A0 =A0 =A0 Mark Brown <markb@marvell.com>
>> - *
>
> Keep the authors. =A0They all contributed to the code.
fine
>
>> - * This program is free software; you can redistribute it and/or mo=
dify
>> - * it under the terms of the GNU General Public License version 2 a=
s
>> - * published by the Free Software Foundation.
>> - */
>> -
>> -/* Supports:
>> - * SDHCI support for MMP2/PXA910/PXA168
>> - *
>> - * Refer to sdhci-s3c.c.
>> - */
>> -
>> -#include <linux/delay.h>
>> -#include <linux/platform_device.h>
>> -#include <linux/mmc/host.h>
>> -#include <linux/clk.h>
>> -#include <linux/io.h>
>> -#include <linux/err.h>
>> -#include <plat/sdhci.h>
>> -#include "sdhci.h"
>> -
>> -#define DRIVER_NAME =A0 =A0"sdhci-pxa"
>> -
>> -#define SD_FIFO_PARAM =A0 =A0 =A0 =A0 =A00x104
>> -#define DIS_PAD_SD_CLK_GATE =A0 =A00x400
>> -
>> -struct sdhci_pxa {
>> - =A0 =A0 =A0 struct sdhci_host =A0 =A0 =A0 =A0 =A0 =A0 =A0 *host;
>> - =A0 =A0 =A0 struct sdhci_pxa_platdata =A0 =A0 =A0 *pdata;
>> - =A0 =A0 =A0 struct clk =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
*clk;
>> - =A0 =A0 =A0 struct resource =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *res;
>> -
>> - =A0 =A0 =A0 u8 clk_enable;
>> -};
>> -
>> -/******************************************************************=
***********\
>> - * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 *
>> - * SDHCI core callbacks =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*
>> - * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 *
>> -\******************************************************************=
***********/
>> -static void set_clock(struct sdhci_host *host, unsigned int clock)
>> -{
>> - =A0 =A0 =A0 struct sdhci_pxa *pxa =3D sdhci_priv(host);
>> - =A0 =A0 =A0 u32 tmp =3D 0;
>> -
>> - =A0 =A0 =A0 if (clock =3D=3D 0) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pxa->clk_enable) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(pxa->clk);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pxa->clk_enable =3D 0;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> - =A0 =A0 =A0 } else {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (0 =3D=3D pxa->clk_enable) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pxa->pdata->flags =
& PXA_FLAG_DISABLE_CLOCK_GATING) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp =3D=
 readl(host->ioaddr + SD_FIFO_PARAM);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp |=3D=
 DIS_PAD_SD_CLK_GATE;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 writel=
(tmp, host->ioaddr + SD_FIFO_PARAM);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_enable(pxa->clk);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pxa->clk_enable =3D 1;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> - =A0 =A0 =A0 }
>> -}
>> -
>> -static int set_uhs_signaling(struct sdhci_host *host, unsigned int =
uhs)
>> -{
>> - =A0 =A0 =A0 u16 ctrl_2;
>> -
>> - =A0 =A0 =A0 /*
>> - =A0 =A0 =A0 =A0* Set V18_EN -- UHS modes do not work without this.
>> - =A0 =A0 =A0 =A0* does not change signaling voltage
>> - =A0 =A0 =A0 =A0*/
>> - =A0 =A0 =A0 ctrl_2 =3D sdhci_readw(host, SDHCI_HOST_CONTROL2);
>> -
>> - =A0 =A0 =A0 /* Select Bus Speed Mode for host */
>> - =A0 =A0 =A0 ctrl_2 &=3D ~SDHCI_CTRL_UHS_MASK;
>> - =A0 =A0 =A0 switch (uhs) {
>> - =A0 =A0 =A0 case MMC_TIMING_UHS_SDR12:
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl_2 |=3D SDHCI_CTRL_UHS_SDR12;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> - =A0 =A0 =A0 case MMC_TIMING_UHS_SDR25:
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl_2 |=3D SDHCI_CTRL_UHS_SDR25;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> - =A0 =A0 =A0 case MMC_TIMING_UHS_SDR50:
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl_2 |=3D SDHCI_CTRL_UHS_SDR50 | SDH=
CI_CTRL_VDD_180;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> - =A0 =A0 =A0 case MMC_TIMING_UHS_SDR104:
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl_2 |=3D SDHCI_CTRL_UHS_SDR104 | SD=
HCI_CTRL_VDD_180;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> - =A0 =A0 =A0 case MMC_TIMING_UHS_DDR50:
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl_2 |=3D SDHCI_CTRL_UHS_DDR50 | SDH=
CI_CTRL_VDD_180;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> - =A0 =A0 =A0 }
>> -
>> - =A0 =A0 =A0 sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
>> - =A0 =A0 =A0 pr_debug("%s:%s uhs =3D %d, ctrl_2 =3D %04X\n",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, mmc_hostname(host->mmc), uhs=
, ctrl_2);
>> -
>> - =A0 =A0 =A0 return 0;
>> -}
>> -
>> -static struct sdhci_ops sdhci_pxa_ops =3D {
>> - =A0 =A0 =A0 .set_uhs_signaling =3D set_uhs_signaling,
>> - =A0 =A0 =A0 .set_clock =3D set_clock,
>> -};
>> -
>> -/******************************************************************=
***********\
>> - * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 *
>> - * Device probing/removal =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*
>> - * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 *
>> -\******************************************************************=
***********/
>> -
>> -static int __devinit sdhci_pxa_probe(struct platform_device *pdev)
>> -{
>> - =A0 =A0 =A0 struct sdhci_pxa_platdata *pdata =3D pdev->dev.platfor=
m_data;
>> - =A0 =A0 =A0 struct device *dev =3D &pdev->dev;
>> - =A0 =A0 =A0 struct sdhci_host *host =3D NULL;
>> - =A0 =A0 =A0 struct resource *iomem =3D NULL;
>> - =A0 =A0 =A0 struct sdhci_pxa *pxa =3D NULL;
>> - =A0 =A0 =A0 int ret, irq;
>> -
>> - =A0 =A0 =A0 irq =3D platform_get_irq(pdev, 0);
>> - =A0 =A0 =A0 if (irq < 0) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "no irq specified\n");
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return irq;
>> - =A0 =A0 =A0 }
>> -
>> - =A0 =A0 =A0 iomem =3D platform_get_resource(pdev, IORESOURCE_MEM, =
0);
>> - =A0 =A0 =A0 if (!iomem) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "no memory specified\n");
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOENT;
>> - =A0 =A0 =A0 }
>> -
>> - =A0 =A0 =A0 host =3D sdhci_alloc_host(&pdev->dev, sizeof(struct sd=
hci_pxa));
>> - =A0 =A0 =A0 if (IS_ERR(host)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "failed to alloc host\n")=
;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PTR_ERR(host);
>> - =A0 =A0 =A0 }
>> -
>> - =A0 =A0 =A0 pxa =3D sdhci_priv(host);
>> - =A0 =A0 =A0 pxa->host =3D host;
>> - =A0 =A0 =A0 pxa->pdata =3D pdata;
>> - =A0 =A0 =A0 pxa->clk_enable =3D 0;
>> -
>> - =A0 =A0 =A0 pxa->clk =3D clk_get(dev, "PXA-SDHCLK");
>> - =A0 =A0 =A0 if (IS_ERR(pxa->clk)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "failed to get io clock\n=
");
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(pxa->clk);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> - =A0 =A0 =A0 }
>> -
>> - =A0 =A0 =A0 pxa->res =3D request_mem_region(iomem->start, resource=
_size(iomem),
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 mmc_hostname(host->mmc));
>> - =A0 =A0 =A0 if (!pxa->res) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "cannot request re=
gion\n");
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EBUSY;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> - =A0 =A0 =A0 }
>> -
>> - =A0 =A0 =A0 host->ioaddr =3D ioremap(iomem->start, resource_size(i=
omem));
>> - =A0 =A0 =A0 if (!host->ioaddr) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to remap r=
egisters\n");
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> - =A0 =A0 =A0 }
>> -
>> - =A0 =A0 =A0 host->hw_name =3D "MMC";
>> - =A0 =A0 =A0 host->ops =3D &sdhci_pxa_ops;
>> - =A0 =A0 =A0 host->irq =3D irq;
>> - =A0 =A0 =A0 host->quirks =3D SDHCI_QUIRK_BROKEN_ADMA
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 | SDHCI_QUIRK_BROKEN_TIMEOUT_VAL
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 | SDHCI_QUIRK_32BIT_DMA_ADDR
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 | SDHCI_QUIRK_32BIT_DMA_SIZE
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 | SDHCI_QUIRK_32BIT_ADMA_SIZE
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 | SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC;
>> -
>> - =A0 =A0 =A0 if (pdata->quirks)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->quirks |=3D pdata->quirks;
>> -
>> - =A0 =A0 =A0 /* enable 1/8V DDR capable */
>> - =A0 =A0 =A0 host->mmc->caps |=3D MMC_CAP_1_8V_DDR;
>> -
>> - =A0 =A0 =A0 /* If slot design supports 8 bit data, indicate this t=
o MMC. */
>> - =A0 =A0 =A0 if (pdata->flags & PXA_FLAG_SD_8_BIT_CAPABLE_SLOT)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->mmc->caps |=3D MMC_CAP_8_BIT_DAT=
A;
>> -
>> - =A0 =A0 =A0 ret =3D sdhci_add_host(host);
>> - =A0 =A0 =A0 if (ret) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to add hos=
t\n");
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> - =A0 =A0 =A0 }
>> -
>> - =A0 =A0 =A0 if (pxa->pdata->max_speed)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->mmc->f_max =3D pxa->pdata->max_s=
peed;
>> -
>> - =A0 =A0 =A0 platform_set_drvdata(pdev, host);
>> -
>> - =A0 =A0 =A0 return 0;
>> -out:
>> - =A0 =A0 =A0 if (host) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_put(pxa->clk);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->ioaddr)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 iounmap(host->ioaddr);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pxa->res)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 release_mem_region(pxa=
->res->start,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0resource_size(pxa->res));
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_free_host(host);
>> - =A0 =A0 =A0 }
>> -
>> - =A0 =A0 =A0 return ret;
>> -}
>> -
>> -static int __devexit sdhci_pxa_remove(struct platform_device *pdev)
>> -{
>> - =A0 =A0 =A0 struct sdhci_host *host =3D platform_get_drvdata(pdev)=
;
>> - =A0 =A0 =A0 struct sdhci_pxa *pxa =3D sdhci_priv(host);
>> - =A0 =A0 =A0 int dead =3D 0;
>> - =A0 =A0 =A0 u32 scratch;
>> -
>> - =A0 =A0 =A0 if (host) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 scratch =3D readl(host->ioaddr + SDHCI=
_INT_STATUS);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (scratch =3D=3D (u32)-1)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dead =3D 1;
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_remove_host(host, dead);
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->ioaddr)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 iounmap(host->ioaddr);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pxa->res)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 release_mem_region(pxa=
->res->start,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0resource_size(pxa->res));
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pxa->clk_enable) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(pxa->clk);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pxa->clk_enable =3D 0;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_put(pxa->clk);
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_free_host(host);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 platform_set_drvdata(pdev, NULL);
>> - =A0 =A0 =A0 }
>> -
>> - =A0 =A0 =A0 return 0;
>> -}
>> -
>> -#ifdef CONFIG_PM
>> -static int sdhci_pxa_suspend(struct platform_device *dev, pm_messag=
e_t state)
>> -{
>> - =A0 =A0 =A0 struct sdhci_host *host =3D platform_get_drvdata(dev);
>> -
>> - =A0 =A0 =A0 return sdhci_suspend_host(host, state);
>> -}
>> -
>> -static int sdhci_pxa_resume(struct platform_device *dev)
>> -{
>> - =A0 =A0 =A0 struct sdhci_host *host =3D platform_get_drvdata(dev);
>> -
>> - =A0 =A0 =A0 return sdhci_resume_host(host);
>> -}
>> -#else
>> -#define sdhci_pxa_suspend =A0 =A0 =A0NULL
>> -#define sdhci_pxa_resume =A0 =A0 =A0 NULL
>> -#endif
>> -
>> -static struct platform_driver sdhci_pxa_driver =3D {
>> - =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D sdhci_pxa_probe,
>> - =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D __devexit_p(sdhci_pxa_remo=
ve),
>> - =A0 =A0 =A0 .suspend =A0 =A0 =A0 =A0=3D sdhci_pxa_suspend,
>> - =A0 =A0 =A0 .resume =A0 =A0 =A0 =A0 =3D sdhci_pxa_resume,
>> - =A0 =A0 =A0 .driver =A0 =A0 =A0 =A0 =3D {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D DRIVER_NAME,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0=3D THIS_MODULE,
>> - =A0 =A0 =A0 },
>> -};
>> -
>> -/******************************************************************=
***********\
>> - * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 *
>> - * Driver init/exit =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*
>> - * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 *
>> -\******************************************************************=
***********/
>> -
>> -static int __init sdhci_pxa_init(void)
>> -{
>> - =A0 =A0 =A0 return platform_driver_register(&sdhci_pxa_driver);
>> -}
>> -
>> -static void __exit sdhci_pxa_exit(void)
>> -{
>> - =A0 =A0 =A0 platform_driver_unregister(&sdhci_pxa_driver);
>> -}
>> -
>> -module_init(sdhci_pxa_init);
>> -module_exit(sdhci_pxa_exit);
>> -
>> -MODULE_DESCRIPTION("SDH controller driver for PXA168/PXA910/MMP2");
>> -MODULE_AUTHOR("Zhangfei Gao <zhangfei.gao@marvell.com>");
>> -MODULE_LICENSE("GPL v2");
>> --
>> 1.7.0.4
>
>
>
>
> code to send 74 clocks when card is inserted. =A0Need to callback hoo=
k so
> code is called from sdhci.c
>
> from patch submitted to linux-mmc
>
> from: Philip Rakity <prakity@marvell.com>
> Date: February 13, 2011 11:24:18 PM PST
> To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
> Cc: Mark Brown <markb@marvell.com>
> Subject: [PATCH] sdhci: Add support PXA168, PXA910, and MMP2 controll=
ers
>
>
> +static void generate_initial_74_clocks(struct sdhci_host *host, u8 p=
ower_mode)
> +{
> + =A0 =A0 =A0 struct sdhci_pxa *pxa =3D sdhci_priv(host);
> + =A0 =A0 =A0 u16 tmp;
> + =A0 =A0 =A0 int count;
> +
> + =A0 =A0 =A0 if (pxa->power_mode =3D=3D MMC_POWER_UP
> + =A0 =A0 =A0 && power_mode =3D=3D MMC_POWER_ON) {
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("%s:%s ENTER: slot->power_mode=
 =3D %d,"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "ios->power_mode =3D %d=
\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_hostname(host->mmc)=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pxa->power_mode,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 power_mode);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* set we want notice of when 74 clocks=
 are sent */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp =3D readw(host->ioaddr + SD_CE_ATA_=
2);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp |=3D SDCE_MISC_INT_EN;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 writew(tmp, host->ioaddr + SD_CE_ATA_2)=
;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* start sending the 74 clocks */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp =3D readw(host->ioaddr + SD_CFG_FIF=
O_PARAM);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp |=3D SDCFG_GEN_PAD_CLK_ON;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 writew(tmp, host->ioaddr + SD_CFG_FIFO_=
PARAM);

Will merge the code together?
How about simplifying the code to
 if (pxa->power_mode =3D=3D MMC_POWER_UP
      && power_mode =3D=3D MMC_POWER_ON) {
               /* start sending the 74 clocks */
               tmp =3D readw(host->ioaddr + SD_CFG_FIFO_PARAM);
               tmp |=3D SDCFG_GEN_PAD_CLK_ON;
               writew(tmp, host->ioaddr + SD_CFG_FIFO_PARAM);
       }
       pxa->power_mode =3D power_mode;
}
Since core.c already consider the time for 74 clocks.
static void mmc_power_up(struct mmc_host *host)
{
~~
         /*
         * This delay must be at least 74 clock sizes, or 1 ms, or the
         * time required to reach a stable voltage.
         */
        mmc_delay(10);
}
The issue of our controller is clock is not start until there is cmd or=
 data.
While 10ms is enough for 74 clock, so just need to start and no need
to wait finish.


> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* slowest speed is about 100KHz or 10u=
sec per clock */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(740);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 count =3D 0;
> +#define MAX_WAIT_COUNT 5
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (count++ < MAX_WAIT_COUNT) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((readw(host->ioaddr=
 + SD_CE_ATA_2)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 & SDCE_MISC_INT) =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(10);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (count =3D=3D MAX_WAIT_COUNT)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING"%s:=
 %s: 74 clock interrupt "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "not cl=
eared\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func_=
_, mmc_hostname(host->mmc));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* clear the interrupt bit if posted */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp =3D readw(host->ioaddr + SD_CE_ATA_=
2);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp |=3D SDCE_MISC_INT;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 writew(tmp, host->ioaddr + SD_CE_ATA_2)=
;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 pxa->power_mode =3D power_mode;
> +}
> +
>
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
