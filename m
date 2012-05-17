From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: [PATCH v2 2/6] mmc: dw_mmc: allow probe to succeed even if one slot is
 initialized
Date: Thu, 17 May 2012 20:40:07 +0530
Message-ID: <1337267411-28226-3-git-send-email-thomas.abraham@linaro.org>
References: <1337267411-28226-1-git-send-email-thomas.abraham@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1337267411-28226-1-git-send-email-thomas.abraham@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, patches@linaro.org
List-Id: linux-mmc@vger.kernel.org

Instead of aborting the probe in case a slot initialization fails, allow
initialization of as many slots as possible. If there are atleast one
instance of slot that is successfully initialized, allow the driver probe
to succeed.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 drivers/mmc/host/dw_mmc.c |   23 +++++++++++++----------
 1 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 01d870a..5f38667 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1925,6 +1925,7 @@ int dw_mci_probe(struct dw_mci *host)
 {
 	int width, i, ret = 0;
 	u32 fifo_size;
+	int init_slots = 0;
 
 	if (!host->pdata || !host->pdata->init) {
 		dev_err(host->dev,
@@ -2036,10 +2037,18 @@ int dw_mci_probe(struct dw_mci *host)
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
@@ -2074,12 +2083,6 @@ int dw_mci_probe(struct dw_mci *host)
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
