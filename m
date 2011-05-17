From: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>
Subject: RE: [RFC]mmc: fix dead lock issue when system entering S3
Date: Tue, 17 May 2011 18:03:26 +0800
Message-ID: <5D8008F58939784290FAB48F54975198419F75426B@shsmsx502.ccr.corp.intel.com>
References: <20110517075352.GA3992@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:35524 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754075Ab1EQKDa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 May 2011 06:03:30 -0400
In-Reply-To: <20110517075352.GA3992@intel.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: "He, Bo" <bo.he@intel.com>

Just found Andrei Warkentin also submitted a RFC patch, which included more fix for mounted root file system media. Please ignore this thread.

> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org
> [mailto:linux-mmc-owner@vger.kernel.org] On Behalf Of Chuanxiao Dong
> Sent: Tuesday, May 17, 2011 3:54 PM
> To: linux-mmc@vger.kernel.org
> Cc: He, Bo
> Subject: [RFC]mmc: fix dead lock issue when system entering S3
> 
> Hi all,
>    I encountered a dead lock issue. Two threads try to claim host, unfortunately
>    one thread needs to sync with the other. I encountered this issue with SD
>    card when testing system entering S3. Does anybody encounter the same
> issue?
> 
> Environment:
> 1. without CONFIG_MMC_UNSAFE_RESUME operation
> 2. the SD card mounted
> 
> During system tried to enter S3, mmc_pm_notifier will be called first to remove
> SD card. So calling sequence in SD remove thread is like this:
> 	mmc_claim_host
> 	bus_ops->remove
> 	....
> 	....
> 	mmc_cleanup_queue
> 	kthread_stop(mq->thread)
> 	...
> 	...
> 
> Mean while, mmc_cleanup_queue wakes up mq->thread, the calling sequence in
> mq->thread is
> like this:
> 	mmc_queue_thread
> 	mq->issue_fn (mmc_blk_issue_rq)
> 	mmc_claim_host (dead lock)
> 	....
> 	....
> 
> Since mmc_claim_host is called in mq->thread (not SD remove thread) again,
> unfortunately right now host is already claimed by SD remove thread which is
> also waiting for mq->thread finished, so cause a dead lock here.
> 
> Move the mmc_claim_host(in mmc_pm_notifier) after bus_ops->remove can
> resolve
> this dead lock. mmc_suspend_host() is using the same way to claim host.
> 
> Need to know your suggestions.
> 
> Signed-off-by: He Bo <bo.he@intel.com>
> Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
> ---
>  drivers/mmc/core/core.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 68091dd..1e27588 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1850,11 +1850,10 @@ int mmc_pm_notify(struct notifier_block
> *notify_block,
>  		if (!host->bus_ops || host->bus_ops->suspend)
>  			break;
> 
> -		mmc_claim_host(host);
> -
>  		if (host->bus_ops->remove)
>  			host->bus_ops->remove(host);
> 
> +		mmc_claim_host(host);
>  		mmc_detach_bus(host);
>  		mmc_release_host(host);
>  		host->pm_flags = 0;
> --
> 1.7.3.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
