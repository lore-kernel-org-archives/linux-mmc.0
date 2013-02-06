From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 52/77] mmc: convert to idr_alloc()
Date: Wed,  6 Feb 2013 11:40:24 -0800
Message-ID: <1360179649-22465-53-git-send-email-tj@kernel.org>
References: <1360179649-22465-1-git-send-email-tj@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1360179649-22465-1-git-send-email-tj@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Convert to the much saner new idr interface.

Only compile tested.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org
---
 drivers/mmc/core/host.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index ee2e16b..1117de7 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -306,19 +306,20 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 	int err;
 	struct mmc_host *host;
 
-	if (!idr_pre_get(&mmc_host_idr, GFP_KERNEL))
-		return NULL;
-
 	host = kzalloc(sizeof(struct mmc_host) + extra, GFP_KERNEL);
 	if (!host)
 		return NULL;
 
 	/* scanning will be enabled when we're ready */
 	host->rescan_disable = 1;
+	idr_preload(GFP_KERNEL);
 	spin_lock(&mmc_host_lock);
-	err = idr_get_new(&mmc_host_idr, host, &host->index);
+	err = idr_alloc(&mmc_host_idr, host, 0, 0, GFP_NOWAIT);
+	if (err >= 0)
+		host->index = err;
 	spin_unlock(&mmc_host_lock);
-	if (err)
+	idr_preload_end();
+	if (err < 0)
 		goto free;
 
 	dev_set_name(&host->class_dev, "mmc%d", host->index);
-- 
1.8.1
