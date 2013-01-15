From: Konstantin Dorfman <kdorfman@codeaurora.org>
Subject: Re: [PATCH v5] mmc: fix async request mechanism for sequential read
 scenarios
Date: Tue, 15 Jan 2013 14:00:48 +0200
Message-ID: <50F544F0.9060306@codeaurora.org>
References: <n@samsung.com> <1356513966-24945-1-git-send-email-kdorfman@codeaurora.org> <001501cde4e4$67adc410$37094c30$%jun@samsung.com> <87622ztvcf.fsf@laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:56041 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754959Ab3AOMA4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Jan 2013 07:00:56 -0500
In-Reply-To: <87622ztvcf.fsf@laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc@vger.kernel.org, per.lkml@gmail.com

On 01/14/2013 09:31 PM, Chris Ball wrote:
> Hi Konstantin,
>
> On Fri, Dec 28 2012, Seungwon Jeon wrote:
>> I checked the changes. Thanks for your work.
>>
>> Reviewed-by: Seungwon Jeon <tgih.jun@samsung.com>
>>
>> On Wednesday, December 26, 2012, Konstantin Dorfman wrote:
>>> When current request is running on the bus and if next request fetched
>>> by mmcqd is NULL, mmc context (mmcqd thread) gets blocked until the
>>> current request completes. This means that if new request comes in while
>>> the mmcqd thread is blocked, this new request can not be prepared in
>>> parallel to current ongoing request. This may result in delaying the new
>>> request execution and increase it's latency.
>>>
>>> This change allows to wake up the MMC thread on new request arrival.
>>> Now once the MMC thread is woken up, a new request can be fetched and
>>> prepared in parallel to the current running request which means this new
>>> request can be started immediately after the current running request
>>> completes.
>>>
>>> With this change read throughput is improved by 16%.
>>>
>>> Signed-off-by: Konstantin Dorfman <kdorfman@codeaurora.org>
>>> ---
>>> v5: 	- Removed BUG() and BUG_ON() with proper error handling
>>> 	- Turn on of is_waiting_last_req flag moved from queue.c into
>>> 	  block.c (mmc_blk_issue_req())
>>>    	- mmc_init_context_info() called from mmc_add_card(). It is
>>> 	  common point for MMC, SD, SDIO.
>
> Thanks, pushed to mmc-next for 3.9.

Great Chris,
Thanks,


-- 
Konstantin Dorfman,
QUALCOMM ISRAEL, on behalf of Qualcomm Innovation Center,
Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
