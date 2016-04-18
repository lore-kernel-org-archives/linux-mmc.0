From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/3] mmc: core: Convert from IDR to IDA for host indexes
Date: Mon, 18 Apr 2016 13:43:52 +0200
Message-ID: <1460979834-24582-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:34225 "EHLO
	mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751560AbcDRLoO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Apr 2016 07:44:14 -0400
Received: by mail-lf0-f43.google.com with SMTP id j11so212984120lfb.1
        for <linux-mmc@vger.kernel.org>; Mon, 18 Apr 2016 04:44:13 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

As IDA is more lightweight than IDR, let's convert to use that instead.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/host.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 6e4c55a..e0a3ee1 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -33,14 +33,14 @@
 
 #define cls_dev_to_mmc_host(d)	container_of(d, struct mmc_host, class_dev)
 
-static DEFINE_IDR(mmc_host_idr);
+static DEFINE_IDA(mmc_host_ida);
 static DEFINE_SPINLOCK(mmc_host_lock);
 
 static void mmc_host_classdev_release(struct device *dev)
 {
 	struct mmc_host *host = cls_dev_to_mmc_host(dev);
 	spin_lock(&mmc_host_lock);
-	idr_remove(&mmc_host_idr, host->index);
+	ida_remove(&mmc_host_ida, host->index);
 	spin_unlock(&mmc_host_lock);
 	kfree(host);
 }
@@ -321,14 +321,20 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 
 	/* scanning will be enabled when we're ready */
 	host->rescan_disable = 1;
-	idr_preload(GFP_KERNEL);
+
+again:
+	if (!ida_pre_get(&mmc_host_ida, GFP_KERNEL)) {
+		kfree(host);
+		return NULL;
+	}
+
 	spin_lock(&mmc_host_lock);
-	err = idr_alloc(&mmc_host_idr, host, 0, 0, GFP_NOWAIT);
-	if (err >= 0)
-		host->index = err;
+	err = ida_get_new(&mmc_host_ida, &host->index);
 	spin_unlock(&mmc_host_lock);
-	idr_preload_end();
-	if (err < 0) {
+
+	if (err == -EAGAIN) {
+		goto again;
+	} else if (err) {
 		kfree(host);
 		return NULL;
 	}
-- 
1.9.1

