From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 13/15] mmc: sdhci-acpi: Add 64-bit DMA support
Date: Tue, 21 Oct 2014 12:26:23 +0300
Message-ID: <1413883585-16299-14-git-send-email-adrian.hunter@intel.com>
References: <1413883585-16299-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:44625 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932323AbaJUJ2N (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 21 Oct 2014 05:28:13 -0400
In-Reply-To: <1413883585-16299-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Set the DMA mask during the first call to ->enable_dma() to
make use of the SDHCI_USE_64_BIT_DMA flag.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-acpi.c | 41 +++++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 9cccc0e..637c6c4 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -76,6 +76,7 @@ struct sdhci_acpi_host {
 	const struct sdhci_acpi_slot	*slot;
 	struct platform_device		*pdev;
 	bool				use_runtime_pm;
+	bool				dma_setup;
 };
 
 static inline bool sdhci_acpi_flag(struct sdhci_acpi_host *c, unsigned int flag)
@@ -85,7 +86,30 @@ static inline bool sdhci_acpi_flag(struct sdhci_acpi_host *c, unsigned int flag)
 
 static int sdhci_acpi_enable_dma(struct sdhci_host *host)
 {
-	return 0;
+	struct sdhci_acpi_host *c = sdhci_priv(host);
+	struct device *dev = &c->pdev->dev;
+	int err = -1;
+
+	if (c->dma_setup)
+		return 0;
+
+	if (host->flags & SDHCI_USE_64_BIT_DMA) {
+		if (host->quirks2 & SDHCI_QUIRK2_BROKEN_64_BIT_DMA) {
+			host->flags &= ~SDHCI_USE_64_BIT_DMA;
+		} else {
+			err = dma_coerce_mask_and_coherent(dev,
+							   DMA_BIT_MASK(64));
+			if (err)
+				dev_warn(dev, "Failed to set 64-bit DMA mask\n");
+		}
+	}
+
+	if (err)
+		err = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(32));
+
+	c->dma_setup = !err;
+
+	return err;
 }
 
 static void sdhci_acpi_int_hw_reset(struct sdhci_host *host)
@@ -305,21 +329,6 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
 		goto err_free;
 	}
 
-	if (!dev->dma_mask) {
-		u64 dma_mask;
-
-		if (sdhci_readl(host, SDHCI_CAPABILITIES) & SDHCI_CAN_64BIT) {
-			/* 64-bit DMA is not supported at present */
-			dma_mask = DMA_BIT_MASK(32);
-		} else {
-			dma_mask = DMA_BIT_MASK(32);
-		}
-
-		err = dma_coerce_mask_and_coherent(dev, dma_mask);
-		if (err)
-			goto err_free;
-	}
-
 	if (c->slot) {
 		if (c->slot->probe_slot) {
 			err = c->slot->probe_slot(pdev, hid, uid);
-- 
1.9.1

