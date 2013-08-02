From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 1/3] mmc: sdhci-bcm-kona: Remove unneeded version.h inclusion
Date: Fri, 2 Aug 2013 14:20:57 +0530
Message-ID: <CAK9yfHyKQbw2i3yruM8RbGYU1COkYA_SPqThFhx737d_R0sWiw@mail.gmail.com>
References: <1373263914-18050-1-git-send-email-sachin.kamat@linaro.org>
	<51E9A207.70306@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:53193 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758090Ab3HBIu7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Aug 2013 04:50:59 -0400
Received: by mail-ob0-f178.google.com with SMTP id ef5so715472obb.9
        for <linux-mmc@vger.kernel.org>; Fri, 02 Aug 2013 01:50:58 -0700 (PDT)
In-Reply-To: <51E9A207.70306@broadcom.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, patches@linaro.org

On 20 July 2013 02:01, Christian Daudt <csd@broadcom.com> wrote:
> On 13-07-07 11:11 PM, Sachin Kamat wrote:
>>
>> version.h header inclusion is not necessary as detected by
>> versioncheck.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> ---
>>   drivers/mmc/host/sdhci-bcm-kona.c |    1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-bcm-kona.c
>> b/drivers/mmc/host/sdhci-bcm-kona.c
>> index 87175f9..bca6d55 100644
>> --- a/drivers/mmc/host/sdhci-bcm-kona.c
>> +++ b/drivers/mmc/host/sdhci-bcm-kona.c
>> @@ -24,7 +24,6 @@
>>   #include <linux/of.h>
>>   #include <linux/of_device.h>
>>   #include <linux/of_gpio.h>
>> -#include <linux/version.h>
>>   #include <linux/mmc/slot-gpio.h>
>>     #include "sdhci-pltfm.h"
>
> Acked-by: Christian Daudt <csd@broadcom.com>
>
>  thanks,
>    csd
>
>
Chris,

Can you please check this series?


-- 
With warm regards,
Sachin
