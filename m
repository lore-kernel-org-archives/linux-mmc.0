From: NeilBrown <neil@brown.name>
Subject: [PATCH 2/2] mmc: remove enable/disable methods.
Date: Thu, 26 Mar 2015 08:43:37 +1100
Message-ID: <20150325214337.11463.16571.stgit@notabene.brown>
References: <20150325213419.11463.33321.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150325213419.11463.33321.stgit@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Chris Ball <chris@printf.net>
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

The 'enable' and 'disable' methods are "deprecated"
according to host.h, and are no longer used.  So
discard them.

Signed-off-by: NeilBrown <neil@brown.name>
---
 drivers/mmc/core/core.c  |    5 -----
 include/linux/mmc/host.h |    6 ------
 2 files changed, 11 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 23f10f72e5f3..709ada9f26b5 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -920,8 +920,6 @@ int __mmc_claim_host(struct mmc_host *host, atomic_t *abort)
 		wake_up(&host->wq);
 	spin_unlock_irqrestore(&host->lock, flags);
 	remove_wait_queue(&host->wq, &wait);
-	if (host->ops->enable && !stop && host->claim_cnt == 1)
-		host->ops->enable(host);
 	return stop;
 }
 
@@ -940,9 +938,6 @@ void mmc_release_host(struct mmc_host *host)
 
 	WARN_ON(!host->claimed);
 
-	if (host->ops->disable && host->claim_cnt == 1)
-		host->ops->disable(host);
-
 	spin_lock_irqsave(&host->lock, flags);
 	if (--host->claim_cnt) {
 		/* Release for nested claim */
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 0c8cbe5d1550..b5bedaec6223 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -80,12 +80,6 @@ struct mmc_ios {
 
 struct mmc_host_ops {
 	/*
-	 * 'enable' is called when the host is claimed and 'disable' is called
-	 * when the host is released. 'enable' and 'disable' are deprecated.
-	 */
-	int (*enable)(struct mmc_host *host);
-	int (*disable)(struct mmc_host *host);
-	/*
 	 * It is optional for the host to implement pre_req and post_req in
 	 * order to support double buffering of requests (prepare one
 	 * request while another request is active).
