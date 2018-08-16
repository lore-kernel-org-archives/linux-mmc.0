From: Chunyan Zhang <zhang.chunyan@linaro.org>
Subject: [PATCH V5 03/10] mmc: sdhci: Change SDMA address register for v4 mode
Date: Thu, 16 Aug 2018 15:54:17 +0800
Message-ID: <1534406064-10065-4-git-send-email-zhang.chunyan@linaro.org>
References: <1534406064-10065-1-git-send-email-zhang.chunyan@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534406064-10065-1-git-send-email-zhang.chunyan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linaro.org>, Billows Wu <billows.wu@unisoc.com>, Jason Wu <jason.wu@unisoc.com>, Chunyan Zhang <zhang.lyra@gmail.com>
List-Id: linux-mmc@vger.kernel.org

According to the SD host controller specification version 4.10, when
Host Version 4 is enabled, SDMA uses ADMA System Address register
(05Fh-058h) instead of using SDMA System Address register to
support both 32-bit and 64-bit addressing.

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
---
 drivers/mmc/host/sdhci.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index d808a1f..1f0f1e4 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -727,7 +727,7 @@ static void sdhci_adma_table_post(struct sdhci_host *host,
 	}
 }
 
-static u32 sdhci_sdma_address(struct sdhci_host *host)
+static dma_addr_t sdhci_sdma_address(struct sdhci_host *host)
 {
 	if (host->bounce_buffer)
 		return host->bounce_addr;
@@ -735,6 +735,17 @@ static u32 sdhci_sdma_address(struct sdhci_host *host)
 		return sg_dma_address(host->data->sg);
 }
 
+static void sdhci_set_sdma_addr(struct sdhci_host *host, dma_addr_t addr)
+{
+	if (host->v4_mode) {
+		sdhci_writel(host, addr, SDHCI_ADMA_ADDRESS);
+		if (host->flags & SDHCI_USE_64_BIT_DMA)
+			sdhci_writel(host, (u64)addr >> 32, SDHCI_ADMA_ADDRESS_HI);
+	} else {
+		sdhci_writel(host, addr, SDHCI_DMA_ADDRESS);
+	}
+}
+
 static unsigned int sdhci_target_timeout(struct sdhci_host *host,
 					 struct mmc_command *cmd,
 					 struct mmc_data *data)
@@ -994,8 +1005,7 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 					     SDHCI_ADMA_ADDRESS_HI);
 		} else {
 			WARN_ON(sg_cnt != 1);
-			sdhci_writel(host, sdhci_sdma_address(host),
-				     SDHCI_DMA_ADDRESS);
+			sdhci_set_sdma_addr(host, sdhci_sdma_address(host));
 		}
 	}
 
@@ -2822,7 +2832,7 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 		 * some controllers are faulty, don't trust them.
 		 */
 		if (intmask & SDHCI_INT_DMA_END) {
-			u32 dmastart, dmanow;
+			dma_addr_t dmastart, dmanow;
 
 			dmastart = sdhci_sdma_address(host);
 			dmanow = dmastart + host->data->bytes_xfered;
@@ -2830,12 +2840,12 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 			 * Force update to the next DMA block boundary.
 			 */
 			dmanow = (dmanow &
-				~(SDHCI_DEFAULT_BOUNDARY_SIZE - 1)) +
+				~((dma_addr_t)SDHCI_DEFAULT_BOUNDARY_SIZE - 1)) +
 				SDHCI_DEFAULT_BOUNDARY_SIZE;
 			host->data->bytes_xfered = dmanow - dmastart;
-			DBG("DMA base 0x%08x, transferred 0x%06x bytes, next 0x%08x\n",
-			    dmastart, host->data->bytes_xfered, dmanow);
-			sdhci_writel(host, dmanow, SDHCI_DMA_ADDRESS);
+			DBG("DMA base %pad, transferred 0x%06x bytes, next %pad\n",
+			    &dmastart, host->data->bytes_xfered, &dmanow);
+			sdhci_set_sdma_addr(host, dmanow);
 		}
 
 		if (intmask & SDHCI_INT_DATA_END) {
@@ -3582,8 +3592,8 @@ int sdhci_setup_host(struct sdhci_host *host)
 		}
 	}
 
-	/* SDMA does not support 64-bit DMA */
-	if (host->flags & SDHCI_USE_64_BIT_DMA)
+	/* SDMA does not support 64-bit DMA if v4 mode not set */
+	if ((host->flags & SDHCI_USE_64_BIT_DMA) && !host->v4_mode)
 		host->flags &= ~SDHCI_USE_SDMA;
 
 	if (host->flags & SDHCI_USE_ADMA) {
-- 
2.7.4
