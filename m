From: Balaji T K <balajitk@ti.com>
Subject: Re: [mmc:mmc-next 79/96] drivers/mmc/host/omap_hsmmc.c:1841:30: error:
 'struct dev_pm_info' has no member named 'runtime_status'
Date: Fri, 23 May 2014 13:57:48 +0530
Message-ID: <537F0684.4050107@ti.com>
References: <537de770.ItHqmb5BpaXWIlXq%fengguang.wu@intel.com> <CAPDyKFoWABO-k9dh5AvhaJFoF-NRCBz1_G+fJ53MPnzBr42CfQ@mail.gmail.com> <86oayqq93b.fsf@void.printf.net> <20140522142401.GA14489@atomide.com> <CALtMJEDhBFomn8VEu1G=F8fbZBLO=msTnUCzHSpYsQxEc4WtKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56522 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751862AbaEWI1w (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 23 May 2014 04:27:52 -0400
In-Reply-To: <CALtMJEDhBFomn8VEu1G=F8fbZBLO=msTnUCzHSpYsQxEc4WtKw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andreas Fenkart <afenkart@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>

On Friday 23 May 2014 01:49 PM, Andreas Fenkart wrote:
> 2014-05-22 16:24 GMT+02:00 Tony Lindgren <tony@atomide.com>:
>> * Chris Ball <chris@printf.net> [140522 05:42]:
>>> Hi,
>>>
>>> On Thu, May 22 2014, Ulf Hansson wrote:
>>>> I had a second look at Andreas Fenkart's patchset to enable SDIO irq
>>>> for omap. Those needs an additional iteration, since there are
>>>> unresolved dependencies to CONFIG_PM_RUNTIME (and possibly to other
>>>> Kconfigs as well). Apparently I had all the needed Kconfigs enabled
>>>> while I compile tested them. :-(
>>
>> Did you find this out with make randconfig?
>
> FYI
>
> after this patch I could deselect CONFIG_PM
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -111,7 +111,6 @@ config ARCH_OMAP2PLUS_TYPICAL
>          select I2C_OMAP
>          select MENELAUS if ARCH_OMAP2
>          select NEON if CPU_V7
> -       select PM_RUNTIME
>          select REGULATOR
>          select TWL4030_CORE if ARCH_OMAP3 || ARCH_OMAP4
>          select TWL4030_POWER if ARCH_OMAP3 || ARCH_OMAP4
>
>
>>
>>>> I tried out doing a local re-base, to remove the related omap patches.
>>>> If you remove the patches below you won't get any conflicts for
>>>> omap_hsmmc. Can you do that?
>>>>
>>>> Andreas:
>>>> mmc: omap_hsmmc: Enable SDIO interrupt
>>>> mmc: omap_hsmmc: enable wakeup event for sdio OMAP4
>>>> mmc: omap_hsmmc: Extend debugfs by SDIO IRQ handling, runtime state
>>>> mmc: omap_hsmmc: abort runtime suspend if pending sdio irq detected
>>>> mmc: omap_hsmmc: switch default/idle pinctrl states in runtime hooks
>>>> mmc: omap_hsmmc: Pin remux workaround to support SDIO interrupt on AM335x
>>>>
>>>> Balaji:
>>>> mmc: omap_hsmmc: use IS_ERR macro for error checking
>>>
>>> Done.  Thanks!
>>
>> Andreas, can you fix this ASAP? Would be nice to have those
>> working for v3.16 :)
> will send out updated patches soon

Thanks Andreas,
If it helps, how about sending the fix as separate patch,
That way it will be easier for reviewing!

