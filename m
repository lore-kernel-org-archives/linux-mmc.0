From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2] mmc: support BKOPS feature for eMMC
Date: Wed, 16 Nov 2011 17:36:01 +0900
Message-ID: <4EC375F1.8080001@samsung.com>
References: <4EB11B6B.2010909@samsung.com>
 <5D8008F58939784290FAB48F549751984E50599817@shsmsx502.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:57807 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754698Ab1KPIgQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Nov 2011 03:36:16 -0500
Received: from epcpsbgm2.samsung.com (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LUQ00GM2VWFOHE0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 16 Nov 2011 17:36:15 +0900 (KST)
Received: from [165.213.219.108] by mmp1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0LUQ00AGQVWE95D0@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 16 Nov 2011 17:36:15 +0900 (KST)
In-reply-to: <5D8008F58939784290FAB48F549751984E50599817@shsmsx502.ccr.corp.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Sebastian Rasmussen <sebras@gmail.com>, Per Forlin <per.lkml@gmail.com>, "svenkatr@ti.com" <svenkatr@ti.com>

Hi Chuanxiao,

On 11/11/2011 03:51 PM, Dong, Chuanxiao wrote:

> Hi Jaehoon,
> 
>> -----Original Message-----
>> From: Jaehoon Chung [mailto:jh80.chung@samsung.com]
>> Sent: Wednesday, November 02, 2011 6:29 PM
>> To: linux-mmc
>> Cc: Chris Ball; Kyungmin Park; Hanumath Prasad; Sebastian Rasmussen; Per Forlin;
>> svenkatr@ti.com; Dong, Chuanxiao
>> Subject: [PATCH v2] mmc: support BKOPS feature for eMMC
>>
>> Enable eMMC background operations (BKOPS) feature.
>>
>> If URGENT_BKOPS is set after a response, note that BKOPS
>> are required. After all I/O requests are finished, run
>> BKOPS if required. Should read/write operations be requested
>> during BKOPS, first issue HPI to interrupt the ongoing BKOPS
>> and then service the request.
>>
>> If you want to enable this feature, set MMC_CAP2_BKOPS.
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> CC: Hanumath Prasad <hanumath.prasad@stericsson.com>
>>
>> ---
>> Changelog V2:
>> 	- Use EXCEPTION_STATUS instead of URGENT_BKOPS
>> 	- Add function to check Exception_status(for eMMC4.5)
>> 	- remove unnecessary code.
>>
>>  drivers/mmc/card/block.c   |    9 +++++
>>  drivers/mmc/card/queue.c   |    4 ++
>>  drivers/mmc/core/core.c    |   87
>> ++++++++++++++++++++++++++++++++++++++++++++
>>  drivers/mmc/core/mmc.c     |    9 ++++-
>>  drivers/mmc/core/mmc_ops.c |    4 ++
>>  include/linux/mmc/card.h   |   12 ++++++
>>  include/linux/mmc/core.h   |    3 ++
>>  include/linux/mmc/host.h   |    1 +
>>  include/linux/mmc/mmc.h    |   14 +++++++
>>  9 files changed, 142 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>> index a1cb21f..fbfb405 100644
>> --- a/drivers/mmc/card/block.c
>> +++ b/drivers/mmc/card/block.c
>> @@ -1192,6 +1192,15 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue
>> *mq, struct request *rqc)
>>  		case MMC_BLK_SUCCESS:
>>  		case MMC_BLK_PARTIAL:
>>  			/*
>> +			 * Check BKOPS urgency from each R1 response
>> +			 */
>> +			if (mmc_card_mmc(card) &&
>> +				(brq->cmd.resp[0] & R1_EXCEPTION_EVENT)) {
>> +				if (mmc_is_exception_event(card,
>> +						EXT_CSD_URGENT_BKOPS))
>> +					mmc_card_set_need_bkops(card);
>> +			}
>> +			/*

> Have you thought about moving this into mmc_wait_for_req_done()? We can check if the command is a R1 or R1B or not, and set BKOPS bit in there if needed. I was just thinking if we put such code here, we may only cover the successful scenario but not for the failed cases. Putting in mmc_wait_for_req_done can cover all cases.


Thanks for comment..I will move this into mmc_wait_for_req_done..and i will test.
Then i will modify and resend the patch with your opinion

Best Regards,
Jaehoon Chung

> 
> Thanks
> Chuanxiao
> 


