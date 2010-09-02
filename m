From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] sdhci-s3c: support non-standard clock setting for c210
Date: Thu, 02 Sep 2010 20:01:56 +0900
Message-ID: <4C7F8424.4070003@samsung.com>
References: <4C7CDA39.1020907@samsung.com>
 <005101cb4a88$7283d080$578b7180$%kim@samsung.com>
 <AANLkTik7RV8nSxPb4NQ+D3n6C_bO6L=WZvfd==7u3fJO@mail.gmail.com>
 <005301cb4a8c$38844320$a98cc960$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:58903 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752157Ab0IBLDC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Sep 2010 07:03:02 -0400
Received: from epmmp1 (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Sun Java(tm) System Messaging Server 7u3-15.01 64bit (built Feb 12 2010))
 with ESMTP id <0L8400E2F9CZ9O00@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 02 Sep 2010 20:02:59 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0L84002RT9CZTS@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 02 Sep 2010 20:02:59 +0900 (KST)
In-reply-to: <005301cb4a8c$38844320$a98cc960$%kim@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: 'Kyungmin Park' <kyungmin.park@samsung.com>, linux-mmc@vger.kernel.org, matt@console-pimps.org, 'Marek Szyprowski' <m.szyprowski@samsung.com>, 'Andrew Morton' <akpm@linux-foundation.org>, 'Ben Dooks' <ben-linux@fluff.org>, linux-arm-kernel@lists.infradead.org

