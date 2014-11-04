From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 14/15] mmc: sdhci-pci: Add 64-bit DMA support
Date: Tue,  4 Nov 2014 12:42:48 +0200
Message-ID: <1415097769-19032-15-git-send-email-adrian.hunter@intel.com>
References: <1415097769-19032-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:52221 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753123AbaKDKpN (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 4 Nov 2014 05:45:13 -0500
In-Reply-To: <1415097769-19032-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Set a 64-bit DMA mask when using 64-bit DMA.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sdhci-pci.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index 6119297..c25639b 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -1064,7 +1064,7 @@ static int sdhci_pci_enable_dma(struct sdhci_host *host)
 {
 	struct sdhci_pci_slot *slot;
 	struct pci_dev *pdev;
-	int ret;
+	int ret = -1;
 
 	slot = sdhci_priv(host);
 	pdev = slot->chip->pdev;
@@ -1076,7 +1076,17 @@ static int sdhci_pci_enable_dma(struct sdhci_host *host)
 			"doesn't fully claim to support it.\n");
 	}
 
-	ret = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
+	if (host->flags & SDHCI_USE_64_BIT_DMA) {
+		if (host->quirks2 & SDHCI_QUIRK2_BROKEN_64_BIT_DMA) {
+			host->flags &= ~SDHCI_USE_64_BIT_DMA;
+		} else {
+			ret = pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
+			if (ret)
+				dev_warn(&pdev->dev, "Failed to set 64-bit DMA mask\n");
+		}
+	}
+	if (ret)
+		ret = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
 	if (ret)
 		return ret;
 
-- 
1.9.1

