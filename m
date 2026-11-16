Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794814389;
	b=Enk6DRTbFlH0JrZghmzIgh+e7lQXuvNj8XKoJ5R1uYU1ttPoKHw6nMy8Ki8YeNZqokl4
	 2hY0z/iYW7rVRIVMa6GsOmkdJNnlv3DgKoafA/66uwdHLMWtIRZXWSAuAK/wT8FKqDpqU
	 mvjdxAIPWN3rOqYe8khelZO5JIKrGsH02NiIPnIq013sa5hbvx/kP7ZVg4heWCyS/qh0o
	 vOKBqYgnh93qCHtdTbhGgSqSU5rwDgx8qJHvTSTMmINTUDSQ/WgTvitcKlJZTUSHTxE5r
	 VkRyjm5lU4GuyvzOP9Xaow1elVv9dfx00lhiDEl0NO/dA4mgwIRersxpyhrLixvq2Dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794814389;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 Content-Language:From:In-Reply-To:Content-Transfer-Encoding:
	 X-CMS-MailID:X-Msg-Generator:Content-Type:X-RootMTR:X-EPHeader:
	 X-CMS-RootMailID:References;
	bh=G7t2Ip9dU2h7Xb2XPTJWwdlpbD3DBdvbU6zpBUoazbQ=;
	b=SlUlQ+gGy81LMLH4BFFNdt//GsThsFmbA0k69cpHWraYZiJir2uJDsJ6rRtRR1Clxpga
	 5PsYxnQ68J4jlo1ceZTxSsTKgYu+BA1jGXt+bfOH3m4x22oiXGcYAI2xkDMz9kDVSXau0
	 ovP6U5hNNWzXZoBX/WT+RObNUeHarlfP5h+UaFwZcHDmw/TyvmBWVz3JOa7qvWlWhvZXz
	 eegOnLTrv6Rr17np323aGX7RPaoJR+4XnEtEoy6NIDQG+UiDLhbD4ILa2EJENSjCHdKCl
	 7PnEA0C7xW2ObLkehhyvRU8QHplwwaiUw1mOjhWE4LVlknjHU0IchwchfAwFQdeNzOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=QE1HGcrh;
	arc=none smtp.remote-ip=210.118.77.12
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3483606A33D
	for <linux-mmc@vger.kernel.org>; Mon, 16 Nov 2026 07:33:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3483606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=QE1HGcrh
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20261116073300euoutp026ceeaedeaefbdd58d28e106af63d9ca4~oditXi6FK1698416984euoutp02g
	for <linux-mmc@vger.kernel.org>; Mon, 16 Nov 2026 07:33:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20261116073300euoutp026ceeaedeaefbdd58d28e106af63d9ca4~oditXi6FK1698416984euoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1794814380;
	bh=G7t2Ip9dU2h7Xb2XPTJWwdlpbD3DBdvbU6zpBUoazbQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=QE1HGcrhGpi0jdCiWphheI2xdO8hZj5e/qi0AXcUjbxymqKPB3hEKE5xa0uYwDBEr
	 pigvvGWK6CcI8Vrd4coZDwzSk/xKz/pNcAwnH4NmU8vKh4gom92hE0ZG7gZbDIOsRA
	 ukzHVbbC5zpK511sDGInT+dSdVKTpaiE2eynjt/U=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20261116073259eucas1p26c60e7986a36f26e43f65b1d911a05ec~oditM9CuF0584505845eucas1p2X;
	Mon, 16 Nov 2026 07:32:59 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261116073258eusmtip13de6c0ef2c345ebc557d5a64f0c0be0c~odisY_OC90411204112eusmtip1q;
	Mon, 16 Nov 2026 07:32:58 +0000 (GMT)
