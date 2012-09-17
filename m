From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: [PATCH v6 3/9] mmc: dw_mmc: allow probe to succeed even if one slot is
 initialized
Date: Mon, 17 Sep 2012 23:46:37 +0530
Message-ID: <1347905803-22742-4-git-send-email-thomas.abraham@linaro.org>
References: <1347905803-22742-1-git-send-email-thomas.abraham@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:20900 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757092Ab2IQR4q (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Sep 2012 13:56:46 -0400
In-reply-to: <1347905803-22742-1-git-send-email-thomas.abraham@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: will.newton@imgtec.com, cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, girish.shivananjappa@linaro.org, jh80.chung@samsung.com, tgih.jun@samsung.com, patches@linaro.org

Instead of aborting the probe in case a slot initialization fails, allow
initialization of as many slots as possible. If there are atleast one
instance of slot that is successfully initialized, allow the driver probe
to succeed.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
Acked-by: Will Newton <will.newton@imgtec.com>
---
 drivers/mmc/host/dw_mmc.c |   23 +++++++++++++----------
 1 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index a18e73c..227c42e 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1946,6 +1946,7 @@ int dw_mci_probe(struct dw_mci *host)
 {
 	int width, i, ret = 0;
 	u32 fifo_size;
+	int init_slots = 0;
 
 	if (!host->pdata || !host->pdata->init) {
 		dev_err(host->dev,
@@ -2054,10 +2055,18 @@ int dw_mci_probe(struct dw_mci *host)
 	/* We need at least one slot to succeed */
 	for (i = 0; i < host->num_slots; i++) {
 		ret = dw_mci_init_slot(host, i);
-		if (ret) {
-			ret = -ENODEV;
-			goto err_init_slot;
-		}
+		if (ret)
+			dev_dbg(host->dev, "slot %d init failed\n", i);
+		else
+			init_slots++;
+	}
+
+	if (init_slots) {
+		dev_info(host->dev, "%d slots initialized\n", init_slots);
+	} else {
+		dev_dbg(host->dev, "attempted to initialize %d slots, "
+					"but failed on all\n", host->num_slots);
+		goto err_init_slot;
 	}
 
 	/*
@@ -2092,12 +2101,6 @@ int dw_mci_probe(struct dw_mci *host)
 	return 0;
 
 err_init_slot:
-	/* De-init any initialized slots */
-	while (i > 0) {
-		if (host->slot[i])
-			dw_mci_cleanup_slot(host->slot[i], i);
-		i--;
-	}
 	free_irq(host->irq, host);
 
 err_workqueue:
-- 
1.6.6.rc2

