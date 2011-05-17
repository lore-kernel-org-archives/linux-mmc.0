From: Chuanxiao Dong <chuanxiao.dong@intel.com>
Subject: [RFC]mmc: fix dead lock issue when system entering S3
Date: Tue, 17 May 2011 15:53:52 +0800
Message-ID: <20110517075352.GA3992@intel.com>
Reply-To: Chuanxiao Dong <chuanxiao.dong@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:2660 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752624Ab1EQID6 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 17 May 2011 04:03:58 -0400
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: bo.he@intel.com

Hi all,
   I encountered a dead lock issue. Two threads try to claim host, unfortunately
   one thread needs to sync with the other. I encountered this issue with SD
   card when testing system entering S3. Does anybody encounter the same issue?

Environment:
1. without CONFIG_MMC_UNSAFE_RESUME operation
2. the SD card mounted

During system tried to enter S3, mmc_pm_notifier will be called first to remove
SD card. So calling sequence in SD remove thread is like this:
	mmc_claim_host
	bus_ops->remove
	....
	....
	mmc_cleanup_queue
	kthread_stop(mq->thread)
	...
	...

Mean while, mmc_cleanup_queue wakes up mq->thread, the calling sequence in mq->thread is
like this:
	mmc_queue_thread
	mq->issue_fn (mmc_blk_issue_rq)
	mmc_claim_host (dead lock)
	....
	....

Since mmc_claim_host is called in mq->thread (not SD remove thread) again,
unfortunately right now host is already claimed by SD remove thread which is
also waiting for mq->thread finished, so cause a dead lock here.

Move the mmc_claim_host(in mmc_pm_notifier) after bus_ops->remove can resolve
this dead lock. mmc_suspend_host() is using the same way to claim host.

Need to know your suggestions.

Signed-off-by: He Bo <bo.he@intel.com>
Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
---
 drivers/mmc/core/core.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 68091dd..1e27588 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1850,11 +1850,10 @@ int mmc_pm_notify(struct notifier_block *notify_block,
 		if (!host->bus_ops || host->bus_ops->suspend)
 			break;
 
-		mmc_claim_host(host);
-
 		if (host->bus_ops->remove)
 			host->bus_ops->remove(host);
 
+		mmc_claim_host(host);
 		mmc_detach_bus(host);
 		mmc_release_host(host);
 		host->pm_flags = 0;
-- 
1.7.3.4

