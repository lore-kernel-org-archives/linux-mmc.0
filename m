From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 1/2] mmc: core: simplify ida handling
Date: Sat, 28 Jan 2017 09:32:35 +0100
Message-ID: <4dae93b9-78f6-25c5-4836-4a70a5a00ab6@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34413 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750904AbdA1Imf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 28 Jan 2017 03:42:35 -0500
Received: by mail-wm0-f65.google.com with SMTP id c85so63318169wmi.1
        for <linux-mmc@vger.kernel.org>; Sat, 28 Jan 2017 00:41:36 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org

ida handling can be simplified by switching to the ida_simple_
functions.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/mmc/core/host.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 98f25ffb..0a26c8b6 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -34,14 +34,11 @@
 #define cls_dev_to_mmc_host(d)	container_of(d, struct mmc_host, class_dev)
 
 static DEFINE_IDA(mmc_host_ida);
-static DEFINE_SPINLOCK(mmc_host_lock);
 
 static void mmc_host_classdev_release(struct device *dev)
 {
 	struct mmc_host *host = cls_dev_to_mmc_host(dev);
-	spin_lock(&mmc_host_lock);
-	ida_remove(&mmc_host_ida, host->index);
-	spin_unlock(&mmc_host_lock);
+	ida_simple_remove(&mmc_host_ida, host->index);
 	kfree(host);
 }
 
@@ -354,22 +351,13 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 	/* scanning will be enabled when we're ready */
 	host->rescan_disable = 1;
 
-again:
-	if (!ida_pre_get(&mmc_host_ida, GFP_KERNEL)) {
+	err = ida_simple_get(&mmc_host_ida, 0, 0, GFP_KERNEL);
+	if (err < 0) {
 		kfree(host);
 		return NULL;
 	}
 
-	spin_lock(&mmc_host_lock);
-	err = ida_get_new(&mmc_host_ida, &host->index);
-	spin_unlock(&mmc_host_lock);
-
-	if (err == -EAGAIN) {
-		goto again;
-	} else if (err) {
-		kfree(host);
-		return NULL;
-	}
+	host->index = err;
 
 	dev_set_name(&host->class_dev, "mmc%d", host->index);
 
-- 
2.11.0

