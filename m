From: Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 2/3] mmc: read mmc alias from device tree
Date: Thu, 28 Apr 2016 16:06:44 -0700
Message-ID: <1461884805-29466-3-git-send-email-dianders@chromium.org>
References: <1461884805-29466-1-git-send-email-dianders@chromium.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:33758 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751722AbcD1XHe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Apr 2016 19:07:34 -0400
Received: by mail-pf0-f182.google.com with SMTP id 206so39970232pfu.0
        for <linux-mmc@vger.kernel.org>; Thu, 28 Apr 2016 16:07:34 -0700 (PDT)
In-Reply-To: <1461884805-29466-1-git-send-email-dianders@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, jh80.chung@samsung.com
Cc: shawn.lin@rock-chips.com, adrian.hunter@intel.com, stefan@agner.ch, linux-mmc@vger.kernel.org, computersforpeace@gmail.com, dmitry.torokhov@gmail.com, Dmitry Torokhov <dtor@chromium.org>, Douglas Anderson <dianders@chromium.org>, vbyravarasu@nvidia.com, huangtao@rock-chips.com, lars@metafoo.de, sergei.shtylyov@cogentembedded.com, linux-kernel@vger.kernel.org

From: Stefan Agner <stefan@agner.ch>

To get the SD/MMC host device ID, read the alias from the device
tree.

This is useful in case a SoC has multipe SD/MMC host controllers while
the second controller should logically be the first device (e.g. if
the second controller is connected to an internal eMMC). Combined
with block device numbering using MMC/SD host device ID, this
results in predictable name assignment of the internal eMMC block
device.

Signed-off-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
[dianders: rebase + roll in http://crosreview.com/259916]
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
 drivers/mmc/core/host.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 71bb2372f71d..7ecb6a6351b3 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -321,8 +321,8 @@ EXPORT_SYMBOL(mmc_of_parse);
  */
 struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 {
-	int err;
 	struct mmc_host *host;
+	int of_id = -1, id = -1;
 
 	host = kzalloc(sizeof(struct mmc_host) + extra, GFP_KERNEL);
 	if (!host)
@@ -330,14 +330,29 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 
 	/* scanning will be enabled when we're ready */
 	host->rescan_disable = 1;
+
+	if (dev->of_node)
+		of_id = of_alias_get_id(dev->of_node, "mmc");
+
 	idr_preload(GFP_KERNEL);
 	spin_lock(&mmc_host_lock);
-	err = idr_alloc(&mmc_host_idr, host, 0, 0, GFP_NOWAIT);
-	if (err >= 0)
-		host->index = err;
+
+	if (of_id >= 0) {
+		id = idr_alloc(&mmc_host_idr, host, of_id, of_id + 1,
+			       GFP_NOWAIT);
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
-	if (err < 0) {
+	if (id < 0) {
 		kfree(host);
 		return NULL;
 	}
-- 
2.8.0.rc3.226.g39d4020