Message-ID: <240c99c9-0215-41c1-95ed-b0942d800551@samsung.com>
Date: Mon, 16 Nov 2026 08:32:58 +0100
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] mmc: dw_mmc: enable MMC_CAP_DONE_COMPLETE
To: Shawn Lin <shawn.lin@linux.dev>, Shawn Lin <shawn.lin@rock-chips.com>,
	Ulf Hansson <ulfh@kernel.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <0c0bf25b-3a23-4d24-8ffb-fce801a3208c@linux.dev>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261116073259eucas1p26c60e7986a36f26e43f65b1d911a05ec
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261110192834eucas1p1e183345528f097cb64340f36a03e4b14
X-EPHeader: CA
X-CMS-RootMailID: 20261110192834eucas1p1e183345528f097cb64340f36a03e4b14
References: <1791876245-190981-1-git-send-email-shawn.lin@rock-chips.com>
	<CGME20261110192834eucas1p1e183345528f097cb64340f36a03e4b14@eucas1p1.samsung.com>
	<4a1867dc-7bcd-4c63-bdbd-a533043cd91e@samsung.com>
	<0c0bf25b-3a23-4d24-8ffb-fce801a3208c@linux.dev>

On 11.11.2026 02:15, Shawn Lin wrote:
> 在 2026/11/11 星期三 3:28, Marek Szyprowski 写道:
>> On 13.10.2026 09:24, Shawn Lin wrote:
>>> All requests issued by dw_mmc are completed from dw_mci_work_func(),
>>> which runs from the system_bh_wq workqueue. It is therefore preemptible
>>> context and host->lock is dropped before the completion, see
>>> mmc_request_done() in dw_mci_request_end().
>>>
>>> The dw_mci_interrupt and the dw_mci_watchdog_fn never call mmc_request_done()
>>> directly. So every request is completed from a sleepable context with no
>>> spinlock held.
>>>
>>> This is exactly the contract required by MMC_CAP_DONE_COMPLETE, which was
>>> introduced for hosts that can complete requests within mmc_request_done()
>>> without deferring to the core's complete_work.
>>>
>>> Without the flag, the core records the finished request in
>>> mq->complete_req and queues mq->complete_work, i.e. a second workqueue
>>> dispatch plus an extra context switch per request. With the flag,
>>> mmc_blk_mq_req_done() completes the request directly via
>>> mmc_blk_mq_post_req() -> blk_mq_complete_request(), and a following
>>> request completes the previous one inline from mmc_blk_rw_wait().
>>>
>>> Measured on an RK3576 SD card (dw_mmc) with:
>>>
>>>    perf record -a -g -F 999 -- sleep 30
>>>    perf report --stdio -g graph,0.5,caller
>>>
>>> fio: 4k randread, ioengine=libaio
>>>
>>> Without the flag, the completion hot path is:
>>>
>>>    mmc_request_done -> mmc_blk_mq_req_done -> queue_work_on      (~4.3%)
>>>    ... -> mmc_blk_mq_complete_work            (kworker/5:1H-mm, ~18.4%)
>>>         -> mmc_blk_mq_complete_prev_req -> mmc_blk_mq_post_req
>>>
>>> with the flag the workqueue round trip disappears completely: there is no
>>> queue_work_on and no mmc_blk_mq_complete_work in the profile anymore, and
>>> the previous request is completed inline:
>>>
>>>    mmc_blk_mq_issue_rq -> mmc_blk_mq_post_req -> mmc_blk_mq_complete_rq
>>>                                                    -> __blk_mq_end_request
>>>
>>> This can remove a redundant workqueue dispatch and context switch per completed
>>> request.
>>>
>>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>>
>>
>> This patch landed yesterday in linux-next as commit 80636b762eec ("mmc: dw_mmc:
>> enable MMC_CAP_DONE_COMPLETE"). In my tests I found that it causes serious
>> problems. I found that it is responsible for corrupting root filesystem and/or
>> journal.
>> Reverting this on top of linux-next fixes the issue. Unfortunately I didn't find
>> what mmc access pattern causes the corruption, but running my tests and rebooting
>> boards 2 or 3 times usually ended in breaking it.
>>
>>
>> There must some corner case missed in the analysis behind this patch.
>>
>
> Thansk for testing.
>
> I have tested this patch in my local product environment for several
> days and did not trigger the issue. Of course, I have also been keeping
> an eye on whether the Linux-next branch can reproduce the problem on
> other platforms, because frankly speaking, this is the first controller
> that is about to enable this mmc block multi-queue internal mechanism,
> meaning this mechanism has not undergone rigorous large-scale deployment
> testing. Could you please help test the following patch to see if it
> resolves your issue?
>
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -2248,6 +2248,7 @@ static void mmc_blk_mq_req_done(struct mmc_request *mrq)
>
>         /* Take the recovery path for errors or urgent background operations */
>         if (mmc_blk_rq_error(&mqrq->brq) ||
> +           mmc_blk_card_busy(mq->card, req) ||
>             mmc_blk_urgent_bkops_needed(mq, mqrq)) {
>                 spin_lock_irqsave(&mq->lock, flags);
>                 mq->recovery_needed = true;
>
>
I just got back from holidays, sorry for the delay. This change in turn
triggers lots of the following warnings:

BUG: sleeping function called from invalid context at kernel/sched/completion.c:116
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 0, name: swapper/0
preempt_count: 101, expected: 0
RCU nest depth: 0, expected: 0
locks held by swapper/0/0: 2, on CPU#0:
 #0: c2035ebc ((wq_completion)events_bh){+.-.}-{0:0}, at: process_one_work+0x234/0x8b8
 #1: c1501da8 ((work_completion)(&host->bh_work)){+.-.}-{0:0}, at: process_one_work+0x25c/0x8b8
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 7.4.0-rc2-next-20261109-00114-gec88e69c6c34-dirty #14141 PREEMPT
Hardware name: Samsung Exynos (Flattened Device Tree)
Call trace:
 unwind_backtrace from show_stack+0x10/0x14
 show_stack from dump_stack_lvl+0x6c/0x8c
 dump_stack_lvl from __might_resched+0x198/0x264
 __might_resched from __wait_for_common+0x3c/0x258
 __wait_for_common from mmc_wait_for_req_done+0x4c/0xe8
 mmc_wait_for_req_done from mmc_wait_for_cmd+0x6c/0xac
 mmc_wait_for_cmd from mmc_send_status+0x60/0xa0
 mmc_send_status from mmc_blk_busy_cb+0x34/0x80
 mmc_blk_busy_cb from __mmc_poll_for_busy+0x68/0x110
 __mmc_poll_for_busy from mmc_blk_card_busy+0x6c/0x118
 mmc_blk_card_busy from mmc_blk_mq_req_done+0xf0/0x200
 mmc_blk_mq_req_done from dw_mci_request_end+0x64/0x80
 dw_mci_request_end from dw_mci_work_func+0x110/0x3b4
 dw_mci_work_func from process_one_work+0x2c8/0x8b8
 process_one_work from bh_worker+0x294/0x480
 bh_worker from tasklet_action+0xc/0x28
 tasklet_action from handle_softirqs+0x14c/0x67c
 handle_softirqs from __irq_exit_rcu+0x148/0x1f4
 __irq_exit_rcu from irq_exit+0x8/0x28
 irq_exit from __irq_svc+0x8c/0xd0
Exception stack(0xc1501ed0 to 0xc1501f18)
1ec0:                                     ffffffff ffffffff 00000001 00028481
1ee0: c150bcc0 c019d30c 00000000 c1492e28 c15080f8 00000000 c1182000 00000000
1f00: 00000000 c1501f20 c0de16d8 c0de16dc 60000013 ffffffff
 __irq_svc from default_idle_call+0x1c/0x13c
 default_idle_call from do_idle+0x25c/0x374
 do_idle from cpu_startup_entry+0x28/0x2c
 cpu_startup_entry from rest_init+0x1b4/0x1b8
 rest_init from start_kernel+0x7bc/0x7d8

I was not able to test if the rootfs corruption is fixed or not.


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

