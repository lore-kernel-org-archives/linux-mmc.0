From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: duplicated trial with same freq when
 mmc_rescan_try_freq()
Date: Thu, 12 May 2011 20:18:27 +0900
Message-ID: <4DCBC203.5070102@samsung.com>
References: <4DCB97F3.9060704@samsung.com>
 <8A2FC72B45BB5A4C9F801431E06AE48F1154C484@039-SN1MPN1-005.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:8473 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753728Ab1ELLSV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 12 May 2011 07:18:21 -0400
Received: from epcpsbgm1.samsung.com (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LL200APZY2I4J20@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 12 May 2011 20:18:19 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LL200GIXY2JZY@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 12 May 2011 20:18:19 +0900 (KST)
In-reply-to: <8A2FC72B45BB5A4C9F801431E06AE48F1154C484@039-SN1MPN1-005.039d.mgd.msft.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Huang Changming-R66093 <R66093@freescale.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, "andy.ross@windriver.com" <andy.ross@windriver.com>

This patch didn't point that..

Huang Changming-R66093 wrote:
> The required min frequency (f_min) is 400KHz during identify stage, is it necessary to use the  frequency table (freqs[], including 300KHz, 200KHz and 100KHz)?

i known that some card needs lower than 400KHz..so this approach is not problem..
But i mentions that try to init two times with same frequency.

Regards,
Jaehoon Chung

> 
> Thanks and Best Regards
> Jerry Huang
> 
> 
>> -----Original Message-----
>> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
>> owner@vger.kernel.org] On Behalf Of Jaehoon Chung
>> Sent: Thursday, May 12, 2011 4:19 PM
>> To: linux-mmc@vger.kernel.org
>> Cc: Chris Ball; Kyungmin Park; andy.ross@windriver.com
>> Subject: [PATCH] mmc: duplicated trial with same freq when
>> mmc_rescan_try_freq()
>>
>> when running mmc_rescan_try_freq(), try to init two times with last
>> frequency.
>> For example, assume that host->f_min is 400KHz, we can find the below
>> message.
>>
>> mmc1: mmc_rescan_try_freq: trying to init card at 400000 Hz
>> mmc1: mmc_rescan_try_freq: trying to init card at 400000 Hz
>>
>> i didn't find to mention about this..why try to init the two times with
>> same frequency?
>> Is there any reason? If i missed the history, plz let me know them.
>>
>> I think that trial is not necessary. Trial needs to running with other
>> frequency.
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>>  drivers/mmc/core/core.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c index
>> 61c6c0b..a330c58 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -1618,7 +1618,7 @@ void mmc_rescan(struct work_struct *work)
>>  	for (i = 0; i < ARRAY_SIZE(freqs); i++) {
>>  		if (!mmc_rescan_try_freq(host, max(freqs[i], host->f_min)))
>>  			break;
>> -		if (freqs[i] < host->f_min)
>> +		if (freqs[i] <= host->f_min)
>>  			break;
>>  	}
>>  	mmc_release_host(host);
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

