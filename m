From: Alexandre Courbot <acourbot@nvidia.com>
Subject: [PATCH v4 3/3] mmc: sdhci-pci: Do not set DMA mask in enable_dma()
Date: Mon, 7 Mar 2016 11:07:57 +0900
Message-ID: <1457316477-8153-4-git-send-email-acourbot@nvidia.com>
References: <1457316477-8153-1-git-send-email-acourbot@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:14783 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751992AbcCGCIR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 6 Mar 2016 21:08:17 -0500
In-Reply-To: <1457316477-8153-1-git-send-email-acourbot@nvidia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, gnurou@gmail.com, Alexandre Courbot <acourbot@nvidia.com>

DMA mask will already be set by sdhci_set_dma_mask(), which
is equivalent to the removed code since pci_set_dma_mask()
expands to its DMA-API counterpart.

There should also be no reason to set the DMA mask after probe.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mmc/host/sdhci-pci-core.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index df3b8eced8c4..62aa5d0efcee 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -1302,7 +1302,6 @@ static int sdhci_pci_enable_dma(struct sdhci_host *host)
 {
 	struct sdhci_pci_slot *slot;
 	struct pci_dev *pdev;
-	int ret = -1;
 
 	slot = sdhci_priv(host);
 	pdev = slot->chip->pdev;
@@ -1314,20 +1313,6 @@ static int sdhci_pci_enable_dma(struct sdhci_host *host)
 			"doesn't fully claim to support it.\n");
 	}
 
-	if (host->flags & SDHCI_USE_64_BIT_DMA) {
-		if (host->quirks2 & SDHCI_QUIRK2_BROKEN_64_BIT_DMA) {
-			host->flags &= ~SDHCI_USE_64_BIT_DMA;
-		} else {
-			ret = pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
-			if (ret)
-				dev_warn(&pdev->dev, "Failed to set 64-bit DMA mask\n");
-		}
-	}
-	if (ret)
-		ret = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
-	if (ret)
-		return ret;
-
 	pci_set_master(pdev);
 
 	return 0;
-- 
2.7.2

