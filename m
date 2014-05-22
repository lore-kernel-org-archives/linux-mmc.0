From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 2/2] mmc: Allow setting slot index via devicetree alias
Date: Thu, 22 May 2014 17:30:23 +0200
Message-ID: <1400772623-8390-3-git-send-email-s.hauer@pengutronix.de>
References: <1400772623-8390-1-git-send-email-s.hauer@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60871 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751852AbaEVPav (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 22 May 2014 11:30:51 -0400
In-Reply-To: <1400772623-8390-1-git-send-email-s.hauer@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Dirk Behme <dirk.behme@de.bosch.com>, Fabio Estevam <festevam@gmail.com>, ptx@pengutronix.de, Stephen Warren <swarren@wwwdotorg.org>, Sascha Hauer <s.hauer@pengutronix.de>

As with gpio, uart and others, allow specifying the name_idx via the
aliases-node in the devicetree.

On embedded devices, there is often a combination of removable (e.g.
SD card) and non-removable mmc devices (e.g. eMMC).
Therefore the name_idx might change depending on
        - host of removable device
        - removable card present or not

This makes it difficult to hard code the root device, if it is on the
non-removable device. E.g. if SD card is present eMMC will be mmcblk1,
if SD card is not present at boot, eMMC will be mmcblk0.

If the aliases-node is not found, the driver will act as before.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/mmc/card/block.c | 11 ++++++++++-
 drivers/mmc/core/core.c  | 37 +++++++++++++++++++++++++++++++++++++
 drivers/mmc/core/host.c  | 17 +++++++++++++++--
 include/linux/mmc/core.h |  3 +++
 4 files changed, 65 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 29d5d98..9735252 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -32,6 +32,7 @@
 #include <linux/scatterlist.h>
 #include <linux/string_helpers.h>
 #include <linux/delay.h>
+#include <linux/of.h>
 #include <linux/capability.h>
 #include <linux/compat.h>
 #include <linux/pm_runtime.h>
@@ -2044,7 +2045,15 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 	 * index anymore so we keep track of a name index.
 	 */
 	if (!subname) {
-		md->name_idx = find_first_zero_bit(name_use, max_devices);
+		int idx;
+
+		idx = mmc_get_reserved_index(card->host);
+		if (idx >= 0 && !test_bit(idx, name_use))
+			md->name_idx = idx;
+		else
+			md->name_idx = find_next_zero_bit(name_use, max_devices,
+					mmc_first_nonreserved_index());
+
 		__set_bit(md->name_idx, name_use);
 	} else
 		md->name_idx = ((struct mmc_blk_data *)
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 57a2b40..c959d41 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2711,6 +2711,41 @@ void mmc_init_context_info(struct mmc_host *host)
 	init_waitqueue_head(&host->context_info.wait);
 }
 
+static int __mmc_max_reserved_idx = -1;
+
+/**
+ * mmc_first_nonreserved_index() - get the first index that is not reserved
+ */
+int mmc_first_nonreserved_index(void)
+{
+	return __mmc_max_reserved_idx + 1;
+}
+
+/**
+ * mmc_get_reserved_index() - get the index reserved for this host
+ *
+ * Return: The index reserved for this host or negative error value if
+ *         no index is reserved for this host
+ */
+int mmc_get_reserved_index(struct mmc_host *host)
+{
+	return of_alias_get_id(host->parent->of_node, "mmc");
+}
+
+static void mmc_of_reserve_idx(void)
+{
+	int max;
+
+	max = of_alias_max_index("mmc");
+	if (max < 0)
+		return;
+
+	__mmc_max_reserved_idx = max;
+
+	pr_debug("MMC: reserving %d slots for of aliases\n",
+			__mmc_max_reserved_idx + 1);
+}
+
 static int __init mmc_init(void)
 {
 	int ret;
@@ -2719,6 +2754,8 @@ static int __init mmc_init(void)
 	if (!workqueue)
 		return -ENOMEM;
 
+	mmc_of_reserve_idx();
+
 	ret = mmc_register_bus();
 	if (ret)
 		goto destroy_workqueue;
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 49bc403..ef1e0a8 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -439,6 +439,8 @@ out:
 
 EXPORT_SYMBOL(mmc_of_parse);
 
+int mmc_max_reserved_idx(void);
+
 /**
  *	mmc_alloc_host - initialise the per-host structure.
  *	@extra: sizeof private data structure
@@ -450,6 +452,7 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 {
 	int err;
 	struct mmc_host *host;
+	int alias_id, min_idx, max_idx;
 
 	host = kzalloc(sizeof(struct mmc_host) + extra, GFP_KERNEL);
 	if (!host)
@@ -459,7 +462,18 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 	host->rescan_disable = 1;
 	idr_preload(GFP_KERNEL);
 	spin_lock(&mmc_host_lock);
-	err = idr_alloc(&mmc_host_idr, host, 0, 0, GFP_NOWAIT);
+
+	host->parent = dev;
+	alias_id = mmc_get_reserved_index(host);
+	if (alias_id >= 0) {
+		min_idx = alias_id;
+		max_idx = alias_id;
+	} else {
+		min_idx = mmc_first_nonreserved_index();
+		max_idx = 0;
+	}
+
+	err = idr_alloc(&mmc_host_idr, host, min_idx, max_idx, GFP_NOWAIT);
 	if (err >= 0)
 		host->index = err;
 	spin_unlock(&mmc_host_lock);
@@ -469,7 +483,6 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 
 	dev_set_name(&host->class_dev, "mmc%d", host->index);
 
-	host->parent = dev;
 	host->class_dev.parent = dev;
 	host->class_dev.class = &mmc_host_class;
 	device_initialize(&host->class_dev);
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 87079fc..96fb4f2 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -197,6 +197,9 @@ extern int mmc_flush_cache(struct mmc_card *);
 
 extern int mmc_detect_card_removed(struct mmc_host *host);
 
+int mmc_first_nonreserved_index(void);
+int mmc_get_reserved_index(struct mmc_host *host);
+
 /**
  *	mmc_claim_host - exclusively claim a host
  *	@host: mmc host to claim
-- 
2.0.0.rc0

