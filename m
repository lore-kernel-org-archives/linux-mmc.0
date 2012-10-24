From: "Konstantin Dorfman" <kdorfman@codeaurora.org>
Subject: Re: [PATCH v1] mmc: fix async request mechanism for sequential
     read scenarios
Date: Wed, 24 Oct 2012 11:41:36 +0200 (IST)
Message-ID: <f67543901d54b344c8bb401e363e6b80.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:62126 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755841Ab2JXJlw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 24 Oct 2012 05:41:52 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Per Forlin <per.lkml@gmail.com>
Cc: Konstantin Dorfman <kdorfman@codeaurora.org>, cjb@laptop.org, linux-mmc@vger.kernel.org

Hello Per,

On Mon, October 22, 2012 1:02 am, Per Forlin wrote:
>> When mmcqt reports on completion of a request there should be
>> a context switch to allow the insertion of the next read ahead BIOs
>> to the block layer. Since the mmcqd tries to fetch another request
>> immediately after the completion of the previous request it gets NULL
>> and starts waiting for the completion of the previous request.
>> This wait on completion gives the FS the opportunity to insert the next
>> request but the MMC layer is already blocked on the previous request
>> completion and is not aware of the new request waiting to be fetched.
> I thought that I could trigger a context switch in order to give
> execution time for FS to add the new request to the MMC queue.
> I made a simple hack to call yield() in case the request gets NULL. I
> thought it may give the FS layer enough time to add a new request to
> the MMC queue. This would not delay the MMC transfer since the yield()
> is done in parallel with an ongoing transfer. Anyway it was just meant
> to be a simple test.
>
> One yield was not enough. Just for sanity check I added a msleep as
> well and that was enough to let FS add a new request,
> Would it be possible to gain throughput by delaying the fetch of new
> request? Too avoid unnecessary NULL requests
>
> If (ongoing request is read AND size is max read ahead AND new request
> is NULL) yield();
>
> BR
> Per
We did the same experiment and it will not give maximum possible
performance. There is no guarantee that the context switch which was
manually caused by the MMC layer comes just in time: when it was early
then next fetch still results in NULL, when it was later, then we miss
possibility to fetch/prepare new request.

Any delay in fetch of the new request that comes after the new request has
arrived hits throughput and latency.

The solution we are talking about here will fix not only situation with FS
read ahead mechanism, but also it will remove penalty of the MMC context
waiting on completion while any new request arrives.

Thanks,

-- 
Konstantin Dorfman,
QUALCOMM ISRAEL, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

