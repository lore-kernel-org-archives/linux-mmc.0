From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v5] mmc: fix async request mechanism for sequential read scenarios
Date: Mon, 14 Jan 2013 14:31:28 -0500
Message-ID: <87622ztvcf.fsf@laptop.org>
References: <n@samsung.com>
	<1356513966-24945-1-git-send-email-kdorfman@codeaurora.org>
	<001501cde4e4$67adc410$37094c30$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:43899 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758481Ab3ANTbm (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Jan 2013 14:31:42 -0500
In-Reply-To: <001501cde4e4$67adc410$37094c30$%jun@samsung.com> (Seungwon
	Jeon's message of "Fri, 28 Dec 2012 19:16:30 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: 'Konstantin Dorfman' <kdorfman@codeaurora.org>, linux-mmc@vger.kernel.org, per.lkml@gmail.com

Hi Konstantin,

On Fri, Dec 28 2012, Seungwon Jeon wrote:
> I checked the changes. Thanks for your work.
>
> Reviewed-by: Seungwon Jeon <tgih.jun@samsung.com>
>
> On Wednesday, December 26, 2012, Konstantin Dorfman wrote:
>> When current request is running on the bus and if next request fetched
>> by mmcqd is NULL, mmc context (mmcqd thread) gets blocked until the
>> current request completes. This means that if new request comes in while
>> the mmcqd thread is blocked, this new request can not be prepared in
>> parallel to current ongoing request. This may result in delaying the new
>> request execution and increase it's latency.
>> 
>> This change allows to wake up the MMC thread on new request arrival.
>> Now once the MMC thread is woken up, a new request can be fetched and
>> prepared in parallel to the current running request which means this new
>> request can be started immediately after the current running request
>> completes.
>> 
>> With this change read throughput is improved by 16%.
>> 
>> Signed-off-by: Konstantin Dorfman <kdorfman@codeaurora.org>
>> ---
>> v5: 	- Removed BUG() and BUG_ON() with proper error handling
>> 	- Turn on of is_waiting_last_req flag moved from queue.c into
>> 	  block.c (mmc_blk_issue_req())
>>   	- mmc_init_context_info() called from mmc_add_card(). It is
>> 	  common point for MMC, SD, SDIO.

Thanks, pushed to mmc-next for 3.9.

Per, would you like to add an ACK here?

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
