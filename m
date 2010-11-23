From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: Re: [PATCH v1 1/1]sdhci-pxa: init_sdh for different platform
Date: Tue, 23 Nov 2010 18:56:43 +0800
Message-ID: <AANLkTik9w-w5AeMX=EPUtF_a=QoNi83GuA4MfbHPr86x@mail.gmail.com>
References: <AANLkTinccZKV0trj602o=yQ-W12097dfTP30GWeXwVB3@mail.gmail.com>
	<AANLkTi=1dft241TUb-tYfPnQFri=CoP+Bhfztoes_A6C@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:48498 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751914Ab0KWK4q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Nov 2010 05:56:46 -0500
Received: by wyb28 with SMTP id 28so8141288wyb.19
        for <linux-mmc@vger.kernel.org>; Tue, 23 Nov 2010 02:56:44 -0800 (PST)
In-Reply-To: <AANLkTi=1dft241TUb-tYfPnQFri=CoP+Bhfztoes_A6C@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Eric Miao <eric.y.miao@gmail.com>

On Mon, Nov 22, 2010 at 11:38 AM, Haojian Zhuang
<haojian.zhuang@gmail.com> wrote:
> On Thu, Nov 18, 2010 at 3:42 PM, zhangfei gao <zhangfei.gao@gmail.com=
> wrote:
>> Different platform will provide different init_sdh to handle private
>> register is not same in various platform.
>> Put init_sdh in set_clock is we don't want to add more call back
>> function to sdhci.c to keep sdhci.c as simple as possible.
>> Currently init_sdh will be called several times when clk is changed:
>> insert, 2 times; remove: 4 times.
>> After clk_gating in MMC stack is enabled, set_clock will send clock=3D=
0,
>> and then init_sdh will only called only once as well as enable_clk.
>>
>> From c1abef994120536f9f0498293afeebf5412f22f6 Mon Sep 17 00:00:00 20=
01
>> From: Zhangfei Gao <zhangfei.gao@marvell.com>
>> Date: Thu, 18 Nov 2010 01:22:23 -0500
>> Subject: [PATCH] sdhci-pxa: init_sdh for different platform
>>
>> =A0 =A0 =A0 =A0The sdhci-pxa ip is same, but may be different versio=
n among
>> different platforms, as a result private register have different
>> address.
>> =A0 =A0 =A0 =A0Provide init_sdh in arch/arm/mach to move the differe=
nce to platform code.
>>
>> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
>> ---
>> =A0arch/arm/mach-mmp/include/mach/mmp2_sdh.h | =A0 58 ++++++++++++++=
+++++++++++++++
>> =A0arch/arm/plat-pxa/include/plat/sdhci.h =A0 =A0| =A0 =A06 +++
>> =A0drivers/mmc/host/sdhci-pxa.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 34 =
+----------------
>> =A03 files changed, 66 insertions(+), 32 deletions(-)
>> =A0create mode 100644 arch/arm/mach-mmp/include/mach/mmp2_sdh.h
>>
>> diff --git a/arch/arm/mach-mmp/include/mach/mmp2_sdh.h
>> b/arch/arm/mach-mmp/include/mach/mmp2_sdh.h
>> new file mode 100644
>> index 0000000..c1d4a80
>> --- /dev/null
>> +++ b/arch/arm/mach-mmp/include/mach/mmp2_sdh.h
>> @@ -0,0 +1,58 @@
>> +/* linux/arch/arm/mach-mmp/include/mach/mmp2_sdh.h
>> + *
>> + * Copyright 2010 Marvell
>> + * =A0 =A0 Zhangfei Gao <zhangfei.gao@marvell.com>
>> + *
>> + * MMP2 Platform - sepcific sdh function
>> + *
>> + * This program is free software; you can redistribute it and/or mo=
dify
>> + * it under the terms of the GNU General Public License version 2 a=
s
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#ifndef __MMP2_SDH_H
>> +#define __MMP2_SDH_H
>> +
>> +#include <linux/mmc/sdhci.h>
>> +#include <plat/sdhci.h>
>> +#include <linux/io.h>
>> +
>> +#define SD_FIFO_PARAM =A0 =A0 =A0 =A0 =A00x104
>> +#define DIS_PAD_SD_CLK_GATE =A0 =A00x400
>> +
>> +#define SD_CLOCK_AND_BURST_SIZE_SETUP =A0 =A0 =A0 =A0 =A00x10A
>> +#define SDCLK_SEL =A0 =A0 =A00x100
>> +#define SDCLK_DELAY_SHIFT =A0 =A0 =A09
>> +#define SDCLK_DELAY_MASK =A0 =A0 =A0 0x1f
>> +
>> +inline void mmp2_init_sdh(struct sdhci_host *host,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct sdhci_pxa_platd=
ata *pdata)
>> +{
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* tune timing of read data/command when crc error h=
appen
>> + =A0 =A0 =A0 =A0* no performance impact
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 if (pdata && 0 !=3D pdata->clk_delay_cycles) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u16 tmp;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp =3D readw(host->ioaddr + SD_CLOCK_=
AND_BURST_SIZE_SETUP);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp |=3D (pdata->clk_delay_cycles & SD=
CLK_DELAY_MASK)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 << SDCLK_DELAY_SHIFT;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp |=3D SDCLK_SEL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 writew(tmp, host->ioaddr + SD_CLOCK_AN=
D_BURST_SIZE_SETUP);
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
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp =3D readl(host->ioaddr + SD_FIFO_P=
ARAM);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp |=3D DIS_PAD_SD_CLK_GATE;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 writel(tmp, host->ioaddr + SD_FIFO_PAR=
AM);
>> + =A0 =A0 =A0 }
>> +}

Since you implement it as C code, it'll result in build issue for
multiple platform that supports MMP2 SDH. So I suggest you to seperate
this patch into two. One is focused on implementing mmp2_init_sdh() in
mmp2.c and submitted to pxa tree since we're always updating mmp2.c in
pxa subtree. The other one is focused on using this interface from
pdata in MMC tree.

Thanks
Haojian
>> +
>> +#endif /* __MMP2_SDH_H */
>> diff --git a/arch/arm/plat-pxa/include/plat/sdhci.h
>> b/arch/arm/plat-pxa/include/plat/sdhci.h
>> index f6f46db..a3a08db 100644
>> --- a/arch/arm/plat-pxa/include/plat/sdhci.h
>> +++ b/arch/arm/plat-pxa/include/plat/sdhci.h
>> @@ -13,6 +13,8 @@
>> =A0#ifndef __PLAT_PXA_SDHCI_H
>> =A0#define __PLAT_PXA_SDHCI_H
>>
>> +#include <linux/mmc/sdhci.h>
>> +
>> =A0/* pxa specific flag */
>> =A0/* Require clock free running */
>> =A0#define PXA_FLAG_DISABLE_CLOCK_GATING (1<<0)
>> @@ -25,12 +27,16 @@
>> =A0* @quirks: quirks of specific device
>> =A0* @flags: flags for platform requirement
>> =A0* @clk_delay_cycles: 1 ~ 0x1f, each step is roughly 100ps, for tu=
ning timing
>> + * @init_sdh: init function for specific card
>> =A0*/
>> =A0struct sdhci_pxa_platdata {
>> =A0 =A0 =A0 =A0unsigned int =A0 =A0max_speed;
>> =A0 =A0 =A0 =A0unsigned int =A0 =A0quirks;
>> =A0 =A0 =A0 =A0unsigned int =A0 =A0flags;
>> =A0 =A0 =A0 =A0unsigned int =A0 =A0clk_delay_cycles;
>> +
>> + =A0 =A0 =A0 void (*init_sdh)(struct sdhci_host *host,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct sdhci_pxa_platd=
ata *pdata);
>> =A0};
>>
>> =A0#endif /* __PLAT_PXA_SDHCI_H */
>> diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-p=
xa.c
>> index 2b665e4..d628dcc 100644
>> --- a/drivers/mmc/host/sdhci-pxa.c
>> +++ b/drivers/mmc/host/sdhci-pxa.c
>> @@ -29,14 +29,6 @@
>>
>> =A0#define DRIVER_NAME =A0 =A0"sdhci-pxa"
>>
>> -#define SD_FIFO_PARAM =A0 =A0 =A0 =A0 =A00x104
>> -#define DIS_PAD_SD_CLK_GATE =A0 =A00x400
>> -
>> -#define SD_CLOCK_AND_BURST_SIZE_SETUP =A0 =A0 =A0 =A0 =A00x10A
>> -#define SDCLK_SEL =A0 =A0 =A00x100
>> -#define SDCLK_DELAY_SHIFT =A0 =A0 =A09
>> -#define SDCLK_DELAY_MASK =A0 =A0 =A0 0x1f
>> -
>> =A0struct sdhci_pxa {
>> =A0 =A0 =A0 =A0struct sdhci_host =A0 =A0 =A0 =A0 =A0 =A0 =A0 *host;
>> =A0 =A0 =A0 =A0struct sdhci_pxa_platdata =A0 =A0 =A0 *pdata;
>> @@ -51,29 +43,11 @@ struct sdhci_pxa {
>> =A0* SDHCI core callbacks =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*
>> =A0* =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 *
>> =A0\****************************************************************=
*************/
>> -static inline void tune_timing(struct sdhci_host *host,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct=
 sdhci_pxa_platdata *pdata)
>> -{
>> - =A0 =A0 =A0 /*
>> - =A0 =A0 =A0 =A0* tune timing of read data/command when crc error h=
appen
>> - =A0 =A0 =A0 =A0* no performance impact
>> - =A0 =A0 =A0 =A0*/
>> - =A0 =A0 =A0 if (pdata && 0 !=3D pdata->clk_delay_cycles) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 u16 tmp;
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp =3D readw(host->ioaddr + SD_CLOCK_=
AND_BURST_SIZE_SETUP);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp |=3D (pdata->clk_delay_cycles & SD=
CLK_DELAY_MASK)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 << SDCLK_DELAY_SHIFT;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp |=3D SDCLK_SEL;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 writew(tmp, host->ioaddr + SD_CLOCK_AN=
D_BURST_SIZE_SETUP);
>> - =A0 =A0 =A0 }
>> -}
>>
>> =A0static void set_clock(struct sdhci_host *host, unsigned int clock=
)
>> =A0{
>> =A0 =A0 =A0 =A0struct sdhci_pxa *pxa =3D sdhci_priv(host);
>> =A0 =A0 =A0 =A0struct sdhci_pxa_platdata *pdata =3D pxa->pdata;
>> - =A0 =A0 =A0 u32 tmp =3D 0;
>>
>> =A0 =A0 =A0 =A0if (clock =3D=3D 0) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (pxa->clk_enable) {
>> @@ -81,12 +55,8 @@ static void set_clock(struct sdhci_host *host,
>> unsigned int clock)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pxa->clk_enable =3D 0=
;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> =A0 =A0 =A0 =A0} else {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 tune_timing(host, pdata);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pdata && pdata->flags & PXA_FLAG_D=
ISABLE_CLOCK_GATING) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp =3D readl(host->io=
addr + SD_FIFO_PARAM);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp |=3D DIS_PAD_SD_CL=
K_GATE;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 writel(tmp, host->ioad=
dr + SD_FIFO_PARAM);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pdata && pdata->init_sdh)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->init_sdh(host, =
pdata);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clk_enable(pxa->clk);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pxa->clk_enable =3D 1;
>> =A0 =A0 =A0 =A0}
>> --
>> 1.7.0.4
>>
>
> Acked
>
