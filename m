From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 1/3] mmc: sdhci-bcm-kona: Remove unneeded version.h inclusion
Date: Fri, 23 Aug 2013 14:14:08 +0530
Message-ID: <CAK9yfHw_OMspDHN-g+b=FfqqRbKfUWDqR5_r4Tanzpn1a7mWSg@mail.gmail.com>
References: <1373263914-18050-1-git-send-email-sachin.kamat@linaro.org>
	<51E9A207.70306@broadcom.com>
	<CAK9yfHwJjwsCq-oAjj3Cp9kFQhxnAfUfpwv9FzcDn-tGLav4xQ@mail.gmail.com>
	<52164E8D.7070404@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49]:57743 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753986Ab3HWIoJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 23 Aug 2013 04:44:09 -0400
Received: by mail-oa0-f49.google.com with SMTP id n10so433516oag.8
        for <linux-mmc@vger.kernel.org>; Fri, 23 Aug 2013 01:44:09 -0700 (PDT)
In-Reply-To: <52164E8D.7070404@broadcom.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Christian Daudt <csd@broadcom.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Patch Tracking <patches@linaro.org>

Hi Christian,

On 22 August 2013 23:16, Christian Daudt <csd@broadcom.com> wrote:
> On 13-08-21 11:07 PM, Sachin Kamat wrote:
>>
>> On 20 July 2013 02:01, Christian Daudt <csd@broadcom.com> wrote:
>>>
>>> On 13-07-07 11:11 PM, Sachin Kamat wrote:
>>>>
>>>> version.h header inclusion is not necessary as detected by
>>>> versioncheck.
>>>>
>>>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>>>> ---
>>>>    drivers/mmc/host/sdhci-bcm-kona.c |    1 -
>>>>    1 file changed, 1 deletion(-)
>>>>
>>>> diff --git a/drivers/mmc/host/sdhci-bcm-kona.c
>>>> b/drivers/mmc/host/sdhci-bcm-kona.c
>>>> index 87175f9..bca6d55 100644
>>>> --- a/drivers/mmc/host/sdhci-bcm-kona.c
>>>> +++ b/drivers/mmc/host/sdhci-bcm-kona.c
>>>> @@ -24,7 +24,6 @@
>>>>    #include <linux/of.h>
>>>>    #include <linux/of_device.h>
>>>>    #include <linux/of_gpio.h>
>>>> -#include <linux/version.h>
>>>>    #include <linux/mmc/slot-gpio.h>
>>>>      #include "sdhci-pltfm.h"
>>>
>>> Acked-by: Christian Daudt <csd@broadcom.com>
>>>
>>>   thanks,
>>>     csd
>>>
>>>
>> Ping Chris..
>>
>>
> Hi Sachin,
>  I can pull this one into bcm tree, as I already have other patches for that
> file in there. I'm also pulling in patch 3.

Sounds good. Please go ahead. Thanks.


Patch 2 was already covered by
> this commit which is already in my pull request to armsoc so I'll drop it:
> Author: Markus Mayer <markus.mayer@linaro.org>
> Date:   Wed Aug 7 15:39:59 2013 -0700
>
>     mmc: sdhci-bcm-kona: make linker-section warning go away
>
>     This change makes the following build warning go away:
>     [...]
>       LINK    vmlinux
>       LD      vmlinux.o
>       MODPOST vmlinux.o
>     WARNING: modpost: Found 2 section mismatch(es).
>     To see full details build your kernel with:
>     'make CONFIG_DEBUG_SECTION_MISMATCH=y'
>
>     Signed-off-by: Markus Mayer <markus.mayer@linaro.org>
>     Reviewed-by: Christian Daudt <csd@broadcom.com>
>     Reviewed-by: Matt Porter <matt.porter@linaro.org>
>
>
>
>  thanks,
>    csd
>
>



-- 
With warm regards,
Sachin
