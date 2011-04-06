From: Andrei Warkentin <andreiw@motorola.com>
Subject: [PATCH 2/4] MMC: SDHCI R1B command handling + MMC_CAP_ERASE.
Date: Tue,  5 Apr 2011 20:09:51 -0500
Message-ID: <1302052193-23317-3-git-send-email-andreiw@motorola.com>
References: <1302052193-23317-1-git-send-email-andreiw@motorola.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og114.obsmtp.com ([64.18.0.28]:49167 "EHLO
	exprod5og114.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752102Ab1DFAaJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Apr 2011 20:30:09 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.176.130.20])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p360SOQY015644
	for <linux-mmc@vger.kernel.org>; Tue, 5 Apr 2011 20:28:24 -0400 (EDT)
Received: from mail-yx0-f170.google.com (mail-yx0-f170.google.com [209.85.213.170])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p360S0Tx015446
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Tue, 5 Apr 2011 20:28:24 -0400 (EDT)
Received: by mail-yx0-f170.google.com with SMTP id 11so632037yxi.15
        for <linux-mmc@vger.kernel.org>; Tue, 05 Apr 2011 17:30:07 -0700 (PDT)
In-Reply-To: <1302052193-23317-1-git-send-email-andreiw@motorola.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: arnd@arndb.de, cjb@laptop.org, Andrei Warkentin <andreiw@motorola.com>

ERASE command needs R1B response, so fix R1B-type command
handling for SDHCI controller. For non-DAT commands using a busy
reponse, the cmd->cmd_timeout (in ms) field is used for timeout
calculations.

Based on patch by Chuanxiao Dong <chuanxiao.dong@intel.com>
Signed-off-by: Andrei Warkentin <andreiw@motorola.com>
---
 drivers/mmc/host/sdhci.c |   43 +++++++++++++++++++++++++++----------------
 1 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 9e15f41..88aaf5e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -40,7 +40,6 @@
 
 static unsigned int debug_quirks = 0;
 
-static void sdhci_prepare_data(struct sdhci_host *, struct mmc_data *);
 static void sdhci_finish_data(struct sdhci_host *);
 
 static void sdhci_send_command(struct sdhci_host *, struct mmc_command *);
@@ -591,9 +590,10 @@ static void sdhci_adma_table_post(struct sdhci_host *host,
 		data->sg_len, direction);
 }
 
-static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_data *data)
+static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd)
 {
 	u8 count;
+	struct mmc_data *data = cmd->data;
 	unsigned target_timeout, current_timeout;
 
 	/*
@@ -605,12 +605,16 @@ static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_data *data)
 	if (host->quirks & SDHCI_QUIRK_BROKEN_TIMEOUT_VAL)
 		return 0xE;
 
-	/* timeout in us */
-	target_timeout = data->timeout_ns / 1000 +
-		data->timeout_clks / host->clock;
+	/* Unspecified timeout, assume max */
+	if (!data && !cmd->cmd_timeout)
+		return 0xE;
 
-	if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)
-		host->timeout_clk = host->clock / 1000;
+	/* timeout in us */
+	if (!data)
+		target_timeout = cmd->cmd_timeout * 1000;
+	else
+		target_timeout = data->timeout_ns / 1000 +
+			data->timeout_clks / host->clock;
 
 	/*
 	 * Figure out needed cycles.
@@ -632,8 +636,9 @@ static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_data *data)
 	}
 
 	if (count >= 0xF) {
-		printk(KERN_WARNING "%s: Too large timeout requested!\n",
-			mmc_hostname(host->mmc));
+		printk(KERN_WARNING "%s: Too large timeout requested for CMD%d!\n",
+		       mmc_hostname(host->mmc),
+		       cmd->opcode);
 		count = 0xE;
 	}
 
@@ -651,15 +656,21 @@ static void sdhci_set_transfer_irqs(struct sdhci_host *host)
 		sdhci_clear_set_irqs(host, dma_irqs, pio_irqs);
 }
 
-static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_data *data)
+static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 {
 	u8 count;
 	u8 ctrl;
+	struct mmc_data *data = cmd->data;
 	int ret;
 
 	WARN_ON(host->data);
 
-	if (data == NULL)
+	if (data || (cmd->flags & MMC_RSP_BUSY)) {
+		count = sdhci_calc_timeout(host, cmd);
+		sdhci_writeb(host, count, SDHCI_TIMEOUT_CONTROL);
+	}
+
+	if (!data)
 		return;
 
 	/* Sanity checks */
@@ -670,9 +681,6 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_data *data)
 	host->data = data;
 	host->data_early = 0;
 
-	count = sdhci_calc_timeout(host, data);
-	sdhci_writeb(host, count, SDHCI_TIMEOUT_CONTROL);
-
 	if (host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA))
 		host->flags |= SDHCI_REQ_USE_DMA;
 
@@ -920,7 +928,7 @@ static void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 
 	host->cmd = cmd;
 
-	sdhci_prepare_data(host, cmd->data);
+	sdhci_prepare_data(host, cmd);
 
 	sdhci_writel(host, cmd->arg, SDHCI_ARGUMENT);
 
@@ -1867,6 +1875,9 @@ int sdhci_add_host(struct sdhci_host *host)
 	if (caps & SDHCI_TIMEOUT_CLK_UNIT)
 		host->timeout_clk *= 1000;
 
+	if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)
+		host->timeout_clk = host->clock / 1000;
+
 	/*
 	 * Set host parameters.
 	 */
@@ -1879,7 +1890,7 @@ int sdhci_add_host(struct sdhci_host *host)
 		mmc->f_min = host->max_clk / SDHCI_MAX_DIV_SPEC_200;
 
 	mmc->f_max = host->max_clk;
-	mmc->caps |= MMC_CAP_SDIO_IRQ;
+	mmc->caps |= MMC_CAP_SDIO_IRQ | MMC_CAP_ERASE;
 
 	/*
 	 * A controller may support 8-bit width, but the board itself
-- 
1.7.0.4

