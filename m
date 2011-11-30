From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v3] mmc: support BKOPS feature for eMMC
Date: Wed, 30 Nov 2011 13:09:56 +0900
Message-ID: <4ED5AC94.9020609@samsung.com>
References: <4EC45A39.5030706@samsung.com> <4ED4CE04.4070403@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:29663 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751996Ab1K3EKB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Nov 2011 23:10:01 -0500
Received: from epcpsbgm1.samsung.com (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LVG00FBMGWNDGJ0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 30 Nov 2011 13:09:59 +0900 (KST)
Received: from [165.213.219.108] by mmp1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0LVG00KSTGWM7MV0@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 30 Nov 2011 13:09:59 +0900 (KST)
In-reply-to: <4ED4CE04.4070403@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Per Forlin <per.lkml@gmail.com>, Sebastian Rasmussen <sebras@gmail.com>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, "svenkatr@ti.com" <svenkatr@ti.com>

Hi Adrian.

On 11/29/2011 09:20 PM, Adrian Hunter wrote:

> On 17/11/11 02:50, Jaehoon Chung wrote:
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
>> Future considerations
>>  * Check BKOPS_LEVEL=1 and start BKOPS in a preventive manner.
>>  * Interrupt ongoing BKOPS before powering off the card.
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> CC: Hanumath Prasad <hanumath.prasad@stericsson.com>
>> ---
>> Changelog V3:
>> 	- move the bkops setting's location in mmc_blk_issue_rw_rq
>> 	- modify condition checking
>> 	- bkops_en is assigned ext_csd[EXT_CSD_BKOPS_EN] instead of "1"
>> 	- remove the unused code
>> 	- change pr_debug instead of pr_warn in mmc_send_hpi_cmd
>> 	- Add the Future consideration suggested by Per
>> 	
>> Changelog V2:
>> 	- Use EXCEPTION_STATUS instead of URGENT_BKOPS
>> 	- Add function to check Exception_status(for eMMC4.5)
>> 	- remove unnecessary code.
>>
> 
> The main problem with bkops is:
> 
> 	If the status is at level 3 ("critical"), some operations
> 	may extend beyond their original timeouts due to maintenance
> 	operations which cannot be delayed anymore.
> 
> This means:
> 
> 	1. at level 3 either bkops are run or the timeout of the next
> 	(data?) operation is extended
> 
> 	2. at level 3 either the bkops must not be interrupted or the
> 	level must be rechecked after interruption and bkops run again
> 	if the level is still 3


Thanks for your comment..I will consider to solve this problem.

Best Regards,
Jaehoon Chung

> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


