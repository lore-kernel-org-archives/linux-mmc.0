From: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH v2 1/2] mmc: sdhci: Let drivers define their DMA mask
Date: Mon, 23 Sep 2019 12:08:09 +0200
Message-ID: <20190923100810.12698-1-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Jon Hunter <jonathanh@nvidia.com>, Nicolin Chen <nicoleotsuka@gmail.com>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Add host operation ->set_dma_mask() so that drivers can define their own
DMA masks.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v2:
- add Tested-by tag from Nicolin

 drivers/mmc/host/sdhci.c | 12 ++++--------
 drivers/mmc/host/sdhci.h |  1 +
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index d814dc004bad..cf38ff09bef0 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3782,18 +3782,14 @@ int sdhci_setup_host(struct sdhci_host *host)
 		host->flags &= ~SDHCI_USE_ADMA;
 	}
 
-	/*
-	 * It is assumed that a 64-bit capable device has set a 64-bit DMA mask
-	 * and *must* do 64-bit DMA.  A driver has the opportunity to change
-	 * that during the first call to ->enable_dma().  Similarly
-	 * SDHCI_QUIRK2_BROKEN_64_BIT_DMA must be left to the drivers to
-	 * implement.
-	 */
 	if (sdhci_can_64bit_dma(host))
 		host->flags |= SDHCI_USE_64_BIT_DMA;
 
 	if (host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA)) {
-		ret = sdhci_set_dma_mask(host);
+		if (host->ops->set_dma_mask)
+			ret = host->ops->set_dma_mask(host);
+		else
+			ret = sdhci_set_dma_mask(host);
 
 		if (!ret && host->ops->enable_dma)
 			ret = host->ops->enable_dma(host);
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index cf3d1ed91909..61018e7fb0b6 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -623,6 +623,7 @@ struct sdhci_ops {
 
 	u32		(*irq)(struct sdhci_host *host, u32 intmask);
 
+	int		(*set_dma_mask)(struct sdhci_host *host);
 	int		(*enable_dma)(struct sdhci_host *host);
 	unsigned int	(*get_max_clock)(struct sdhci_host *host);
 	unsigned int	(*get_min_clock)(struct sdhci_host *host);
-- 
2.23.0
