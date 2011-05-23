From: Andrei Warkentin <andreiw@motorola.com>
Subject: [v6 3/5] MMC: Implement MMC_CAP_CMD23 for SDHCI.
Date: Mon, 23 May 2011 15:06:37 -0500
Message-ID: <1306181199-13915-4-git-send-email-andreiw@motorola.com>
References: <1305841590-26963-1-git-send-email-andreiw@motorola.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og106.obsmtp.com ([64.18.0.182]:49460 "EHLO
	exprod5og106.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932368Ab1EWTd1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 23 May 2011 15:33:27 -0400
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.176.129.42])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p4NJXvoF024199
	for <linux-mmc@vger.kernel.org>; Mon, 23 May 2011 15:33:57 -0400 (EDT)
Received: from mail-pw0-f42.google.com (mail-pw0-f42.google.com [209.85.160.42])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p4NJXhha024088
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Mon, 23 May 2011 15:33:57 -0400 (EDT)
Received: by mail-pw0-f42.google.com with SMTP id 3so3491829pwj.15
        for <linux-mmc@vger.kernel.org>; Mon, 23 May 2011 12:33:25 -0700 (PDT)
In-Reply-To: <1305841590-26963-1-git-send-email-andreiw@motorola.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, Andrei Warkentin <andreiw@motorola.com>, arindam.nath@amd.com, arnd@arndb.de, malchev@google.com

Implements support for multiblock transfers bounded
by SET_BLOCK_COUNT (CMD23).

Cc: arindam.nath@amd.com
Cc: cjb@laptop.org
Cc: arnd@arndb.de
Cc: malchev@google.com
Signed-off-by: Andrei Warkentin <andreiw@motorola.com>
---
 drivers/mmc/host/sdhci.c  |   66 ++++++++++++++++++++++++++++++++++-----------
 drivers/mmc/host/sdhci.h  |    2 +-
 include/linux/mmc/sdhci.h |    1 +
 3 files changed, 52 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index cc63f5e..3a53512 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -838,9 +838,10 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 }
 
 static void sdhci_set_transfer_mode(struct sdhci_host *host,
-	struct mmc_data *data)
+	struct mmc_command *cmd)
 {
 	u16 mode;
+	struct mmc_data *data = cmd->data;
 
 	if (data == NULL)
 		return;
@@ -848,11 +849,17 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
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
+		 * on successful completion (so no Auto-CMD12).
+		 */
+		if (!host->mrq->sbc &&
+		    host->flags & SDHCI_AUTO_CMD12)
+			mode |= SDHCI_TRNS_AUTO_CMD12;
 	}
 	if (data->flags & MMC_DATA_READ)
 		mode |= SDHCI_TRNS_READ;
@@ -893,7 +900,15 @@ static void sdhci_finish_data(struct sdhci_host *host)
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
@@ -949,7 +964,7 @@ static void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 
 	sdhci_writel(host, cmd->arg, SDHCI_ARGUMENT);
 
-	sdhci_set_transfer_mode(host, cmd->data);
+	sdhci_set_transfer_mode(host, cmd);
 
 	if ((cmd->flags & MMC_RSP_136) && (cmd->flags & MMC_RSP_BUSY)) {
 		printk(KERN_ERR "%s: Unsupported response type!\n",
@@ -1004,13 +1019,21 @@ static void sdhci_finish_command(struct sdhci_host *host)
 
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
@@ -1189,7 +1212,12 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 #ifndef SDHCI_USE_LEDS_CLASS
 	sdhci_activate_led(host);
 #endif
-	if (host->quirks & SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12) {
+
+	/*
+	 * Ensure we don't send the STOP for non-SET_BLOCK_COUNTED
+	 * requests if Auto-CMD12 is enabled.
+	 */
+	if (!mrq->sbc && (host->flags & SDHCI_AUTO_CMD12)) {
 		if (mrq->stop) {
 			mrq->data->stop = NULL;
 			mrq->stop = NULL;
@@ -1227,7 +1255,10 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 			host->mrq = mrq;
 		}
 
-		sdhci_send_command(host, mrq->cmd);
+		if (mrq->sbc)
+			sdhci_send_command(host, mrq->sbc);
+		else
+			sdhci_send_command(host, mrq->cmd);
 	}
 
 	mmiowb();
@@ -2455,7 +2486,10 @@ int sdhci_add_host(struct sdhci_host *host)
 	} else
 		mmc->f_min = host->max_clk / SDHCI_MAX_DIV_SPEC_200;
 
-	mmc->caps |= MMC_CAP_SDIO_IRQ | MMC_CAP_ERASE;
+	mmc->caps |= MMC_CAP_SDIO_IRQ | MMC_CAP_ERASE | MMC_CAP_CMD23;
+
+	if (host->quirks & SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12)
+		host->flags |= SDHCI_AUTO_CMD12;
 
 	/*
 	 * A controller may support 8-bit width, but the board itself
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 7e28eec..2c3fbc5 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -36,7 +36,7 @@
 #define SDHCI_TRANSFER_MODE	0x0C
 #define  SDHCI_TRNS_DMA		0x01
 #define  SDHCI_TRNS_BLK_CNT_EN	0x02
-#define  SDHCI_TRNS_ACMD12	0x04
+#define  SDHCI_TRNS_AUTO_CMD12	0x04
 #define  SDHCI_TRNS_READ	0x10
 #define  SDHCI_TRNS_MULTI	0x20
 
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index e902618..73e27ba 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -113,6 +113,7 @@ struct sdhci_host {
 #define SDHCI_DEVICE_DEAD	(1<<3)	/* Device unresponsive */
 #define SDHCI_SDR50_NEEDS_TUNING (1<<4)	/* SDR50 needs tuning */
 #define SDHCI_NEEDS_RETUNING	(1<<5)	/* Host needs retuning */
+#define SDHCI_AUTO_CMD12	(1<<6)	/* Auto CMD12 support */
 
 	unsigned int version;	/* SDHCI spec. version */
 
-- 
1.7.0.4

