From: Alexandre Courbot <acourbot@nvidia.com>
Subject: [PATCH v3 1/3] mmc: sdhci: Set DMA mask when adding host
Date: Fri, 4 Mar 2016 19:38:43 +0900
Message-ID: <1457087925-992-2-git-send-email-acourbot@nvidia.com>
References: <1457087925-992-1-git-send-email-acourbot@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457087925-992-1-git-send-email-acourbot@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, gnurou@gmail.com, Alexandre Courbot <acourbot@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

Set the DMA mask in sdhci_add_host() after we determined the
capabilities of the device. 64-bit devices in particular are given the
proper mask that ensures bounce buffers are not used.

Also disable DMA if no proper DMA mask can be set, as the DMA-API
documentation specifies.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/mmc/host/sdhci.c | 46 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 39 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index fd9139947fa3..00fb45ba6f39 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2857,6 +2857,34 @@ struct sdhci_host *sdhci_alloc_host(struct device *dev,
 
 EXPORT_SYMBOL_GPL(sdhci_alloc_host);
 
+static int sdhci_set_dma_mask(struct sdhci_host *host)
+{
+	struct mmc_host *mmc = host->mmc;
+	struct device *dev = mmc_dev(mmc);
+	int ret = -EINVAL;
+
+	if (host->quirks2 & SDHCI_QUIRK2_BROKEN_64_BIT_DMA)
+		host->flags &= ~SDHCI_USE_64_BIT_DMA;
+
+	/* Try 64-bit mask if hardware is capable  of it */
+	if (host->flags & SDHCI_USE_64_BIT_DMA) {
+		ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
+		if (ret)
+			pr_warn("%s: Failed to set 64-bit DMA mask.\n",
+				mmc_hostname(mmc));
+	}
+
+	/* 32-bit mask as default & fallback */
+	if (ret) {
+		ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
+		if (ret)
+			pr_warn("%s: Failed to set 32-bit DMA mask.\n",
+				mmc_hostname(mmc));
+	}
+
+	return ret;
+}
+
 int sdhci_add_host(struct sdhci_host *host)
 {
 	struct mmc_host *mmc;
@@ -2932,13 +2960,17 @@ int sdhci_add_host(struct sdhci_host *host)
 		host->flags |= SDHCI_USE_64_BIT_DMA;
 
 	if (host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA)) {
-		if (host->ops->enable_dma) {
-			if (host->ops->enable_dma(host)) {
-				pr_warn("%s: No suitable DMA available - falling back to PIO\n",
-					mmc_hostname(mmc));
-				host->flags &=
-					~(SDHCI_USE_SDMA | SDHCI_USE_ADMA);
-			}
+		ret = sdhci_set_dma_mask(host);
+
+		if (!ret && host->ops->enable_dma)
+			ret = host->ops->enable_dma(host);
+
+		if (ret) {
+			pr_warn("%s: No suitable DMA available - falling back to PIO\n",
+				mmc_hostname(mmc));
+			host->flags &= ~(SDHCI_USE_SDMA | SDHCI_USE_ADMA);
+
+			ret = 0;
 		}
 	}
 
-- 
2.7.2
