From: Andrei Warkentin <andreiw@motorola.com>
Subject: [RFC 2/3] MMC: Implement MMC_CAP_CMD23 for SDHCI.
Date: Wed, 13 Apr 2011 19:38:42 -0500
Message-ID: <1302741523-22276-3-git-send-email-andreiw@motorola.com>
References: <1302741523-22276-1-git-send-email-andreiw@motorola.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og110.obsmtp.com ([64.18.0.20]:46974 "EHLO
	exprod5og110.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752818Ab1DNAAD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Apr 2011 20:00:03 -0400
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.22.94.168])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p3E00PTO019547
	for <linux-mmc@vger.kernel.org>; Wed, 13 Apr 2011 20:00:26 -0400 (EDT)
Received: from mail-yx0-f170.google.com (mail-yx0-f170.google.com [209.85.213.170])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p3E00LQ6019516
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Wed, 13 Apr 2011 20:00:25 -0400 (EDT)
Received: by mail-yx0-f170.google.com with SMTP id 11so816882yxi.15
        for <linux-mmc@vger.kernel.org>; Wed, 13 Apr 2011 17:00:01 -0700 (PDT)
In-Reply-To: <1302741523-22276-1-git-send-email-andreiw@motorola.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: arnd@arndb.de, cjb@laptop.org, Andrei Warkentin <andreiw@motorola.com>

Implements support for multiblock transfers bounded
by SET_BLOCK_COUNT (CMD23).

Signed-off-by: Andrei Warkentin <andreiw@motorola.com>
---
 drivers/mmc/host/sdhci.c |   60 +++++++++++++++++++++++++++++++++------------
 1 files changed, 44 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 94793f2..0b71ce8 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -822,9 +822,10 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 }
 
 static void sdhci_set_transfer_mode(struct sdhci_host *host,
-	struct mmc_data *data)
+	struct mmc_command *cmd)
 {
 	u16 mode;
+	struct mmc_data *data = cmd->data;
 
 	if (data == NULL)
 		return;
@@ -832,11 +833,17 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
 	WARN_ON(!host->data);
 
 	mode = SDHCI_TRNS_BLK_CNT_EN;
-	if (data->blocks > 1) {
-		if (host->quirks & SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12)
-			mode |= SDHCI_TRNS_MULTI | SDHCI_TRNS_ACMD12;
-		else
-			mode |= SDHCI_TRNS_MULTI;
+	if (mmc_op_multi(cmd->opcode) ||
+	    data->blocks > 1) {
+		mode |= SDHCI_TRNS_MULTI;
+
+		/*
+		 * If we are sending CMD23, CMD12 never gets sent
+		 * on successful completion.
+		 */
+		if (!host->mrq->sbc &&
+		    host->quirks & SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12)
+			mode |= SDHCI_TRNS_ACMD12;
 	}
 	if (data->flags & MMC_DATA_READ)
 		mode |= SDHCI_TRNS_READ;
@@ -877,7 +884,15 @@ static void sdhci_finish_data(struct sdhci_host *host)
 	else
 		data->bytes_xfered = data->blksz * data->blocks;
 
-	if (data->stop) {
+	/*
+	 * Need to send CMD12 if -
+	 * a) open-ended multiblock transfer (no CMD23)
+	 * b) error in multiblock transfer
+	 */
+	if (data->stop &&
+	    (data->error ||
+	     !host->mrq->sbc)) {
+
 		/*
 		 * The controller needs a reset of internal state machines
 		 * upon error conditions.
@@ -933,7 +948,7 @@ static void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 
 	sdhci_writel(host, cmd->arg, SDHCI_ARGUMENT);
 
-	sdhci_set_transfer_mode(host, cmd->data);
+	sdhci_set_transfer_mode(host, cmd);
 
 	if ((cmd->flags & MMC_RSP_136) && (cmd->flags & MMC_RSP_BUSY)) {
 		printk(KERN_ERR "%s: Unsupported response type!\n",
@@ -986,13 +1001,21 @@ static void sdhci_finish_command(struct sdhci_host *host)
 
 	host->cmd->error = 0;
 
-	if (host->data && host->data_early)
-		sdhci_finish_data(host);
+	/* Finished CMD23, now send actual command. */
+	if (host->cmd == host->mrq->sbc) {
+		host->cmd = NULL;
+		sdhci_send_command(host, host->mrq->cmd);
+	} else {
 
-	if (!host->cmd->data)
-		tasklet_schedule(&host->finish_tasklet);
+		/* Processed actual command. */
+		if (host->data && host->data_early)
+			sdhci_finish_data(host);
 
-	host->cmd = NULL;
+		if (!host->cmd->data)
+			tasklet_schedule(&host->finish_tasklet);
+
+		host->cmd = NULL;
+	}
 }
 
 static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
@@ -1159,8 +1182,13 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	if (!present || host->flags & SDHCI_DEVICE_DEAD) {
 		host->mrq->cmd->error = -ENOMEDIUM;
 		tasklet_schedule(&host->finish_tasklet);
-	} else
-		sdhci_send_command(host, mrq->cmd);
+	} else {
+
+		if (mrq->sbc)
+			sdhci_send_command(host, mrq->sbc);
+		else
+			sdhci_send_command(host, mrq->cmd);
+	}
 
 	mmiowb();
 	spin_unlock_irqrestore(&host->lock, flags);
@@ -1909,7 +1937,7 @@ int sdhci_add_host(struct sdhci_host *host)
 		mmc->f_min = host->max_clk / SDHCI_MAX_DIV_SPEC_200;
 
 	mmc->f_max = host->max_clk;
-	mmc->caps |= MMC_CAP_SDIO_IRQ | MMC_CAP_ERASE;
+	mmc->caps |= MMC_CAP_SDIO_IRQ | MMC_CAP_ERASE | MMC_CAP_CMD23;
 
 	/*
 	 * A controller may support 8-bit width, but the board itself
-- 
1.7.0.4

