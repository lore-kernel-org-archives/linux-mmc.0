From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] mmc: host: Fix mmc_alloc_host() error path
Date: Fri, 12 Jun 2015 01:39:21 -0300
Message-ID: <1434083961-32540-1-git-send-email-festevam@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f182.google.com ([209.85.160.182]:35243 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732AbbFLEjr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 12 Jun 2015 00:39:47 -0400
Received: by ykfw62 with SMTP id w62so4993674ykf.2
        for <linux-mmc@vger.kernel.org>; Thu, 11 Jun 2015 21:39:46 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: adrian.hunter@intel.com, linux-mmc@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

If mmc_gpio_alloc() fails we miss to call 'kfree(host)', so rearrange
the error path to fix it. 

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/mmc/core/host.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 99a9c90..01fa1ed 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -566,10 +566,8 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 		host->index = err;
 	spin_unlock(&mmc_host_lock);
 	idr_preload_end();
-	if (err < 0) {
-		kfree(host);
-		return NULL;
-	}
+	if (err < 0)
+		goto err_kfree;
 
 	dev_set_name(&host->class_dev, "mmc%d", host->index);
 
@@ -578,10 +576,8 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 	host->class_dev.class = &mmc_host_class;
 	device_initialize(&host->class_dev);
 
-	if (mmc_gpio_alloc(host)) {
-		put_device(&host->class_dev);
-		return NULL;
-	}
+	if (mmc_gpio_alloc(host))
+		goto err_put_device;
 
 	mmc_host_clk_init(host);
 
@@ -605,6 +601,12 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 	host->max_blk_count = PAGE_CACHE_SIZE / 512;
 
 	return host;
+
+err_put_device:
+	put_device(&host->class_dev);
+err_kfree:
+	kfree(host);
+	return NULL;
 }
 
 EXPORT_SYMBOL(mmc_alloc_host);
-- 
1.9.1

