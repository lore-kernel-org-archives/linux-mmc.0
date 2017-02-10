From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH RFC 25/39] mmc: sdhci: Improve debug print format
Date: Fri, 10 Feb 2017 14:55:38 +0200
Message-ID: <1486731352-8018-26-git-send-email-adrian.hunter@intel.com>
References: <1486731352-8018-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:7550 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753085AbdBJPrK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 10 Feb 2017 10:47:10 -0500
In-Reply-To: <1486731352-8018-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>

Ensure all debug prints start with the mmc host name.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 6fdd7a70f229..8aa8541a349a 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -37,7 +37,7 @@
 #define DRIVER_NAME "sdhci"
 
 #define DBG(f, x...) \
-	pr_debug(DRIVER_NAME " [%s()]: " f, __func__,## x)
+	pr_debug("%s: " DRIVER_NAME ": " f, mmc_hostname(host->mmc), ## x)
 
 #define MAX_TUNING_LOOP 40
 
@@ -715,8 +715,8 @@ static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd)
 	}
 
 	if (count >= 0xF) {
-		DBG("%s: Too large timeout 0x%x requested for CMD%d!\n",
-		    mmc_hostname(host->mmc), count, cmd->opcode);
+		DBG("Too large timeout 0x%x requested for CMD%d!\n",
+		    count, cmd->opcode);
 		count = 0xE;
 	}
 
@@ -2509,7 +2509,6 @@ static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask)
 #ifdef CONFIG_MMC_DEBUG
 static void sdhci_adma_show_error(struct sdhci_host *host)
 {
-	const char *name = mmc_hostname(host->mmc);
 	void *desc = host->adma_table;
 
 	sdhci_dumpregs(host);
@@ -2518,14 +2517,14 @@ static void sdhci_adma_show_error(struct sdhci_host *host)
 		struct sdhci_adma2_64_desc *dma_desc = desc;
 
 		if (host->flags & SDHCI_USE_64_BIT_DMA)
-			DBG("%s: %p: DMA 0x%08x%08x, LEN 0x%04x, Attr=0x%02x\n",
-			    name, desc, le32_to_cpu(dma_desc->addr_hi),
+			DBG("%p: DMA 0x%08x%08x, LEN 0x%04x, Attr=0x%02x\n",
+			    desc, le32_to_cpu(dma_desc->addr_hi),
 			    le32_to_cpu(dma_desc->addr_lo),
 			    le16_to_cpu(dma_desc->len),
 			    le16_to_cpu(dma_desc->cmd));
 		else
-			DBG("%s: %p: DMA 0x%08x, LEN 0x%04x, Attr=0x%02x\n",
-			    name, desc, le32_to_cpu(dma_desc->addr_lo),
+			DBG("%p: DMA 0x%08x, LEN 0x%04x, Attr=0x%02x\n",
+			    desc, le32_to_cpu(dma_desc->addr_lo),
 			    le16_to_cpu(dma_desc->len),
 			    le16_to_cpu(dma_desc->cmd));
 
@@ -2641,10 +2640,8 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 				~(SDHCI_DEFAULT_BOUNDARY_SIZE - 1)) +
 				SDHCI_DEFAULT_BOUNDARY_SIZE;
 			host->data->bytes_xfered = dmanow - dmastart;
-			DBG("%s: DMA base 0x%08x, transferred 0x%06x bytes,"
-				" next 0x%08x\n",
-				mmc_hostname(host->mmc), dmastart,
-				host->data->bytes_xfered, dmanow);
+			DBG("DMA base 0x%08x, transferred 0x%06x bytes, next 0x%08x\n",
+			    dmastart, host->data->bytes_xfered, dmanow);
 			sdhci_writel(host, dmanow, SDHCI_DMA_ADDRESS);
 		}
 
@@ -2689,8 +2686,7 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 				  SDHCI_INT_BUS_POWER);
 		sdhci_writel(host, mask, SDHCI_INT_STATUS);
 
-		DBG("*** %s got interrupt: 0x%08x\n",
-			mmc_hostname(host->mmc), intmask);
+		DBG("IRQ status 0x%08x\n", intmask);
 
 		if (intmask & (SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE)) {
 			u32 present = sdhci_readl(host, SDHCI_PRESENT_STATE) &
@@ -3324,9 +3320,9 @@ int sdhci_setup_host(struct sdhci_host *host)
 	     !(host->flags & SDHCI_USE_SDMA)) &&
 	     !(host->quirks2 & SDHCI_QUIRK2_ACMD23_BROKEN)) {
 		host->flags |= SDHCI_AUTO_CMD23;
-		DBG("%s: Auto-CMD23 available\n", mmc_hostname(mmc));
+		DBG("Auto-CMD23 available\n");
 	} else {
-		DBG("%s: Auto-CMD23 unavailable\n", mmc_hostname(mmc));
+		DBG("Auto-CMD23 unavailable\n");
 	}
 
 	/*
-- 
1.9.1

