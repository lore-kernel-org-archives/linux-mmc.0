From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 6/7] mmc: core: Free all resources for the class device at ->dev_release()
Date: Thu, 18 Dec 2014 15:44:35 +0100
Message-ID: <1418913876-13937-7-git-send-email-ulf.hansson@linaro.org>
References: <1418913876-13937-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:35414 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752365AbaLROoz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Dec 2014 09:44:55 -0500
Received: by mail-wg0-f51.google.com with SMTP id x12so1789578wgg.38
        for <linux-mmc@vger.kernel.org>; Thu, 18 Dec 2014 06:44:54 -0800 (PST)
In-Reply-To: <1418913876-13937-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>

To be consistent when freeing data, let's move the idr_remove() call
from mmc_free_host() into the ->dev_release() callback for the class
device.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/host.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 45c2dae..fcb7f06 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -32,10 +32,16 @@
 
 #define cls_dev_to_mmc_host(d)	container_of(d, struct mmc_host, class_dev)
 
+static DEFINE_IDR(mmc_host_idr);
+static DEFINE_SPINLOCK(mmc_host_lock);
+
 static void mmc_host_classdev_release(struct device *dev)
 {
 	struct mmc_host *host = cls_dev_to_mmc_host(dev);
 	mutex_destroy(&host->slot.lock);
+	spin_lock(&mmc_host_lock);
+	idr_remove(&mmc_host_idr, host->index);
+	spin_unlock(&mmc_host_lock);
 	kfree(host);
 }
 
@@ -54,9 +60,6 @@ void mmc_unregister_host_class(void)
 	class_unregister(&mmc_host_class);
 }
 
-static DEFINE_IDR(mmc_host_idr);
-static DEFINE_SPINLOCK(mmc_host_lock);
-
 #ifdef CONFIG_MMC_CLKGATE
 static ssize_t clkgate_delay_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
@@ -585,10 +588,6 @@ EXPORT_SYMBOL(mmc_remove_host);
  */
 void mmc_free_host(struct mmc_host *host)
 {
-	spin_lock(&mmc_host_lock);
-	idr_remove(&mmc_host_idr, host->index);
-	spin_unlock(&mmc_host_lock);
-
 	put_device(&host->class_dev);
 }
 
-- 
1.9.1

