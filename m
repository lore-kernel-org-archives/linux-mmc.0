From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH 2/2] sdhci-pxa add call back interface to share sdhci-pxa
Date: Tue, 7 Dec 2010 23:58:23 +0800
Message-ID: <AANLkTikpw7aDqp4cwgujS674CE3eKeBmm3VAQ4hQFAhC@mail.gmail.com>
References: <AANLkTi=ECyTAPntMfp_F4Kp2A3UCntLxyWJcbpS3WFP3@mail.gmail.com>
	<83185AA24C678642A07282B8BB1340B613509C65CA@sc-vexch3.marvell.com>
	<38097AE9-4447-484D-B370-272AB6084A11@marvell.com>
	<AANLkTikUqERQbB6c4BYo6f+zc1W+A3O118v5OWC=f3Bb@mail.gmail.com>
	<E6B1A689-A7A2-4A5C-B163-D48616FA0ABD@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41300 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753848Ab0LGP6Z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Dec 2010 10:58:25 -0500
Received: by fxm20 with SMTP id 20so50390fxm.19
        for <linux-mmc@vger.kernel.org>; Tue, 07 Dec 2010 07:58:23 -0800 (PST)
In-Reply-To: <E6B1A689-A7A2-4A5C-B163-D48616FA0ABD@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: Zhangfei Gao <zgao6@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Raymond Wu <xywu@marvell.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, "niej0001@gmail.com" <niej0001@gmail.com>, Mark Brown <markb@marvell.com>, Jun Nie <njun@marvell.com>

2010/12/7 Philip Rakity <prakity@marvell.com>:
>
> was interested in the 9xx code.

