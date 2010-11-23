From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH v1 1/1]sdhci-pxa: init_sdh for different platform
Date: Tue, 23 Nov 2010 07:34:48 -0800
Message-ID: <461C4723-EEFE-419B-9964-BA3306585E61@marvell.com>
References: <AANLkTinccZKV0trj602o=yQ-W12097dfTP30GWeXwVB3@mail.gmail.com>
 <AANLkTi=1dft241TUb-tYfPnQFri=CoP+Bhfztoes_A6C@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:46811 "HELO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754611Ab0KWPfM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 23 Nov 2010 10:35:12 -0500
In-Reply-To: <AANLkTi=1dft241TUb-tYfPnQFri=CoP+Bhfztoes_A6C@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: zhangfei gao <zhangfei.gao@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Eric Miao <eric.y.miao@gmail.com>


On Nov 21, 2010, at 7:38 PM, Haojian Zhuang wrote:

> On Thu, Nov 18, 2010 at 3:42 PM, zhangfei gao <zhangfei.gao@gmail.com> wrote:
>> Different platform will provide different init_sdh to handle private
>> register is not same in various platform.
>> Put init_sdh in set_clock is we don't want to add more call back
>> function to sdhci.c to keep sdhci.c as simple as possible.
>> Currently init_sdh will be called several times when clk is changed:
>> insert, 2 times; remove: 4 times.
>> After clk_gating in MMC stack is enabled, set_clock will send clock=0,
>> and then init_sdh will only called only once as well as enable_clk.
>> 
>> From c1abef994120536f9f0498293afeebf5412f22f6 Mon Sep 17 00:00:00 2001
>> From: Zhangfei Gao <zhangfei.gao@marvell.com>
>> Date: Thu, 18 Nov 2010 01:22:23 -0500
>> Subject: [PATCH] sdhci-pxa: init_sdh for different platform
>> 
>>        The sdhci-pxa ip is same, but may be different version among
>> different platforms, as a result private register have different
>> address.
>>        Provide init_sdh in arch/arm/mach to move the difference to platform code.
>> 
>> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
>> ---
>>  arch/arm/mach-mmp/include/mach/mmp2_sdh.h |   58 +++++++++++++++++++++++++++++
>>  arch/arm/plat-pxa/include/plat/sdhci.h    |    6 +++
>>  drivers/mmc/host/sdhci-pxa.c              |   34 +----------------
>>  3 files changed, 66 insertions(+), 32 deletions(-)
>>  create mode 100644 arch/arm/mach-mmp/include/mach/mmp2_sdh.h
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
>> + *     Zhangfei Gao <zhangfei.gao@marvell.com>
>> + *
>> + * MMP2 Platform - sepcific sdh function
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
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
>> +#define SD_FIFO_PARAM          0x104
>> +#define DIS_PAD_SD_CLK_GATE    0x400
>> +
>> +#define SD_CLOCK_AND_BURST_SIZE_SETUP          0x10A
>> +#define SDCLK_SEL      0x100
>> +#define SDCLK_DELAY_SHIFT      9
>> +#define SDCLK_DELAY_MASK       0x1f
>> +
>> +inline void mmp2_init_sdh(struct sdhci_host *host,
>> +                       struct sdhci_pxa_platdata *pdata)
>> +{
>> +       /*
>> +        * tune timing of read data/command when crc error happen
>> +        * no performance impact
>> +        */
>> +       if (pdata && 0 != pdata->clk_delay_cycles) {
>> +               u16 tmp;
>> +
>> +               tmp = readw(host->ioaddr + SD_CLOCK_AND_BURST_SIZE_SETUP);
>> +               tmp |= (pdata->clk_delay_cycles & SDCLK_DELAY_MASK)
>> +                                       << SDCLK_DELAY_SHIFT;
>> +               tmp |= SDCLK_SEL;
>> +               writew(tmp, host->ioaddr + SD_CLOCK_AND_BURST_SIZE_SETUP);
>> +       }
>> +
>> +       /*
>> +        * disable clock gating per some cards requirement
>> +        */
>> +
>> +       if (pdata && pdata->flags & PXA_FLAG_DISABLE_CLOCK_GATING) {
>> +               u32 tmp = 0;
>> +
>> +               tmp = readl(host->ioaddr + SD_FIFO_PARAM);
>> +               tmp |= DIS_PAD_SD_CLK_GATE;
>> +               writel(tmp, host->ioaddr + SD_FIFO_PARAM);
>> +       }
>> +}
>> +
>> +#endif /* __MMP2_SDH_H */

why is this an inline ?  no performance impact if regular function and easier to follow.

