From: Chunyan Zhang <zhang.chunyan@linaro.org>
Subject: [PATCH V8 5/9] mmc: sdhci: Add 32-bit block count support for v4 mode
Date: Thu, 30 Aug 2018 16:21:41 +0800
Message-ID: <1535617305-16952-6-git-send-email-zhang.chunyan@linaro.org>
References: <1535617305-16952-1-git-send-email-zhang.chunyan@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1535617305-16952-1-git-send-email-zhang.chunyan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh+dt@kernel.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linaro.org>, Billows Wu <billows.wu@unisoc.com>, Jason Wu <jason.wu@unisoc.com>, Chunyan Zhang <chunyan.zhang@unisoc.com>, Chunyan Zhang <zhang.lyra@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Host Controller Version 4.10 re-defines SDMA System Address register
as 32-bit Block Count for v4 mode, and SDMA uses ADMA System
Address register (05Fh-058h) instead if v4 mode is enabled. Also
when using 32-bit block count, 16-bit block count register need
to be set to zero.

Since using 32-bit Block Count would cause problems for auto-cmd23,
it can be chosen via host->quirk2.

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 14 +++++++++++++-
 drivers/mmc/host/sdhci.h |  8 ++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 17345b6..604bf4c 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1073,7 +1073,19 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 	/* Set the DMA boundary value and block size */
 	sdhci_writew(host, SDHCI_MAKE_BLKSZ(host->sdma_boundary, data->blksz),
 		     SDHCI_BLOCK_SIZE);
-	sdhci_writew(host, data->blocks, SDHCI_BLOCK_COUNT);
+
+	/*
+	 * For Version 4.10 onwards, if v4 mode is enabled, 32-bit Block Count
+	 * can be supported, in that case 16-bit block count register must be 0.
+	 */
+	if (host->version >= SDHCI_SPEC_410 && host->v4_mode &&
+	    (host->quirks2 & SDHCI_QUIRK2_USE_32BIT_BLK_CNT)) {
+		if (sdhci_readw(host, SDHCI_BLOCK_COUNT))
+			sdhci_writew(host, 0, SDHCI_BLOCK_COUNT);
+		sdhci_writew(host, data->blocks, SDHCI_32BIT_BLK_CNT);
+	} else {
+		sdhci_writew(host, data->blocks, SDHCI_BLOCK_COUNT);
+	}
 }
 
 static inline bool sdhci_auto_cmd12(struct sdhci_host *host,
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index c5cc513..f7a1079 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -28,6 +28,7 @@
 
 #define SDHCI_DMA_ADDRESS	0x00
 #define SDHCI_ARGUMENT2		SDHCI_DMA_ADDRESS
+#define SDHCI_32BIT_BLK_CNT	SDHCI_DMA_ADDRESS
 
 #define SDHCI_BLOCK_SIZE	0x04
 #define  SDHCI_MAKE_BLKSZ(dma, blksz) (((dma & 0x7) << 12) | (blksz & 0xFFF))
@@ -462,6 +463,13 @@ struct sdhci_host {
  * obtainable timeout.
  */
 #define SDHCI_QUIRK2_DISABLE_HW_TIMEOUT			(1<<17)
+/*
+ * 32-bit block count may not support eMMC where upper bits of CMD23 are used
+ * for other purposes.  Consequently we support 16-bit block count by default.
+ * Otherwise, SDHCI_QUIRK2_USE_32BIT_BLK_CNT can be selected to use 32-bit
+ * block count.
+ */
+#define SDHCI_QUIRK2_USE_32BIT_BLK_CNT			(1<<18)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
2.7.4
