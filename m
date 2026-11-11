Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.205
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794359759;
	b=3G4dYTGdzGoTxowerk9We4SwO+z2k7UfcydkGmfItnRlxj1ZH9MkSWkqWkOU2zJd99me
	 ++GB3d2V7md/1cNrmo+0T1emvonHHF4rsUP0giaceTmllGjuE0TlvBedwu6vRKq09lp/b
	 ch+SqwN5Du1YqOf4EirjZ1i5P8B0wEtqWVd904olak4UveKCUTFqGeihee4rf7+bF1DSC
	 K/onF2ZpOHUts0vGi2KREIR7SVqGRgAq0SwKrOETvg34uQS2GB3zXL9zfH0LMVWGHhKm9
	 RRHbJjWy8Anu8y9h2ohEnzfmh5TtW5CpVI5yEcNMwPXC2MaKYb3AmQsotOQjPhy9czQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794359759;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Cc:Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=MZb76DR3XAf0JkuNQyt+BOnnz3hO4qVggLr4XwcoBcU=;
	b=vwrLFFOvBaBcymt28mfml2cgdUBLnyPczKGoxYSVAexu+PtinyAPQFGycpZ/8Kvaa5Li
	 Bgvi35lxD8qpSPU0dLYsyGi9+urHfThRvICXovrbgZ3diJ97ExXGyW42OenFGgCvDF4Sr
	 Cc/w/BS2+xOMBb5SsvbhWz+Ajyy3GviG6xagl1PpwLdXcGxo0kkq18Oc5F8lYmVZn0R+n
	 3/Fnn7gdAfAkkMddXd/D3pXFiqR4HEEU6W12GfUtyatAUWrrrQ68e6ofwFY1VfhAENNyk
	 hnO8FlYPiT8G47BxkLP4HICRVrGx/t6Y6yfE75pKfcDDtiE+DJ5ohdfFQcOylqEco4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=UV7nT5wD;
	arc=none smtp.remote-ip=95.215.58.205
Received: from mta1.migadu.com (out-205.mta1.migadu.com [95.215.58.205])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFE4606A31C
	for <linux-mmc@vger.kernel.org>; Wed, 11 Nov 2026 01:15:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AFE4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=UV7nT5wD
X-Envelope-To: linux-mmc@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=V+zXxBqY4bH0VRopB1Nhwt9W/o/YGB29BanigCQLPMw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794359755; v=1; x=1794964555;
 b=UV7nT5wDLvyhkKRJPSB311LqEUpIQrmig3chau8TSrUKSh3IMkxjwsjaa3DXvPmXjvxqUxeg
 3J/V/kv+qUJgB9t5BwWmiy/VwBybAWp8ZPe4kLmDJG1O2rnjXistQBtfahiZL3Mxp0DbZ3OvA+q
 SZ53f2ugxqKRApI17cfa6sT4=
X-Envelope-To: linux-mmc@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 63ed50b758153cc2;
	Wed, 11 Nov 2026 01:15:55 +0000
X-Mizu-Trace-ID: 63ed50b758153cc2
X-Migadu-Flow: FLOW_OUT
Message-ID: <0c0bf25b-3a23-4d24-8ffb-fce801a3208c@linux.dev>
Date: Wed, 11 Nov 2026 09:15:47 +0800
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@linux.dev, Jaehoon Chung <jh80.chung@samsung.com>,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: dw_mmc: enable MMC_CAP_DONE_COMPLETE
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulfh@kernel.org>
References: <1791876245-190981-1-git-send-email-shawn.lin@rock-chips.com>
 <CGME20261110192834eucas1p1e183345528f097cb64340f36a03e4b14@eucas1p1.samsung.com>
 <4a1867dc-7bcd-4c63-bdbd-a533043cd91e@samsung.com>
From: Shawn Lin <shawn.lin@linux.dev>
In-Reply-To: <4a1867dc-7bcd-4c63-bdbd-a533043cd91e@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Marek,