You can ask Jun for pxa910 code, and Raymond for pxa950 code via
internal email system, thanks
>
>
> On Dec 7, 2010, at 7:38 AM, zhangfei gao wrote:
>
>> 2010/12/7 Philip Rakity <prakity@marvell.com>:
>>>
>>> Where is the code that implements
>>>
>>>> +     unsigned int    clk_delay_cycles;
>>>> +     unsigned int    clk_delay_sel;
>>
>> The code is located under arch/arm/, it is used differently depends =
on
>> different platfrom.
>> For example, aspen could realize under arch/arm/mach-pxa/pxa168.c.
>> Could you refer the code for mmp2.
>>
>>>
>>>
>>>
>>>
>>> On Dec 6, 2010, at 9:56 PM, Raymond Wu wrote:
>>>
>>>> Hi,
>>>>
>>>> This patch is verified by: Raymond Wu(xywu@marvell.com) on pxa955 =
SAARB platform.
>>>>
>>>> Thanks,
>>>> Raymond
>>>>
>>>>
>>>> -----Original Message-----
>>>> From: zhangfei gao [mailto:zhangfei.gao@gmail.com]
>>>> Sent: 2010=C4=EA12=D4=C23=C8=D5 14:31
>>>> To: linux-mmc@vger.kernel.org
>>>> Cc: Chris Ball; Eric Miao; Haojian Zhuang; niej0001@gmail.com; Phi=
lip Rakity; Mark Brown; Raymond Wu; Jun Nie
>>>> Subject: [PATCH 2/2] sdhci-pxa add call back interface to share sd=
hci-pxa
>>>>
>>>> From fb5927afac7cbb44805093816bea51dde33da1e5 Mon Sep 17 00:00:00 =
2001
>>>> From: Zhangfei Gao <zhangfei.gao@marvell.com>
>>>> Date: Tue, 30 Nov 2010 05:43:29 -0500
>>>> Subject: [PATCH 2/2] sdhci-pxa: add call back interface to share s=
dhci-pxa
>>>>
>>>>      Call back functions is added to support mmp2, pxa910, pxa168 =
and pxa955
>>>>
>>>> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
>>>> CC: RaymondWu <xywu@marvell.com>
>>>> CC: Jun Nie <njun@marvell.com>
>>>> CC: Philip Rakity <prakity@marvell.com>
>>>> ---
>>>> arch/arm/plat-pxa/include/plat/sdhci.h |   44 +++++++++++++++++
>>>> drivers/mmc/host/sdhci-pxa.c           |   83 ++++++++++++++++++++=
+-----------
>>>> 2 files changed, 98 insertions(+), 29 deletions(-)
>>>>
>>>> diff --git a/arch/arm/plat-pxa/include/plat/sdhci.h
>>>> b/arch/arm/plat-pxa/include/plat/sdhci.h
>>>> index 1ab332e..4ce3b05 100644
>>>> --- a/arch/arm/plat-pxa/include/plat/sdhci.h
>>>> +++ b/arch/arm/plat-pxa/include/plat/sdhci.h
>>>> @@ -13,9 +13,14 @@
>>>> #ifndef __PLAT_PXA_SDHCI_H
>>>> #define __PLAT_PXA_SDHCI_H
>>>>
>>>> +#include <linux/mmc/sdhci.h>
>>>> +#include <linux/platform_device.h>
>>>> +
>>>> /* pxa specific flag */
>>>> /* Require clock free running */
>>>> #define PXA_FLAG_DISABLE_CLOCK_GATING (1<<0)
>>>> +/* card alwayes wired to host, like on-chip emmc */
>>>> +#define PXA_FLAG_CARD_PERMANENT      (1<<1)
>>>>
>>>> /* Board design supports 8-bit data on SD/SDIO BUS */  #define PXA=
_FLAG_SD_8_BIT_CAPABLE_SLOT (1<<2) @@ -25,11 +30,50 @@
>>>> * @max_speed: the maximum speed supported
>>>> * @quirks: quirks of specific device
>>>> * @flags: flags for platform requirement
>>>> + * @clk_delay_cycles:
>>>> + *   mmp2: each step is roughly 100ps, 5bits width
>>>> + *   pxa910 & pxa168: each step is 1ns, 4bits width
>>>> + * @clk_delay_enable: enable clk_delay or not, used on pxa910 & p=
xa168
>>>> + * @clk_delay_sel: select clk_delay, used on pxa910 & pxa168
>>>> + *   0: choose feedback clk
>>>> + *   1: choose feedback clk + delay value
>>>> + *   2: choose internal clk
>>>> + * @ext_cd_gpio: gpio pin used for external CD line
>>>> + * @ext_cd_gpio_invert: invert values for external CD gpio line
>>>> + * @soc_set_timing: set timing for specific soc
>>>> + * @ext_cd_init: Initialize external card detect subsystem
>>>> + * @ext_cd_cleanup: Cleanup external card detect subsystem
>>>> + * @soc_set_ops: overwrite host ops with soc specific ops
>>>> */
>>>> +struct sdhci_pxa;
>>>> struct sdhci_pxa_platdata {
>>>>      unsigned int    max_speed;
>>>>      unsigned int    quirks;
>>>>      unsigned int    flags;
>>>> +     unsigned int    clk_delay_cycles;
>>>> +     unsigned int    clk_delay_sel;
>>>> +     unsigned int    ext_cd_gpio;
>>>> +     bool            ext_cd_gpio_invert;
>>>> +     bool            clk_delay_enable;
>>>> +
>>>> +     void (*soc_set_timing)(struct sdhci_host *host,
>>>> +                     struct sdhci_pxa_platdata *pdata);
>>>> +     int (*ext_cd_init)(void (*notify_func)(struct platform_devic=
e *dev,
>>>> +                                                int state), void =
*data);
>>>> +     int (*ext_cd_cleanup)(void (*notify_func)(struct platform_de=
vice *dev,
>>>> +                                                   int state), vo=
id *data);
>>>> +     void (*soc_set_ops)(struct sdhci_pxa *pxa); };
>>>> +
>>>> +struct sdhci_pxa {
>>>> +     struct sdhci_host               *host;
>>>> +     struct sdhci_pxa_platdata       *pdata;
>>>> +     struct clk                      *clk;
>>>> +     struct resource                 *res;
>>>> +     struct sdhci_ops                *ops;
>>>> +
>>>> +     u8      clk_enable;
>>>> +     u8      power_mode;
>>>> };
>>>>
>>>> #endif /* __PLAT_PXA_SDHCI_H */
>>>> diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci=
-pxa.c index 5a61208..f79dccf 100644
>>>> --- a/drivers/mmc/host/sdhci-pxa.c
>>>> +++ b/drivers/mmc/host/sdhci-pxa.c
>>>> @@ -24,32 +24,22 @@
>>>> #include <linux/clk.h>
>>>> #include <linux/io.h>
>>>> #include <linux/err.h>
>>>> +#include <linux/slab.h>
>>>> #include <plat/sdhci.h>
>>>> #include "sdhci.h"
>>>>
>>>> #define DRIVER_NAME   "sdhci-pxa"
>>>>
>>>> -#define SD_FIFO_PARAM                0x104
>>>> -#define DIS_PAD_SD_CLK_GATE  0x400
>>>> -
>>>> -struct sdhci_pxa {
>>>> -     struct sdhci_host               *host;
>>>> -     struct sdhci_pxa_platdata       *pdata;
>>>> -     struct clk                      *clk;
>>>> -     struct resource                 *res;
>>>> -
>>>> -     u8 clk_enable;
>>>> -};
>>>> -
>>>> /*****************************************************************=
************\
>>>> *                                                                 =
          *
>>>> * SDHCI core callbacks                                            =
          *
>>>> *                                                                 =
          *
>>>> \*****************************************************************=
************/
>>>> +
>>>> static void set_clock(struct sdhci_host *host, unsigned int clock)=
  {
>>>>      struct sdhci_pxa *pxa =3D sdhci_priv(host);
>>>> -     u32 tmp =3D 0;
>>>> +     struct sdhci_pxa_platdata *pdata =3D pxa->pdata;
>>>>
>>>>      if (clock =3D=3D 0) {
>>>>              if (pxa->clk_enable) {
>>>> @@ -57,21 +47,31 @@ static void set_clock(struct sdhci_host *host,=
 unsigned int clock)
>>>>                      pxa->clk_enable =3D 0;
>>>>              }
>>>>      } else {
>>>> -             if (0 =3D=3D pxa->clk_enable) {
>>>> -                     if (pxa->pdata->flags & PXA_FLAG_DISABLE_CLO=
CK_GATING) {
>>>> -                             tmp =3D readl(host->ioaddr + SD_FIFO=
_PARAM);
>>>> -                             tmp |=3D DIS_PAD_SD_CLK_GATE;
>>>> -                             writel(tmp, host->ioaddr + SD_FIFO_P=
ARAM);
>>>> -                     }
>>>> -                     clk_enable(pxa->clk);
>>>> -                     pxa->clk_enable =3D 1;
>>>> -             }
>>>> +             if (pdata && pdata->soc_set_timing)
>>>> +                     pdata->soc_set_timing(host, pdata);
>>>> +             clk_enable(pxa->clk);
>>>> +             pxa->clk_enable =3D 1;
>>>>      }
>>>> }
>>>>
>>>> -static struct sdhci_ops sdhci_pxa_ops =3D {
>>>> -     .set_clock =3D set_clock,
>>>> -};
>>>> +static void sdhci_pxa_notify_change(struct platform_device *dev, =
int
>>>> +state) {
>>>> +     struct sdhci_host *host =3D platform_get_drvdata(dev);
>>>> +     unsigned long flags;
>>>> +
>>>> +     if (host) {
>>>> +             spin_lock_irqsave(&host->lock, flags);
>>>> +             if (state) {
>>>> +                     dev_dbg(&dev->dev, "card inserted.\n");
>>>> +                     host->flags &=3D ~SDHCI_DEVICE_DEAD;
>>>> +             } else {
>>>> +                     dev_dbg(&dev->dev, "card removed.\n");
>>>> +                     host->flags |=3D SDHCI_DEVICE_DEAD;
>>>> +             }
>>>> +             tasklet_schedule(&host->card_tasklet);
>>>> +             spin_unlock_irqrestore(&host->lock, flags);
>>>> +     }
>>>> +}
>>>>
>>>> /*****************************************************************=
************\
>>>> *                                                                 =
          *
>>>> @@ -111,6 +111,12 @@ static int __devinit sdhci_pxa_probe(struct p=
latform_device *pdev)
>>>>      pxa->pdata =3D pdata;
>>>>      pxa->clk_enable =3D 0;
>>>>
>>>> +     pxa->ops =3D kzalloc(sizeof(struct sdhci_ops), GFP_KERNEL);
>>>> +     if (!pxa->ops) {
>>>> +             ret =3D -ENOMEM;
>>>> +             goto out;
>>>> +     }
>>>> +
>>>>      pxa->clk =3D clk_get(dev, "PXA-SDHCLK");
>>>>      if (IS_ERR(pxa->clk)) {
>>>>              dev_err(dev, "failed to get io clock\n"); @@ -134,32 =
+140,46 @@ static int __devinit sdhci_pxa_probe(struct platform_device =
*pdev)
>>>>      }
>>>>
>>>>      host->hw_name =3D "MMC";
>>>> -     host->ops =3D &sdhci_pxa_ops;
>>>>      host->irq =3D irq;
>>>>      host->quirks =3D SDHCI_QUIRK_BROKEN_ADMA | SDHCI_QUIRK_BROKEN=
_TIMEOUT_VAL;
>>>>
>>>> -     if (pdata->quirks)
>>>> +     if (pdata && pdata->flags & PXA_FLAG_CARD_PERMANENT) {
>>>> +             /* on-chip device */
>>>> +             host->quirks |=3D SDHCI_QUIRK_BROKEN_CARD_DETECTION;
>>>> +             host->mmc->caps |=3D MMC_CAP_NONREMOVABLE;
>>>> +     }
>>>> +
>>>> +     if (pdata && pdata->quirks)
>>>>              host->quirks |=3D pdata->quirks;
>>>>
>>>>      /* If slot design supports 8 bit data, indicate this to MMC. =
*/
>>>>      if (pdata->flags & PXA_FLAG_SD_8_BIT_CAPABLE_SLOT)
>>>>              host->mmc->caps |=3D MMC_CAP_8_BIT_DATA;
>>>>
>>>> +     if (pdata && pdata->soc_set_ops)
>>>> +             pdata->soc_set_ops(pxa);
>>>> +
>>>> +     pxa->ops->set_clock =3D set_clock;
>>>> +     host->ops =3D pxa->ops;
>>>> +
>>>>      ret =3D sdhci_add_host(host);
>>>>      if (ret) {
>>>>              dev_err(&pdev->dev, "failed to add host\n");
>>>>              goto out;
>>>>      }
>>>>
>>>> -     if (pxa->pdata->max_speed)
>>>> -             host->mmc->f_max =3D pxa->pdata->max_speed;
>>>> +     if (pdata && pdata->max_speed)
>>>> +             host->mmc->f_max =3D pdata->max_speed;
>>>>
>>>> +     if (pdata && pdata->ext_cd_init)
>>>> +             pdata->ext_cd_init(&sdhci_pxa_notify_change, pdata);
>>>>      platform_set_drvdata(pdev, host);
>>>>
>>>>      return 0;
>>>> out:
>>>>      if (host) {
>>>>              clk_put(pxa->clk);
>>>> +             kfree(pxa->ops);
>>>>              if (host->ioaddr)
>>>>                      iounmap(host->ioaddr);
>>>>              if (pxa->res)
>>>> @@ -173,18 +193,23 @@ out:
>>>>
>>>> static int __devexit sdhci_pxa_remove(struct platform_device *pdev=
)  {
>>>> +     struct sdhci_pxa_platdata *pdata =3D pdev->dev.platform_data=
;
>>>>      struct sdhci_host *host =3D platform_get_drvdata(pdev);
>>>>      struct sdhci_pxa *pxa =3D sdhci_priv(host);
>>>>      int dead =3D 0;
>>>>      u32 scratch;
>>>>
>>>>      if (host) {
>>>> +             if (pdata && pdata->ext_cd_cleanup)
>>>> +                     pdata->ext_cd_cleanup(&sdhci_pxa_notify_chan=
ge, pdata);
>>>> +
>>>>              scratch =3D readl(host->ioaddr + SDHCI_INT_STATUS);
>>>>              if (scratch =3D=3D (u32)-1)
>>>>                      dead =3D 1;
>>>>
>>>>              sdhci_remove_host(host, dead);
>>>>
>>>> +             kfree(pxa->ops);
>>>>              if (host->ioaddr)
>>>>                      iounmap(host->ioaddr);
>>>>              if (pxa->res)
>>>> --
>>>> 1.7.0.4
>>>
>>>
>
>
