From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH] mmc: tmio: remove broken and noisy debug macro
Date: Thu, 14 Sep 2017 14:30:43 +0200
Message-ID: <20170914123043.21451-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-mmc@vger.kernel.org

Some change for v4.14 broke the debug output for TMIO. But since it was
not helpful to me and too noisy for my taste anyhow, let's just remove
it instead of fixing it. We'll find something better if we'd need it...

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/tmio_mmc_core.c | 47 ----------------------------------------
 1 file changed, 47 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 12cf8288d6635e..a7293e186e03fc 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -129,50 +129,6 @@ static int tmio_mmc_next_sg(struct tmio_mmc_host *host)
 
 #define CMDREQ_TIMEOUT	5000
 
-#ifdef CONFIG_MMC_DEBUG
-
-#define STATUS_TO_TEXT(a, status, i) \
-	do { \
-		if ((status) & TMIO_STAT_##a) { \
-			if ((i)++) \
-				printk(KERN_DEBUG " | "); \
-			printk(KERN_DEBUG #a); \
-		} \
-	} while (0)
-
-static void pr_debug_status(u32 status)
-{
-	int i = 0;
-
-	pr_debug("status: %08x = ", status);
-	STATUS_TO_TEXT(CARD_REMOVE, status, i);
-	STATUS_TO_TEXT(CARD_INSERT, status, i);
-	STATUS_TO_TEXT(SIGSTATE, status, i);
-	STATUS_TO_TEXT(WRPROTECT, status, i);
-	STATUS_TO_TEXT(CARD_REMOVE_A, status, i);
-	STATUS_TO_TEXT(CARD_INSERT_A, status, i);
-	STATUS_TO_TEXT(SIGSTATE_A, status, i);
-	STATUS_TO_TEXT(CMD_IDX_ERR, status, i);
-	STATUS_TO_TEXT(STOPBIT_ERR, status, i);
-	STATUS_TO_TEXT(ILL_FUNC, status, i);
-	STATUS_TO_TEXT(CMD_BUSY, status, i);
-	STATUS_TO_TEXT(CMDRESPEND, status, i);
-	STATUS_TO_TEXT(DATAEND, status, i);
-	STATUS_TO_TEXT(CRCFAIL, status, i);
-	STATUS_TO_TEXT(DATATIMEOUT, status, i);
-	STATUS_TO_TEXT(CMDTIMEOUT, status, i);
-	STATUS_TO_TEXT(RXOVERFLOW, status, i);
-	STATUS_TO_TEXT(TXUNDERRUN, status, i);
-	STATUS_TO_TEXT(RXRDY, status, i);
-	STATUS_TO_TEXT(TXRQ, status, i);
-	STATUS_TO_TEXT(ILL_ACCESS, status, i);
-	printk("\n");
-}
-
-#else
-#define pr_debug_status(s)  do { } while (0)
-#endif
-
 static void tmio_mmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
 {
 	struct tmio_mmc_host *host = mmc_priv(mmc);
@@ -762,9 +718,6 @@ irqreturn_t tmio_mmc_irq(int irq, void *devid)
 	status = sd_ctrl_read16_and_16_as_32(host, CTL_STATUS);
 	ireg = status & TMIO_MASK_IRQ & ~host->sdcard_irq_mask;
 
-	pr_debug_status(status);
-	pr_debug_status(ireg);
-
 	/* Clear the status except the interrupt status */
 	sd_ctrl_write32_as_16_and_16(host, CTL_STATUS, TMIO_MASK_IRQ);
 
-- 
2.11.0