在 2026/11/11 星期三 3:28, Marek Szyprowski 写道:
> On 13.10.2026 09:24, Shawn Lin wrote:
>> All requests issued by dw_mmc are completed from dw_mci_work_func(),
>> which runs from the system_bh_wq workqueue. It is therefore preemptible
>> context and host->lock is dropped before the completion, see
>> mmc_request_done() in dw_mci_request_end().
>>
>> The dw_mci_interrupt and the dw_mci_watchdog_fn never call mmc_request_done()
>> directly. So every request is completed from a sleepable context with no
>> spinlock held.
>>
>> This is exactly the contract required by MMC_CAP_DONE_COMPLETE, which was
>> introduced for hosts that can complete requests within mmc_request_done()
>> without deferring to the core's complete_work.
>>
>> Without the flag, the core records the finished request in
>> mq->complete_req and queues mq->complete_work, i.e. a second workqueue
>> dispatch plus an extra context switch per request. With the flag,
>> mmc_blk_mq_req_done() completes the request directly via
>> mmc_blk_mq_post_req() -> blk_mq_complete_request(), and a following
>> request completes the previous one inline from mmc_blk_rw_wait().
>>
>> Measured on an RK3576 SD card (dw_mmc) with:
>>
>>    perf record -a -g -F 999 -- sleep 30
>>    perf report --stdio -g graph,0.5,caller
>>
>> fio: 4k randread, ioengine=libaio
>>
>> Without the flag, the completion hot path is:
>>
>>    mmc_request_done -> mmc_blk_mq_req_done -> queue_work_on      (~4.3%)
>>    ... -> mmc_blk_mq_complete_work            (kworker/5:1H-mm, ~18.4%)
>>         -> mmc_blk_mq_complete_prev_req -> mmc_blk_mq_post_req
>>
>> with the flag the workqueue round trip disappears completely: there is no
>> queue_work_on and no mmc_blk_mq_complete_work in the profile anymore, and
>> the previous request is completed inline:
>>
>>    mmc_blk_mq_issue_rq -> mmc_blk_mq_post_req -> mmc_blk_mq_complete_rq
>>                                                    -> __blk_mq_end_request
>>
>> This can remove a redundant workqueue dispatch and context switch per completed
>> request.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> 
> This patch landed yesterday in linux-next as commit 80636b762eec ("mmc: dw_mmc:
> enable MMC_CAP_DONE_COMPLETE"). In my tests I found that it causes serious
> problems. I found that it is responsible for corrupting root filesystem and/or
> journal.
> Reverting this on top of linux-next fixes the issue. Unfortunately I didn't find
> what mmc access pattern causes the corruption, but running my tests and rebooting
> boards 2 or 3 times usually ended in breaking it.
> 
> 
> There must some corner case missed in the analysis behind this patch.
> 

Thansk for testing.

I have tested this patch in my local product environment for several
days and did not trigger the issue. Of course, I have also been keeping
an eye on whether the Linux-next branch can reproduce the problem on
other platforms, because frankly speaking, this is the first controller
that is about to enable this mmc block multi-queue internal mechanism,
meaning this mechanism has not undergone rigorous large-scale deployment
testing. Could you please help test the following patch to see if it
resolves your issue?

--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2248,6 +2248,7 @@ static void mmc_blk_mq_req_done(struct mmc_request 
*mrq)

         /* Take the recovery path for errors or urgent background 
operations */
         if (mmc_blk_rq_error(&mqrq->brq) ||
+           mmc_blk_card_busy(mq->card, req) ||
             mmc_blk_urgent_bkops_needed(mq, mqrq)) {
                 spin_lock_irqsave(&mq->lock, flags);
                 mq->recovery_needed = true;


> 
> 
>> ---
>>
>>   drivers/mmc/host/dw_mmc.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index ff0b25d..bec777b 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -2945,6 +2945,8 @@ static int dw_mci_init_host_caps(struct dw_mci *host)
>>   	if (mmc->caps & MMC_CAP_SDIO_IRQ)
>>   		mmc->caps2 |= MMC_CAP2_SDIO_IRQ_NOTHREAD;
>>   
>> +	mmc->caps |= MMC_CAP_DONE_COMPLETE;
>> +
>>   	return 0;
>>   }
>>   
> 
> Best regards

