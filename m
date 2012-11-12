From: Konstantin Dorfman <kdorfman@codeaurora.org>
Subject: Re: [PATCH v2] mmc: fix async request mechanism for sequential read
 scenarios
Date: Mon, 12 Nov 2012 14:42:45 +0200
Message-ID: <50A0EEC5.7030000@codeaurora.org>
References: <n@samsung.com> <1351780852-1293-1-git-send-email-kdorfman@codeaurora.org> <5098CD18.3080807@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:58648 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592Ab2KLMmz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Nov 2012 07:42:55 -0500
In-Reply-To: <5098CD18.3080807@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org, per.lkml@gmail.com

Hello Jaehoon,

On 11/06/2012 10:40 AM, Jaehoon Chung wrote:
> Hi Konstantin,
> 
...
>>  
>> @@ -1406,6 +1401,7 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
>>  		ret = 0;
>>  		goto out;
>>  	}
>> +	mq->flags &= ~MMC_QUEUE_NEW_REQUEST;
> I didn't understand why clearing the MMC_QUEUE_NEW_REQUEST.
> Sorry, Could you explain to me? I didn't read the previous patch.
> If mentioned about this before, I will read them.
> 
> Best Regards,
> Jaehoon Chung

This flag used as indication that mmc_blk_issue_rw_rq() returned because
of new request notification, so the flow continues rollback to fetch new
request from mmc_queue_thread() (queue.c).

Before calling the mmc_blk_issue_rw_rq() need to clear the flag to be
able to trigger it again and to differ the case with new packet
notification from legacy flow (when returning from mmc_blk_issue_rw_rq()
because request is done/finished.

Thanks,

-- 
Konstantin Dorfman,
QUALCOMM ISRAEL, on behalf of Qualcomm Innovation Center,
Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
