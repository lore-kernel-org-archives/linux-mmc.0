From: Balaji T K <balajitk@ti.com>
Subject: Re: [PATCH v2 6/6] mmc: omap_hsmmc: split omap-dma header file
Date: Mon, 19 May 2014 17:23:42 +0530
Message-ID: <5379F0C6.6070004@ti.com>
References: <1399654013-28262-1-git-send-email-balajitk@ti.com> <1399654013-28262-7-git-send-email-balajitk@ti.com> <20140516214116.GM12881@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35442 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753614AbaESLxw (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 19 May 2014 07:53:52 -0400
In-Reply-To: <20140516214116.GM12881@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-mmc@vger.kernel.org, chris@printf.net, ulf.hansson@linaro.org, linux-omap@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>

On Saturday 17 May 2014 03:11 AM, Tony Lindgren wrote:
> * Balaji T K <balajitk@ti.com> [140509 09:47]:
>> moving dmaengine consumer specific function to omap-dmaengine.h
>> to Resolve build failure seen with sh-allmodconfig:
>>      include/linux/omap-dma.h:171:8: error: expected identifier before numeric constant
>>      make[4]: *** [drivers/mmc/host/omap_hsmmc.o] Error 1
>>
>> Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Signed-off-by: Balaji T K <balajitk@ti.com>
>> ---
>>   drivers/mmc/host/omap_hsmmc.c  |    2 +-
>>   include/linux/omap-dma.h       |   19 +------------------
>>   include/linux/omap-dmaengine.h |   21 +++++++++++++++++++++
>>   3 files changed, 23 insertions(+), 19 deletions(-)
>>   create mode 100644 include/linux/omap-dmaengine.h
>>
>> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
>> index cba71d6..6b7b755 100644
>> --- a/drivers/mmc/host/omap_hsmmc.c
>> +++ b/drivers/mmc/host/omap_hsmmc.c
>> @@ -31,7 +31,7 @@
>>   #include <linux/of.h>
>>   #include <linux/of_gpio.h>
>>   #include <linux/of_device.h>
>> -#include <linux/omap-dma.h>
>> +#include <linux/omap-dmaengine.h>
>>   #include <linux/mmc/host.h>
>>   #include <linux/mmc/core.h>
>>   #include <linux/mmc/mmc.h>
>> diff --git a/include/linux/omap-dma.h b/include/linux/omap-dma.h
>> index 41a13e7..999f52d 100644
>> --- a/include/linux/omap-dma.h
>> +++ b/include/linux/omap-dma.h
>> @@ -1,23 +1,6 @@
>> -/*
>> - * OMAP DMA Engine support
>> - *
>> - * This program is free software; you can redistribute it and/or modify
>> - * it under the terms of the GNU General Public License version 2 as
>> - * published by the Free Software Foundation.
>> - */
>>   #ifndef __LINUX_OMAP_DMA_H
>>   #define __LINUX_OMAP_DMA_H
>> -
>> -struct dma_chan;
>> -
>> -#if defined(CONFIG_DMA_OMAP) || defined(CONFIG_DMA_OMAP_MODULE)
>> -bool omap_dma_filter_fn(struct dma_chan *, void *);
>> -#else
>> -static inline bool omap_dma_filter_fn(struct dma_chan *c, void *d)
>> -{
>> -	return false;
>> -}
>> -#endif
>> +#include <linux/omap-dmaengine.h>
>
> Can't the drivers needing this include it directly?
>

Yes, I have converted omap_hsmmc as part of this patch.
Due to lack of bandwidth, I haven't touched upon all other drivers that include
omap-dma.h. Once that is done in other subsystem after this patch gets merged,
this include can then be removed from omap-dma.h

> Also, has this been tested with make randconfig? Changes like
> this can easily cause problems elsewhere..

May be I am missing something, Can you please elaborate ?
This patch is based on the discussion [1]
I just moved the dma consumer specific things needed by users
to a separate file and include the same file in place so that other users
can be converted one at a time.

[1]
https://lkml.org/lkml/2014/1/19/16
>
> Regards,
>
> Tony
>
>>   /*
>>    *  Legacy OMAP DMA handling defines and functions
>> diff --git a/include/linux/omap-dmaengine.h b/include/linux/omap-dmaengine.h
>> new file mode 100644
>> index 0000000..2b0b6aa
>> --- /dev/null
>> +++ b/include/linux/omap-dmaengine.h
>> @@ -0,0 +1,21 @@
>> +/*
>> + * OMAP DMA Engine support
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +#ifndef __LINUX_OMAP_DMAENGINE_H
>> +#define __LINUX_OMAP_DMAENGINE_H
>> +
>> +struct dma_chan;
>> +
>> +#if defined(CONFIG_DMA_OMAP) || defined(CONFIG_DMA_OMAP_MODULE)
>> +bool omap_dma_filter_fn(struct dma_chan *, void *);
>> +#else
>> +static inline bool omap_dma_filter_fn(struct dma_chan *c, void *d)
>> +{
>> +	return false;
>> +}
>> +#endif
>> +#endif /* __LINUX_OMAP_DMAENGINE_H */
>> --
>> 1.7.5.4
>>

