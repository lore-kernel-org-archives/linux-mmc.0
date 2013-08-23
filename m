From: Haijun Zhang <Haijun.Zhang@freescale.com>
Subject: [PATCH] mmc:sdhci: Add Auto-CMD12 err detecting and handling routine
Date: Fri, 23 Aug 2013 19:04:45 +0800
Message-ID: <1377255885-19330-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co9ehsobe005.messaging.microsoft.com ([207.46.163.28]:51252
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754738Ab3HWLGV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 23 Aug 2013 07:06:21 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, galak@kernel.crashing.org
Cc: cbouatmailru@gmail.com, cjb@laptop.org, scottwood@freescale.com, X.Xie@freescale.com, Haijun Zhang <Haijun.Zhang@freescale.com>, Haijun Zhang <haijun.zhang@freescale.com>

When Auto-CMD12 is enabled, Auto-cmd12 error status and signal
bit should be set to reflect this behaviour in case error.

Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
---
 drivers/mmc/host/sdhci.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index a78bd4f..db30b3e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -238,16 +238,23 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
 
 static void sdhci_init(struct sdhci_host *host, int soft)
 {
+	u32 init_irq;
+
 	if (soft)
 		sdhci_reset(host, SDHCI_RESET_CMD|SDHCI_RESET_DATA);
 	else
 		sdhci_reset(host, SDHCI_RESET_ALL);
 
-	sdhci_clear_set_irqs(host, SDHCI_INT_ALL_MASK,
-		SDHCI_INT_BUS_POWER | SDHCI_INT_DATA_END_BIT |
-		SDHCI_INT_DATA_CRC | SDHCI_INT_DATA_TIMEOUT | SDHCI_INT_INDEX |
-		SDHCI_INT_END_BIT | SDHCI_INT_CRC | SDHCI_INT_TIMEOUT |
-		SDHCI_INT_DATA_END | SDHCI_INT_RESPONSE);
+	init_irq = SDHCI_INT_BUS_POWER | SDHCI_INT_DATA_END_BIT |
+			SDHCI_INT_DATA_CRC | SDHCI_INT_DATA_TIMEOUT |
+			SDHCI_INT_INDEX | SDHCI_INT_END_BIT |
+			SDHCI_INT_CRC | SDHCI_INT_TIMEOUT |
+			SDHCI_INT_DATA_END | SDHCI_INT_RESPONSE;
+
+	if (host->flags & SDHCI_AUTO_CMD12)
+		init_irq |= SDHCI_INT_ACMD12ERR;
+
+	sdhci_clear_set_irqs(host, SDHCI_INT_ALL_MASK, init_irq);
 
 	if (soft) {
 		/* force clock reconfiguration */
@@ -2238,7 +2245,7 @@ static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask)
 	if (intmask & SDHCI_INT_TIMEOUT)
 		host->cmd->error = -ETIMEDOUT;
 	else if (intmask & (SDHCI_INT_CRC | SDHCI_INT_END_BIT |
-			SDHCI_INT_INDEX))
+			SDHCI_INT_INDEX | SDHCI_INT_ACMD12ERR))
 		host->cmd->error = -EILSEQ;
 
 	if (host->cmd->error) {
@@ -2408,6 +2415,7 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 	struct sdhci_host *host = dev_id;
 	u32 intmask, unexpected = 0;
 	int cardint = 0, max_loops = 16;
+	u32 cmd_mask = SDHCI_INT_CMD_MASK;
 
 	spin_lock(&host->lock);
 
@@ -2454,10 +2462,12 @@ again:
 		tasklet_schedule(&host->card_tasklet);
 	}
 
-	if (intmask & SDHCI_INT_CMD_MASK) {
-		sdhci_writel(host, intmask & SDHCI_INT_CMD_MASK,
-			SDHCI_INT_STATUS);
-		sdhci_cmd_irq(host, intmask & SDHCI_INT_CMD_MASK);
+	if (host->flags & SDHCI_AUTO_CMD12)
+		cmd_mask |= SDHCI_INT_ACMD12ERR;
+
+	if (intmask & cmd_mask) {
+		sdhci_writel(host, intmask & cmd_mask, SDHCI_INT_STATUS);
+		sdhci_cmd_irq(host, intmask & cmd_mask);
 	}
 
 	if (intmask & SDHCI_INT_DATA_MASK) {
@@ -2466,7 +2476,7 @@ again:
 		sdhci_data_irq(host, intmask & SDHCI_INT_DATA_MASK);
 	}
 
-	intmask &= ~(SDHCI_INT_CMD_MASK | SDHCI_INT_DATA_MASK);
+	intmask &= ~(cmd_mask | SDHCI_INT_DATA_MASK);
 
 	intmask &= ~SDHCI_INT_ERROR;
 
-- 
1.8.0


