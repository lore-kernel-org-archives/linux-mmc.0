From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] mmc: core: Enable runtime PM management of host devices
Date: Fri, 27 Mar 2015 12:15:15 +0100
Message-ID: <1427454915-12893-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:35897 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752240AbbC0LPU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Mar 2015 07:15:20 -0400
Received: by labe2 with SMTP id e2so67548891lab.3
        for <linux-mmc@vger.kernel.org>; Fri, 27 Mar 2015 04:15:19 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: NeilBrown <neil@brown.name>, Adrian Hunter <adrian.hunter@intel.com>

Currently those host drivers which have deployed runtime PM, deals with
the runtime PM reference counting entirely by themselves.

Since host drivers don't know when the core will send the next request
through some of the host_ops callbacks, they need to handle runtime PM
get/put between each an every request.

In quite many cases this has some negative effects, since it leads to a
high frequency of scheduled runtime PM suspend operations. That due to
the runtime PM reference count will normally reach zero in-between
every request.

We can decrease that frequency, by enabling the core to deal with
runtime PM reference counting of the host device. Since the core often
knows that it will send a seqeunce of requests, it makes sense for it
to keep a runtime PM reference count during these periods.

More exactly, let's increase the runtime PM reference count by invoking
pm_runtime_get_sync() from __mmc_claim_host(). Restore that action by
invoking pm_runtime_mark_last_busy() and pm_runtime_put_autosuspend()
in mmc_release_host(). In this way a runtime PM reference count will be
kept during the complete cycle of a claim -> release host.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 709ada9..c296bc0 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -897,6 +897,7 @@ int __mmc_claim_host(struct mmc_host *host, atomic_t *abort)
 	DECLARE_WAITQUEUE(wait, current);
 	unsigned long flags;
 	int stop;
+	bool pm = false;
 
 	might_sleep();
 
@@ -916,13 +917,18 @@ int __mmc_claim_host(struct mmc_host *host, atomic_t *abort)
 		host->claimed = 1;
 		host->claimer = current;
 		host->claim_cnt += 1;
+		if (host->claim_cnt == 1)
+			pm = true;
 	} else
 		wake_up(&host->wq);
 	spin_unlock_irqrestore(&host->lock, flags);
 	remove_wait_queue(&host->wq, &wait);
+
+	if (pm)
+		pm_runtime_get_sync(mmc_dev(host));
+
 	return stop;
 }
-
 EXPORT_SYMBOL(__mmc_claim_host);
 
 /**
@@ -947,6 +953,8 @@ void mmc_release_host(struct mmc_host *host)
 		host->claimer = NULL;
 		spin_unlock_irqrestore(&host->lock, flags);
 		wake_up(&host->wq);
+		pm_runtime_mark_last_busy(mmc_dev(host));
+		pm_runtime_put_autosuspend(mmc_dev(host));
 	}
 }
 EXPORT_SYMBOL(mmc_release_host);
-- 
1.9.1

