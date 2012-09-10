From: Kevin Liu <keyuan.liu@gmail.com>
Subject: [PATCH] mmc: sdhci: fix transfer mode setting bug for cmds w/o data transfer
Date: Mon, 10 Sep 2012 11:17:29 +0800
Message-ID: <1347247049-19422-1-git-send-email-keyuan.liu@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:41345 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755074Ab2IJDWW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 9 Sep 2012 23:22:22 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org, pierre@ossman.eu
Cc: cxie4@marvell.com, hzhuang1@marvell.com, prakity@marvell.com, wangtt@marvell.com, jlfu@marvell.com, kliu5@marvell.com

From: Kevin Liu <kliu5@marvell.com>

Commands without data transfer like cmd5/cmd7 will use previous
transfer mode setting, which may lead to error since some bits
may have been set unexpectedly.
For example, cmd5 following cmd18/cmd25 will have timeout error
since audo cmd23 has been enabled.

Signed-off-by: Jialing Fu <jlfu@marvell.com>
Signed-off-by: Tim Wang <wangtt@marvell.com>
Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/host/sdhci.c |   22 ++++++++++++++--------
 1 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 834be2f..962f696 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -885,8 +885,21 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
 	u16 mode;
 	struct mmc_data *data = cmd->data;
 
-	if (data == NULL)
+	if (data == NULL) {
+		if (cmd->opcode == MMC_SEND_TUNING_BLOCK ||
+			cmd->opcode == MMC_SEND_TUNING_BLOCK_HS200)
+			/*
+			 * The tuning block is sent by the card to the host
+			 * controller. So we set the TRNS_READ bit in the
+			 * Transfer Mode register. This also takes care of
+			 * setting DMA Enable and Multi Block Select in the
+			 * same register to 0.
+			 */
+			sdhci_writew(host, SDHCI_TRNS_READ, SDHCI_TRANSFER_MODE);
+		else
+			sdhci_writew(host, 0, SDHCI_TRANSFER_MODE);
 		return;
+	}
 
 	WARN_ON(!host->data);
 
@@ -1854,13 +1867,6 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 				     SDHCI_BLOCK_SIZE);
 		}
 
-		/*
-		 * The tuning block is sent by the card to the host controller.
-		 * So we set the TRNS_READ bit in the Transfer Mode register.
-		 * This also takes care of setting DMA Enable and Multi Block
-		 * Select in the same register to 0.
-		 */
-		sdhci_writew(host, SDHCI_TRNS_READ, SDHCI_TRANSFER_MODE);
 
 		sdhci_send_command(host, &cmd);
 
-- 
1.7.0.4

