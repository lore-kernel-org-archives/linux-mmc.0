From: Chunyan Zhang <zhang.chunyan@linaro.org>
Subject: [PATCH V3 4/7] mmc: sdhci: add 32-bit block count support for v4 mode
Date: Mon,  9 Jul 2018 11:19:55 +0800
Message-ID: <1531106398-14062-5-git-send-email-zhang.chunyan@linaro.org>
References: <1531106398-14062-1-git-send-email-zhang.chunyan@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531106398-14062-1-git-send-email-zhang.chunyan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linaro.org>, Billows Wu <billows.wu@spreadtrum.com>, zhang.lyra@gmail.com
List-Id: linux-mmc@vger.kernel.org

When Host Version 4 is enabled, SDMA System Address register is
re-defined as 32-bit Block Count, and SDMA uses ADMA System
Address register (05Fh-058h) instead.

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
---
 drivers/mmc/host/sdhci.c | 4 +++-
 drivers/mmc/host/sdhci.h | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 7871ae2..f64e766 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -889,6 +889,7 @@ static void sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
 static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 {
 	u8 ctrl;
+	u32 reg;
 	struct mmc_data *data = cmd->data;
 
 	host->data_timeout = 0;
@@ -1021,7 +1022,8 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 	/* Set the DMA boundary value and block size */
 	sdhci_writew(host, SDHCI_MAKE_BLKSZ(host->sdma_boundary, data->blksz),
 		     SDHCI_BLOCK_SIZE);
-	sdhci_writew(host, data->blocks, SDHCI_BLOCK_COUNT);
+	reg = host->v4_mode ? SDHCI_32BIT_BLK_CNT : SDHCI_BLOCK_COUNT;
+	sdhci_writew(host, data->blocks, reg);
 }
 
 static inline bool sdhci_auto_cmd12(struct sdhci_host *host,
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 24fa58a..889e48b 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -28,6 +28,7 @@
 
 #define SDHCI_DMA_ADDRESS	0x00
 #define SDHCI_ARGUMENT2		SDHCI_DMA_ADDRESS
+#define SDHCI_32BIT_BLK_CNT	SDHCI_DMA_ADDRESS
 
 #define SDHCI_BLOCK_SIZE	0x04
 #define  SDHCI_MAKE_BLKSZ(dma, blksz) (((dma & 0x7) << 12) | (blksz & 0xFFF))
-- 
2.7.4
