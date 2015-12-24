From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] mmc: dw_mmc: remove the unused quirks
Date: Thu, 24 Dec 2015 18:41:03 +0900
Message-ID: <1450950063-5359-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:48110 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750771AbbLXJlN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Dec 2015 04:41:13 -0500
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NZU01MVWW8NFF60@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 24 Dec 2015 18:41:11 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, Jaehoon Chung <jh80.chung@samsung.com>

Removed the unused quirks. These quirks don't used anywhere.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/dw_mmc.c  | 19 -------------------
 include/linux/mmc/dw_mmc.h | 10 ++--------
 2 files changed, 2 insertions(+), 27 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index fb204ee..7128351 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1634,12 +1634,6 @@ static int dw_mci_command_complete(struct dw_mci *host, struct mmc_command *cmd)
 	else
 		cmd->error = 0;
 
-	if (cmd->error) {
-		/* newer ip versions need a delay between retries */
-		if (host->quirks & DW_MCI_QUIRK_RETRY_DELAY)
-			mdelay(20);
-	}
-
 	return cmd->error;
 }
 
@@ -2355,16 +2349,6 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
 
 	pending = mci_readl(host, MINTSTS); /* read-only mask reg */
 
-	/*
-	 * DTO fix - version 2.10a and below, and only if internal DMA
-	 * is configured.
-	 */
-	if (host->quirks & DW_MCI_QUIRK_IDMAC_DTO) {
-		if (!pending &&
-		    ((mci_readl(host, STATUS) >> 17) & 0x1fff))
-			pending |= SDMMC_INT_DATA_OVER;
-	}
-
 	if (pending) {
 		/* Check volt switch first, since it can look like an error */
 		if ((host->state == STATE_SENDING_CMD11) &&
@@ -3165,9 +3149,6 @@ int dw_mci_probe(struct dw_mci *host)
 	/* Now that slots are all setup, we can enable card detect */
 	dw_mci_enable_cd(host);
 
-	if (host->quirks & DW_MCI_QUIRK_IDMAC_DTO)
-		dev_info(host->dev, "Internal DMAC interrupt fix enabled.\n");
-
 	return 0;
 
 err_dmaunmap:
diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
index 7776afb..89df7ab 100644
--- a/include/linux/mmc/dw_mmc.h
+++ b/include/linux/mmc/dw_mmc.h
@@ -235,16 +235,10 @@ struct dw_mci_dma_ops {
 };
 
 /* IP Quirks/flags. */
-/* DTO fix for command transmission with IDMAC configured */
-#define DW_MCI_QUIRK_IDMAC_DTO			BIT(0)
-/* delay needed between retries on some 2.11a implementations */
-#define DW_MCI_QUIRK_RETRY_DELAY		BIT(1)
-/* High Speed Capable - Supports HS cards (up to 50MHz) */
-#define DW_MCI_QUIRK_HIGHSPEED			BIT(2)
 /* Unreliable card detection */
-#define DW_MCI_QUIRK_BROKEN_CARD_DETECTION	BIT(3)
+#define DW_MCI_QUIRK_BROKEN_CARD_DETECTION	BIT(0)
 /* Timer for broken data transfer over scheme */
-#define DW_MCI_QUIRK_BROKEN_DTO			BIT(4)
+#define DW_MCI_QUIRK_BROKEN_DTO			BIT(1)
 
 struct dma_pdata;
 
-- 
1.9.1

