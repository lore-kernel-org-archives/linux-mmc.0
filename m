From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: One bug of SDHCI driver
Date: Tue, 15 Jul 2014 13:40:42 +0900
Message-ID: <53C4B0CA.1020504@samsung.com>
References: <53B249A4.2040404@linux.intel.com>
 <53B57B23.4020607@linux.intel.com> <53B61403.7040602@samsung.com>
 <53B968EB.60401@linux.intel.com> <53BC164E.4040900@linux.intel.com>
 <86zjgcjckz.fsf@void.printf.net> <53C497FD.2070000@linux.intel.com>
 <53C4AAB5.4070700@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:53452 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972AbaGOEkq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Jul 2014 00:40:46 -0400
In-reply-to: <53C4AAB5.4070700@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>, Chris Ball <chris@printf.net>
Cc: ulf.hansson@linaro.org, tgih.jun@samsung.com, aaron.lu@intel.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, jackey.shen@amd.com, gregkh@linuxfoundation.org

From: Chris Ball <chris@printf.net>
Subject: [PATCH] mmc: core: sdio: Fix unconditional wake_up_process() on sdio thread

781e989cf59 ("mmc: sdhci: convert to new SDIO IRQ handling") and
bf3b5ec66bd ("mmc: sdio_irq: rework sdio irq handling") disabled
the use of our own custom threaded IRQ handler, but left in an
unconditional wake_up_process() on that handler at resume-time.

Reported-by: Fu, Zhonghui <zhonghui.fu@linux.intel.com>
[Patch suggested by Jaehoon Chung]
Signed-off-by: Chris Ball <chris@printf.net>
---
 drivers/mmc/core/sdio.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index e636d9e..11cc4e0 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -992,7 +992,8 @@ static int mmc_sdio_resume(struct mmc_host *host)
 		}
 	}
 
-	if (!err && host->sdio_irqs)
+	if (!err && host->sdio_irqs &&
+			!(host->caps2 & MMC_CAP2_SDIO_IRQ_NOTHREAD))
 		wake_up_process(host->sdio_irq_thread);
 	mmc_release_host(host);
 
-- 
1.7.9.5

On 07/15/2014 01:14 PM, Jaehoon Chung wrote:
> On 07/15/2014 11:54 AM, Fu, Zhonghui wrote:
>>
>> Hi,
>>
>> The data type of "host" is "struct mmc_host", and there is not "quirks" member in this structure.
> Sorry for wrong typo.
> You use the "host->caps2" instead of "host->quirks".
> 
> 
> Best Regards,
> Jaehoon Chung
>>
>>
>> Thanks,
>> Zhonghui
>>
>> On 2014/7/14 21:26, Chris Ball wrote:
>>> Hi Zhonghui,
>>>
>>> On Tue, Jul 08 2014, Fu, Zhonghui wrote:
>>>> Why add "mmc->caps2 |= MMC_CAP2_SDIO_IRQ_NOTHREAD;" ?  How to fix this bug?
>>>>
>>>> Could you please give out some idea about this bug?
>>> Jaehoon already gave you a patch to fix this bug.  Here it is again in
>>> proper patch form.  Please can you test it and let us know whether it
>>> fixes the crash?  Thanks.
>>>
>>>
>>> From: Chris Ball <chris@printf.net>
>>> Subject: [PATCH] mmc: core: sdio: Fix unconditional wake_up_process() on sdio thread
>>>
>>> 781e989cf59 ("mmc: sdhci: convert to new SDIO IRQ handling") and
>>> bf3b5ec66bd ("mmc: sdio_irq: rework sdio irq handling") disabled
>>> the use of our own custom threaded IRQ handler, but left in an
>>> unconditional wake_up_process() on that handler at resume-time.
>>>
>>> Reported-by: Fu, Zhonghui <zhonghui.fu@linux.intel.com>
>>> [Patch suggested by Jaehoon Chung]
>>> Signed-off-by: Chris Ball <chris@printf.net>
>>> ---
>>>  drivers/mmc/core/sdio.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
>>> index e636d9e..2a128e2 100644
>>> --- a/drivers/mmc/core/sdio.c
>>> +++ b/drivers/mmc/core/sdio.c
>>> @@ -992,7 +992,8 @@ static int mmc_sdio_resume(struct mmc_host *host)
>>>  		}
>>>  	}
>>>  
>>> -	if (!err && host->sdio_irqs)
>>> +	if (!err && host->sdio_irqs &&
>>> +	    !(host->quirks & MMC_CAP2_SDIO_IRQ_NOTHREAD))
>>>  		wake_up_process(host->sdio_irq_thread);
>>>  	mmc_release_host(host);
>>>  
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

