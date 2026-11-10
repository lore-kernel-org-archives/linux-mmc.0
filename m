Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794338924;
	b=gSHxYGK5meSCjztS8BZoKQUswiVG9l1xiQG0kHXZyI8+GhHOkho9bn2jlGS0/OLZpwqm
	 eUplnkySQlHFHkMSwLShDEJqRB22D63nZ6gE1S5xhGvcuQW8mQbVR98kS4EezxQGtwLt0
	 lhNNn0bjBJW8Ny/EDvdgvq8zx9SN02N++lkb3wTZaHHMB5gf8kNi+9N0EesZavPYOMt+R
	 4cCNog6JdTgjPcHu9+quDsTWqnhgFn+4VI2ZywbGXKBqNwzh0MHnCf8m0vkgwIa/BS7LC
	 h8LbfwDy2t1+FWqb5L21Bt9B9mShEi4mAMEWA356WisBlQawNb4sJqQdRionH4+KcaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794338924;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 Content-Language:From:In-Reply-To:Content-Transfer-Encoding:
	 X-CMS-MailID:X-Msg-Generator:Content-Type:X-RootMTR:X-EPHeader:
	 X-CMS-RootMailID:References;
	bh=0qv2AlTHab79JFtM58yIGf5u+WnsUUhQouF3mc4jFuM=;
	b=Tk9af25B6notoGWyWZ7lNAa03zALTj4Sj0XYrwIRTc41gf5ROS8dPNq+n18qJ99JvWRJ
	 1CxCdJy7IZaNEvkTGgkSBAUCaxc3cnAPuG7bap942EnVwy7edcXlyVdoaPY4FP2bG4MVV
	 /xiJifVjEw5qR45Q/0AHYlp4qgeN11uuUI1KqhfmkoMw16z4F27JdGGy1JuFh0a3vlOh1
	 2zjq8ccB17s7B/3EhpGB5VdoBlWe/IhJl2r26OGpPxLO5AntVbQ2N0K+c0469EhepPDdJ
	 zhKK6Cjib2CKPrBiI69gbd7MD/fFVOEhJmmNU/wcMtpJN5s7L6QNok8WoRCZAcFfbaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=nsIHF+pT;
	arc=none smtp.remote-ip=210.118.77.11
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BC6606A323
	for <linux-mmc@vger.kernel.org>; Tue, 10 Nov 2026 19:28:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82BC6606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=nsIHF+pT
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20261110192834euoutp01e210da6b6035fcd2ab1004d32a82c395~mxbyB_8Ao2473824738euoutp01M
	for <linux-mmc@vger.kernel.org>; Tue, 10 Nov 2026 19:28:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20261110192834euoutp01e210da6b6035fcd2ab1004d32a82c395~mxbyB_8Ao2473824738euoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1794338915;
	bh=0qv2AlTHab79JFtM58yIGf5u+WnsUUhQouF3mc4jFuM=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=nsIHF+pTtpqehpF8QVqOUfh8aCXUEg6XPlsqrXrOEMqISmEyQ0orkZV1IaHW3Aawg
	 3aq5GM6AR8WP0vgZL56QbN+atQsVR2UqfNEFArIH8Z4ZE1Qp+Lr8i7YoeDqFRHtKn1
	 EZwloU4cHk1lteNIF1j5HS+8YG3e1hHMJBKs7z6s=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20261110192834eucas1p1e183345528f097cb64340f36a03e4b14~mxbxxvWSA1861418614eucas1p1V;
	Tue, 10 Nov 2026 19:28:34 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261110192834eusmtip2c7558e1ab3c033fc231ab48183aff02a~mxbxUJAOL0384603846eusmtip22;
	Tue, 10 Nov 2026 19:28:34 +0000 (GMT)
Message-ID: <4a1867dc-7bcd-4c63-bdbd-a533043cd91e@samsung.com>
Date: Tue, 10 Nov 2026 20:28:33 +0100
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
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulfh@kernel.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <1791876245-190981-1-git-send-email-shawn.lin@rock-chips.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20261110192834eucas1p1e183345528f097cb64340f36a03e4b14
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261110192834eucas1p1e183345528f097cb64340f36a03e4b14
X-EPHeader: CA
X-CMS-RootMailID: 20261110192834eucas1p1e183345528f097cb64340f36a03e4b14
References: <1791876245-190981-1-git-send-email-shawn.lin@rock-chips.com>
	<CGME20261110192834eucas1p1e183345528f097cb64340f36a03e4b14@eucas1p1.samsung.com>

On 13.10.2026 09:24, Shawn Lin wrote:
> All requests issued by dw_mmc are completed from dw_mci_work_func(),
> which runs from the system_bh_wq workqueue. It is therefore preemptible
> context and host->lock is dropped before the completion, see
> mmc_request_done() in dw_mci_request_end().
>
> The dw_mci_interrupt and the dw_mci_watchdog_fn never call mmc_request_done()
> directly. So every request is completed from a sleepable context with no
> spinlock held.
>
> This is exactly the contract required by MMC_CAP_DONE_COMPLETE, which was
> introduced for hosts that can complete requests within mmc_request_done()
> without deferring to the core's complete_work.
>
> Without the flag, the core records the finished request in
> mq->complete_req and queues mq->complete_work, i.e. a second workqueue
> dispatch plus an extra context switch per request. With the flag,
> mmc_blk_mq_req_done() completes the request directly via
> mmc_blk_mq_post_req() -> blk_mq_complete_request(), and a following
> request completes the previous one inline from mmc_blk_rw_wait().
>
> Measured on an RK3576 SD card (dw_mmc) with:
>
>   perf record -a -g -F 999 -- sleep 30
>   perf report --stdio -g graph,0.5,caller
>
> fio: 4k randread, ioengine=libaio
>
> Without the flag, the completion hot path is:
>
>   mmc_request_done -> mmc_blk_mq_req_done -> queue_work_on      (~4.3%)
>   ... -> mmc_blk_mq_complete_work            (kworker/5:1H-mm, ~18.4%)
>        -> mmc_blk_mq_complete_prev_req -> mmc_blk_mq_post_req
>
> with the flag the workqueue round trip disappears completely: there is no
> queue_work_on and no mmc_blk_mq_complete_work in the profile anymore, and
> the previous request is completed inline:
>
>   mmc_blk_mq_issue_rq -> mmc_blk_mq_post_req -> mmc_blk_mq_complete_rq
>                                                   -> __blk_mq_end_request
>
> This can remove a redundant workqueue dispatch and context switch per completed
> request.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>


This patch landed yesterday in linux-next as commit 80636b762eec ("mmc: dw_mmc:
enable MMC_CAP_DONE_COMPLETE"). In my tests I found that it causes serious
problems. I found that it is responsible for corrupting root filesystem and/or
journal.
Reverting this on top of linux-next fixes the issue. Unfortunately I didn't find
what mmc access pattern causes the corruption, but running my tests and rebooting
boards 2 or 3 times usually ended in breaking it.


There must some corner case missed in the analysis behind this patch.



> ---
>
>  drivers/mmc/host/dw_mmc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index ff0b25d..bec777b 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2945,6 +2945,8 @@ static int dw_mci_init_host_caps(struct dw_mci *host)
>  	if (mmc->caps & MMC_CAP_SDIO_IRQ)
>  		mmc->caps2 |= MMC_CAP2_SDIO_IRQ_NOTHREAD;
>  
> +	mmc->caps |= MMC_CAP_DONE_COMPLETE;
> +
>  	return 0;
>  }
>  

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

