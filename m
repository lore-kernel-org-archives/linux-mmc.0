From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH v2 2/2] sdhci-of-arasan: Set controller to test mode when
 Card Detection is broken.
Date: Fri, 26 Aug 2016 17:50:43 +0800
Message-ID: <0fa180a6-5634-bac9-f933-7d68eef84796@rock-chips.com>
References: <1472166111-28872-1-git-send-email-zach.brown@ni.com>
 <1472166111-28872-2-git-send-email-zach.brown@ni.com>
 <57C000FF.3090307@topic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <57C000FF.3090307-Oq418RWZeHk@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mike Looijmans <mike.looijmans-Oq418RWZeHk@public.gmane.org>, Zach Brown <zach.brown-acOepvfBmUk@public.gmane.org>, adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 2016/8/26 16:42, Mike Looijmans wrote:
> On 26-08-16 01:01, Zach Brown wrote:
>> The sdhci controller on xilinx zynq devices will not function unless
>> the CD bit is provided. http://www.xilinx.com/support/answers/61064.html
>> In cases where it is impossible to provide the CD bit in hardware,
>> setting the controller to test mode and then setting inserted to true
>> will get the controller to function without the CD bit.
>>
>> When the device has the property broken-cd the driver changes the
>> controller to test mode and sets test inserted to true to make the
>> controller function.
>>
>> Signed-off-by: Zach Brown <zach.brown-acOepvfBmUk@public.gmane.org>
>> ---
>>   drivers/mmc/host/sdhci-of-arasan.c | 17 ++++++++++++++++-
>>   drivers/mmc/host/sdhci.h           |  2 ++
>>   2 files changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-of-arasan.c
>> b/drivers/mmc/host/sdhci-of-arasan.c
>> index e0f193f..3798a3b 100644
>> --- a/drivers/mmc/host/sdhci-of-arasan.c
>> +++ b/drivers/mmc/host/sdhci-of-arasan.c
>> @@ -26,6 +26,7 @@
>>   #include <linux/phy/phy.h>
>>   #include <linux/regmap.h>
>>   #include "sdhci-pltfm.h"
>> +#include <linux/of.h>
>
> Not needed.
>
>>   #define SDHCI_ARASAN_CLK_CTRL_OFFSET    0x2c
>>   #define SDHCI_ARASAN_VENDOR_REGISTER    0x78
>> @@ -203,12 +204,26 @@ static void
>> sdhci_arasan_hs400_enhanced_strobe(struct mmc_host *mmc,
>>       writel(vendor, host->ioaddr + SDHCI_ARASAN_VENDOR_REGISTER);
>>   }
>>
>> +void sdhci_arasan_reset(struct sdhci_host *host, u8 mask)
>> +{
>> +    u8 ctrl;
>> +
>> +    sdhci_reset(host, mask);
>> +
>> +    if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) {
>> +        ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
>> +        ctrl |= SDHCI_CTRL_CDTEST_INS |
>> +            SDHCI_CTRL_CDTEST_EN;
>> +        sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
>> +    }
>> +}

Although I don't have a "broken-cd" arasan controller,
but are you suring that all the broken-cd arasan controller
need to set these bit either? It seems your case is vendor specific?:)

>> +
>>   static struct sdhci_ops sdhci_arasan_ops = {
>>       .set_clock = sdhci_arasan_set_clock,
>>       .get_max_clock = sdhci_pltfm_clk_get_max_clock,
>>       .get_timeout_clock = sdhci_arasan_get_timeout_clock,
>>       .set_bus_width = sdhci_set_bus_width,
>> -    .reset = sdhci_reset,
>> +    .reset = sdhci_arasan_reset,
>>       .set_uhs_signaling = sdhci_set_uhs_signaling,
>>   };
>>
>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>> index 0411c9f..8d92d6e9 100644
>> --- a/drivers/mmc/host/sdhci.h
>> +++ b/drivers/mmc/host/sdhci.h
>> @@ -84,6 +84,8 @@
>>   #define   SDHCI_CTRL_ADMA32    0x10
>>   #define   SDHCI_CTRL_ADMA64    0x18
>>   #define   SDHCI_CTRL_8BITBUS    0x20
>> +#define  SDHCI_CTRL_CDTEST_INS   0x40
>> +#define  SDHCI_CTRL_CDTEST_EN     0x80
>>
>>   #define SDHCI_POWER_CONTROL    0x29
>>   #define  SDHCI_POWER_ON        0x01
>
> Looks okay, tested it and appears to work just as well as a tie-off in
> logic.
>
> Tested-by: mike.looijmans-Oq418RWZeHk@public.gmane.org
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Best Regards
Shawn Lin

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
