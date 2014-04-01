From: stefan-XLVq0VzYD2Y@public.gmane.org
Subject: [RFC 1/2] mmc: read mmc alias from device tree
Date: Tue,  1 Apr 2014 22:35:51 +0200
Message-ID: <5570bdf5ebb3aaae5a376634ecfbac9c2fd7b9f4.1396384101.git.stefan@agner.ch>
References: <cover.1396384101.git.stefan@agner.ch>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1396384101.git.stefan-XLVq0VzYD2Y@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stefan-XLVq0VzYD2Y@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

From: Stefan Agner <stefan-XLVq0VzYD2Y@public.gmane.org>

To get the SD/MMC host device ID, read the alias from the device
tree.

This is useful in case a SoC has multipe SD/MMC host controllers while
the second controller should logically be the first device (e.g. if
the second controller is connected to an internal eMMC). Combined
with block device numbering using MMC/SD host device ID, this
results in predictable name assignment of the internal eMMC block
device.

Signed-off-by: Stefan Agner <stefan-XLVq0VzYD2Y@public.gmane.org>
---
 drivers/mmc/core/host.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 49bc403..29f44cf 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -448,8 +448,8 @@ EXPORT_SYMBOL(mmc_of_parse);
  */
 struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 {
-	int err;
 	struct mmc_host *host;
+	int of_id = -1, id = -1;
 
 	host = kzalloc(sizeof(struct mmc_host) + extra, GFP_KERNEL);
 	if (!host)
@@ -459,12 +459,26 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 	host->rescan_disable = 1;
 	idr_preload(GFP_KERNEL);
 	spin_lock(&mmc_host_lock);
-	err = idr_alloc(&mmc_host_idr, host, 0, 0, GFP_NOWAIT);
-	if (err >= 0)
-		host->index = err;
+
+	if (dev->of_node)
+		of_id = of_alias_get_id(dev->of_node, "mmc");
+
+	if (of_id >= 0) {
+		id = idr_alloc(&mmc_host_idr, host, of_id, of_id + 1,
+				GFP_NOWAIT);
+		if (id < 0)
+			dev_warn(dev, "/aliases ID %d not available\n", of_id);
+	}
+
+	if (id < 0)
+		id = idr_alloc(&mmc_host_idr, host, 0, 0, GFP_NOWAIT);
+
+	if (id >= 0)
+		host->index = id;
+
 	spin_unlock(&mmc_host_lock);
 	idr_preload_end();
-	if (err < 0)
+	if (id < 0)
 		goto free;
 
 	dev_set_name(&host->class_dev, "mmc%d", host->index);
-- 
1.9.1
