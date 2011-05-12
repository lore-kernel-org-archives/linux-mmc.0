From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: fixed wrong SD card detection
Date: Thu, 12 May 2011 14:14:22 +0900
Message-ID: <4DCB6CAE.4010607@samsung.com>
References: <4DC3C1A8.1050104@samsung.com>
 <8A2FC72B45BB5A4C9F801431E06AE48F1154BAB5@039-SN1MPN1-005.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:8659 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752775Ab1ELFOQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 12 May 2011 01:14:16 -0400
Received: from epcpsbgm2.samsung.com (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LL2002O7H7GOBJ0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 12 May 2011 14:14:14 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LL200FF3H7QYY@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 12 May 2011 14:14:14 +0900 (KST)
In-reply-to: <8A2FC72B45BB5A4C9F801431E06AE48F1154BAB5@039-SN1MPN1-005.039d.mgd.msft.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Huang Changming-R66093 <R66093@freescale.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>

Hi Huang.

Thanks for your comments. but this is not my hardware issue. :)
But i found out your patch "[PATCH 3/3] SDHC/MMC: add f_min to mmc_power_on"

I think that related with this problem.
I will test then share the results

Best regards,
Jaehoon Chung

Huang Changming-R66093 wrote:
> I don't see this.
> Maybe that is your hardware issue.
> 
> Thanks and Best Regards
> Jerry Huang
> 
> 
>> -----Original Message-----
>> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
>> owner@vger.kernel.org] On Behalf Of Jaehoon Chung
>> Sent: Friday, May 06, 2011 5:39 PM
>> To: linux-mmc@vger.kernel.org
>> Cc: Chris Ball; Kyungmin Park
>> Subject: [PATCH] mmc: fixed wrong SD card detection
>>
>> This patch added mmc_power_off after mmc_attach_sd()
>>
>> i found that didn't detect the second card insert.(using SDHCI) you can
>> see the below log.
>>
>> i want to know that somebody know this issue...
>>
>> ->first card inserted (correct card detect)
>> # mmc1: new SDHC card at address e624
>> mmcblk1: mmc1:e624 SU04G 3.69 GiB
>>  mmcblk1: p1
>> #
>> # mmc1: card e624 removed
>> -> second card inserted
>> mmc1: error -110 whilst initialising SD card
>> mmc1: Card removed during transfer!
>> mmc1: Resetting controller.
>> -> third card inserted
>> mmc1: new SDHC card at address e624
>> mmcblk1: mmc1:e624 SU04G 3.69 GiB
>>  mmcblk1: p1
>>
>> I added mmc_power_off() after only mmc_attach_sd().
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> Signed-off-by: kyungmin Park <kyungmin.park@samsung.com>
>> ---
>>  drivers/mmc/core/core.c |    4 +++-
>>  1 files changed, 3 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c index
>> 1dbc185..d5d8ac0 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -1522,8 +1522,10 @@ static int mmc_rescan_try_freq(struct mmc_host
>> *host, unsigned freq)
>>  	/* Order's important: probe SDIO, then SD, then MMC */
>>  	if (!mmc_attach_sdio(host))
>>  		return 0;
>> -	if (!mmc_attach_sd(host))
>> +	if (!mmc_attach_sd(host)) {
>> +		mmc_power_off(host);
>>  		return 0;
>> +	}
>>  	if (!mmc_attach_mmc(host))
>>  		return 0;
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org More majordomo info at
>> http://vger.kernel.org/majordomo-info.html
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