>> diff --git a/arch/arm/plat-pxa/include/plat/sdhci.h
>> b/arch/arm/plat-pxa/include/plat/sdhci.h
>> index f6f46db..a3a08db 100644
>> --- a/arch/arm/plat-pxa/include/plat/sdhci.h
>> +++ b/arch/arm/plat-pxa/include/plat/sdhci.h
>> @@ -13,6 +13,8 @@
>>  #ifndef __PLAT_PXA_SDHCI_H
>>  #define __PLAT_PXA_SDHCI_H
>> 
>> +#include <linux/mmc/sdhci.h>
>> +
>>  /* pxa specific flag */
>>  /* Require clock free running */
>>  #define PXA_FLAG_DISABLE_CLOCK_GATING (1<<0)
>> @@ -25,12 +27,16 @@
>>  * @quirks: quirks of specific device
>>  * @flags: flags for platform requirement
>>  * @clk_delay_cycles: 1 ~ 0x1f, each step is roughly 100ps, for tuning timing
>> + * @init_sdh: init function for specific card
>>  */
>>  struct sdhci_pxa_platdata {
>>        unsigned int    max_speed;
>>        unsigned int    quirks;
>>        unsigned int    flags;
>>        unsigned int    clk_delay_cycles;
>> +
>> +       void (*init_sdh)(struct sdhci_host *host,
>> +                       struct sdhci_pxa_platdata *pdata);
>>  };
>> 
>>  #endif /* __PLAT_PXA_SDHCI_H */
>> diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-pxa.c
>> index 2b665e4..d628dcc 100644
>> --- a/drivers/mmc/host/sdhci-pxa.c
>> +++ b/drivers/mmc/host/sdhci-pxa.c
>> @@ -29,14 +29,6 @@
>> 
>>  #define DRIVER_NAME    "sdhci-pxa"
>> 
>> -#define SD_FIFO_PARAM          0x104
>> -#define DIS_PAD_SD_CLK_GATE    0x400
>> -
>> -#define SD_CLOCK_AND_BURST_SIZE_SETUP          0x10A
>> -#define SDCLK_SEL      0x100
>> -#define SDCLK_DELAY_SHIFT      9
>> -#define SDCLK_DELAY_MASK       0x1f
>> -
>>  struct sdhci_pxa {
>>        struct sdhci_host               *host;
>>        struct sdhci_pxa_platdata       *pdata;
>> @@ -51,29 +43,11 @@ struct sdhci_pxa {
>>  * SDHCI core callbacks                                                      *
>>  *                                                                           *
>>  \*****************************************************************************/
>> -static inline void tune_timing(struct sdhci_host *host,
>> -                               struct sdhci_pxa_platdata *pdata)
>> -{
>> -       /*
>> -        * tune timing of read data/command when crc error happen
>> -        * no performance impact
>> -        */
>> -       if (pdata && 0 != pdata->clk_delay_cycles) {
>> -               u16 tmp;
>> -
>> -               tmp = readw(host->ioaddr + SD_CLOCK_AND_BURST_SIZE_SETUP);
>> -               tmp |= (pdata->clk_delay_cycles & SDCLK_DELAY_MASK)
>> -                                       << SDCLK_DELAY_SHIFT;
>> -               tmp |= SDCLK_SEL;
>> -               writew(tmp, host->ioaddr + SD_CLOCK_AND_BURST_SIZE_SETUP);
>> -       }
>> -}
>> 
>>  static void set_clock(struct sdhci_host *host, unsigned int clock)
>>  {
>>        struct sdhci_pxa *pxa = sdhci_priv(host);
>>        struct sdhci_pxa_platdata *pdata = pxa->pdata;
>> -       u32 tmp = 0;
>> 
>>        if (clock == 0) {
>>                if (pxa->clk_enable) {
>> @@ -81,12 +55,8 @@ static void set_clock(struct sdhci_host *host,
>> unsigned int clock)
>>                        pxa->clk_enable = 0;
>>                }
>>        } else {
>> -               tune_timing(host, pdata);
>> -               if (pdata && pdata->flags & PXA_FLAG_DISABLE_CLOCK_GATING) {
>> -                       tmp = readl(host->ioaddr + SD_FIFO_PARAM);
>> -                       tmp |= DIS_PAD_SD_CLK_GATE;
>> -                       writel(tmp, host->ioaddr + SD_FIFO_PARAM);
>> -               }
>> +               if (pdata && pdata->init_sdh)
>> +                       pdata->init_sdh(host, pdata);
>>                clk_enable(pxa->clk);
>>                pxa->clk_enable = 1;
>>        }
>> --
>> 1.7.0.4
>> 
> 
> Acked
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

