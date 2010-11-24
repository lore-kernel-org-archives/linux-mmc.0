From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH v1 1/1]sdhci-pxa: init_sdh for different platform
Date: Wed, 24 Nov 2010 00:56:04 -0500
Message-ID: <AANLkTiknGBVg+-1aJo=Tg+2wU_93ATTcxAvbaDKmFzp=@mail.gmail.com>
References: <AANLkTinccZKV0trj602o=yQ-W12097dfTP30GWeXwVB3@mail.gmail.com>
	<AANLkTi=1dft241TUb-tYfPnQFri=CoP+Bhfztoes_A6C@mail.gmail.com>
	<AANLkTik9w-w5AeMX=EPUtF_a=QoNi83GuA4MfbHPr86x@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58746 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750941Ab0KXF4G convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 24 Nov 2010 00:56:06 -0500
Received: by fxm13 with SMTP id 13so4653296fxm.19
        for <linux-mmc@vger.kernel.org>; Tue, 23 Nov 2010 21:56:04 -0800 (PST)
In-Reply-To: <AANLkTik9w-w5AeMX=EPUtF_a=QoNi83GuA4MfbHPr86x@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Eric Miao <eric.y.miao@gmail.com>, Philip Rakity <prakity@marvell.com>

On Tue, Nov 23, 2010 at 5:56 AM, Haojian Zhuang
<haojian.zhuang@gmail.com> wrote:
> On Mon, Nov 22, 2010 at 11:38 AM, Haojian Zhuang
> <haojian.zhuang@gmail.com> wrote:
>> On Thu, Nov 18, 2010 at 3:42 PM, zhangfei gao <zhangfei.gao@gmail.co=
m> wrote:
>>> Different platform will provide different init_sdh to handle privat=
e
>>> register is not same in various platform.
>>> Put init_sdh in set_clock is we don't want to add more call back
>>> function to sdhci.c to keep sdhci.c as simple as possible.
>>> Currently init_sdh will be called several times when clk is changed=
:
>>> insert, 2 times; remove: 4 times.
>>> After clk_gating in MMC stack is enabled, set_clock will send clock=
=3D0,
>>> and then init_sdh will only called only once as well as enable_clk.
>>>
>>> From c1abef994120536f9f0498293afeebf5412f22f6 Mon Sep 17 00:00:00 2=
001
>>> From: Zhangfei Gao <zhangfei.gao@marvell.com>
>>> Date: Thu, 18 Nov 2010 01:22:23 -0500
>>> Subject: [PATCH] sdhci-pxa: init_sdh for different platform
>>>
>>> =A0 =A0 =A0 =A0The sdhci-pxa ip is same, but may be different versi=
on among
>>> different platforms, as a result private register have different
>>> address.
>>> =A0 =A0 =A0 =A0Provide init_sdh in arch/arm/mach to move the differ=
ence to platform code.
>>>
>>> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
>>> ---
>>> =A0arch/arm/mach-mmp/include/mach/mmp2_sdh.h | =A0 58 +++++++++++++=
++++++++++++++++
>>> =A0arch/arm/plat-pxa/include/plat/sdhci.h =A0 =A0| =A0 =A06 +++
>>> =A0drivers/mmc/host/sdhci-pxa.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 34=
 +----------------
>>> =A03 files changed, 66 insertions(+), 32 deletions(-)
>>> =A0create mode 100644 arch/arm/mach-mmp/include/mach/mmp2_sdh.h
>>>
>>> diff --git a/arch/arm/mach-mmp/include/mach/mmp2_sdh.h
>>> b/arch/arm/mach-mmp/include/mach/mmp2_sdh.h
>>> new file mode 100644
>>> index 0000000..c1d4a80
>>> --- /dev/null
>>> +++ b/arch/arm/mach-mmp/include/mach/mmp2_sdh.h
>>> @@ -0,0 +1,58 @@
>>> +/* linux/arch/arm/mach-mmp/include/mach/mmp2_sdh.h
>>> + *
>>> + * Copyright 2010 Marvell
>>> + * =A0 =A0 Zhangfei Gao <zhangfei.gao@marvell.com>
>>> + *
>>> + * MMP2 Platform - sepcific sdh function
>>> + *
>>> + * This program is free software; you can redistribute it and/or m=
odify
>>> + * it under the terms of the GNU General Public License version 2 =
as
>>> + * published by the Free Software Foundation.
>>> + */
>>> +
>>> +#ifndef __MMP2_SDH_H
>>> +#define __MMP2_SDH_H
>>> +
>>> +#include <linux/mmc/sdhci.h>
>>> +#include <plat/sdhci.h>
>>> +#include <linux/io.h>
>>> +
>>> +#define SD_FIFO_PARAM =A0 =A0 =A0 =A0 =A00x104
>>> +#define DIS_PAD_SD_CLK_GATE =A0 =A00x400
>>> +
>>> +#define SD_CLOCK_AND_BURST_SIZE_SETUP =A0 =A0 =A0 =A0 =A00x10A
>>> +#define SDCLK_SEL =A0 =A0 =A00x100
>>> +#define SDCLK_DELAY_SHIFT =A0 =A0 =A09
>>> +#define SDCLK_DELAY_MASK =A0 =A0 =A0 0x1f
>>> +
>>> +inline void mmp2_init_sdh(struct sdhci_host *host,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct sdhci_pxa_plat=
data *pdata)
>>> +{
>>> + =A0 =A0 =A0 /*
>>> + =A0 =A0 =A0 =A0* tune timing of read data/command when crc error =
happen
>>> + =A0 =A0 =A0 =A0* no performance impact
>>> + =A0 =A0 =A0 =A0*/
>>> + =A0 =A0 =A0 if (pdata && 0 !=3D pdata->clk_delay_cycles) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u16 tmp;
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp =3D readw(host->ioaddr + SD_CLOCK=
_AND_BURST_SIZE_SETUP);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp |=3D (pdata->clk_delay_cycles & S=
DCLK_DELAY_MASK)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 << SDCLK_DELAY_SHIFT;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp |=3D SDCLK_SEL;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 writew(tmp, host->ioaddr + SD_CLOCK_A=
ND_BURST_SIZE_SETUP);
>>> + =A0 =A0 =A0 }
>>> +
>>> + =A0 =A0 =A0 /*
>>> + =A0 =A0 =A0 =A0* disable clock gating per some cards requirement
>>> + =A0 =A0 =A0 =A0*/
>>> +
>>> + =A0 =A0 =A0 if (pdata && pdata->flags & PXA_FLAG_DISABLE_CLOCK_GA=
TING) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 tmp =3D 0;
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp =3D readl(host->ioaddr + SD_FIFO_=
PARAM);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp |=3D DIS_PAD_SD_CLK_GATE;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 writel(tmp, host->ioaddr + SD_FIFO_PA=
RAM);
>>> + =A0 =A0 =A0 }
>>> +}
>
> Since you implement it as C code, it'll result in build issue for
> multiple platform that supports MMP2 SDH. So I suggest you to seperat=
e
> this patch into two. One is focused on implementing mmp2_init_sdh() i=
n
> mmp2.c and submitted to pxa tree since we're always updating mmp2.c i=
n
> pxa subtree. The other one is focused on using this interface from
> pdata in MMC tree.
>
> Thanks
> Haojian

Thanks for suggestion, will split the patch, only provide interface
here, and implement  mmp2_init_sdh in arch/arm/mach-mmp/mmp2.c and
submit in pxa tree.