Kukjin Kim wrote:
> Kyungmin Park wrote:
>   
>> On Thu, Sep 2, 2010 at 7:20 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
>>     
>>> Jaehoon Chung wrote:
>>>       
>>>> This is sdhci-s3c patch for c210.
>>>> c210 didn't use divider of host controller.
>>>>
>>>> Host Controller need other clock setting methods.
>>>>
>>>> So I add the callback functions for s5pc210.
>>>> also I set 400KHz for initial clock.
>>>>
>>>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>>>>  Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>>>>         
>    ^^^
> Unnecessary whitespace
>
> If your patch includes arch/arm stuff, please add Linux-arm-kernel
> maillinglist.
> (Cc'ed that)
>
>   
i will send to Linux-arm-kernel mailing list.
If you want to test this patch. you also applied following patch.
(ARM: Samsung: Fix header double inclusion)

diff --git a/arch/arm/plat-samsung/include/plat/devs.h b/arch/arm/plat-samsung/include/plat/devs.h
index 85f6f23..42581f8 100644
--- a/arch/arm/plat-samsung/include/plat/devs.h
+++ b/arch/arm/plat-samsung/include/plat/devs.h
@@ -8,7 +8,11 @@
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
-*/
+ */
+
+#ifndef __PLAT_SAMSUNG_DEVS_H
+#define __PLAT_SAMSUNG_DEVS_H
+
 #include <linux/platform_device.h>
 
 struct s3c24xx_uart_resources {
@@ -128,3 +132,5 @@ extern struct platform_device s3c_device_ac97;
  */
 extern void *s3c_set_platdata(void *pd, size_t pdsize,
 			      struct platform_device *pdev);
+
+#endif

And s3c_hsmmc_setname() function could be used in cpu.c file

Thanks
Jaehoon Chung
>>>> ---
>>>>  arch/arm/plat-samsung/include/plat/sdhci.h |   19 ++++++++
>>>>  drivers/mmc/host/sdhci-s3c.c               |   68
>>>> ++++++++++++++++++++++++++++
>>>>  2 files changed, 87 insertions(+), 0 deletions(-)
>>>>
>>>> diff --git a/arch/arm/plat-samsung/include/plat/sdhci.h
>>>>         
> b/arch/arm/plat-
>   
>>>> samsung/include/plat/sdhci.h
>>>> index 30844c2..7c75ee3 100644
>>>> --- a/arch/arm/plat-samsung/include/plat/sdhci.h
>>>> +++ b/arch/arm/plat-samsung/include/plat/sdhci.h
>>>> @@ -15,6 +15,8 @@
>>>>  #ifndef __PLAT_S3C_SDHCI_H
>>>>  #define __PLAT_S3C_SDHCI_H __FILE__
>>>>
>>>> +#include <plat/devs.h>
>>>> +
>>>>  struct platform_device;
>>>>  struct mmc_host;
>>>>  struct mmc_card;
>>>> @@ -288,4 +290,21 @@ static inline void s5pv210_default_sdhci3(void) {
>>>>         
> }
>   
>>>>  #endif /* CONFIG_S5PV210_SETUP_SDHCI */
>>>>
>>>> +/* re-define device name depending on support. */
>>>> +static inline void s3c_hsmmc_setname(char *name)
>>>> +{
>>>> +#ifdef CONFIG_S3C_DEV_HSMMC
>>>> +     s3c_device_hsmmc0.name = name;
>>>> +#endif
>>>> +#ifdef CONFIG_S3C_DEV_HSMMC1
>>>> +     s3c_device_hsmmc1.name = name;
>>>> +#endif
>>>> +#ifdef CONFIG_S3C_DEV_HSMMC2
>>>> +     s3c_device_hsmmc2.name = name;
>>>> +#endif
>>>> +#ifdef CONFIG_S3C_DEV_HSMMC3
>>>> +     s3c_device_hsmmc3.name = name;
>>>> +#endif
>>>> +}
>>>> +
>>>>  #endif /* __PLAT_S3C_SDHCI_H */
>>>>         
>>> It would be helpful to me if you could separate platform and driver
>>>       
> patches.
>   
i will seperate platform and driver patches, then i will resend to
mailing list.
>>> And if you want to add s3c_hsmmc_setname(), please send together code
>>>       
> that
>   
>>> it is used.
>>>
>>>       
>>>> diff --git a/drivers/mmc/host/sdhci-s3c.c
>>>>         
> b/drivers/mmc/host/sdhci-s3c.c
>   
>>>> index 71ad416..3927793 100644
>>>> --- a/drivers/mmc/host/sdhci-s3c.c
>>>> +++ b/drivers/mmc/host/sdhci-s3c.c
>>>>         
>
> (snip)
>
>   
>>> How do you think about using quirk to separate S5PV310 case as
>>>       
> following?
>   
>>> I think this is more general method in here...And will be submitted soon
>>> after fixing something.
>>>       
>> What's the meaning of "general method"?
>>
>>     
> I'd like to ask you why there is quirk in sdmmc driver.
>
>   
>> and how/where do you set the host->quirks? when board or platform set
>> the these quirks? who know it uses nonstandard quirk?
>>     
>
> How about following?
>
> static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
> ...
> +	if (pdev->id_entry->driver_data == TYPE_S5PV310)
> +		host->quirks |= SDHCI_QUIRK_BROKEN_CLOCK_DIVIDER;
> ...
>
>   
>> In case s5pc210 don't have standard host controller. it's more clear
>> to use own functions instead of quirks.
>>
>>     
> Why do we add another callback function?
>
>   
>>> From: Hyuk Lee <hyuk1.lee@samsung.com>
>>>
>>> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
>>> index 71ad416..1ac2f36 100644
>>> --- a/drivers/mmc/host/sdhci-s3c.c
>>> +++ b/drivers/mmc/host/sdhci-s3c.c
>>>       
>
> (snip)
>
>   
>>> @@ -221,6 +257,11 @@ static unsigned int sdhci_s3c_get_min_clock(struct
>>> sdhci_host *host)
>>>        unsigned int delta, min = UINT_MAX;
>>>        int src;
>>>
>>> +       /* There is only one clock source(sclk) if there is no clock
>>>       
> divider
>   
>>> +        * in the host controller */
>>> +       if(host->quirks & SDHCI_QUIRK_BROKEN_CLOCK_DIVIDER)
>>> +               return clk_round_rate(ourhost->clk_bus[2], 400000);
>>>       
>> what's the clk_bus[2]?
>>
>>     
> Should be clk_bus[ourhost->cur_clk]
>
> (snip)
>
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
>
>
>   

