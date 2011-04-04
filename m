From: Andrei Warkentin <andreiw@motorola.com>
Subject: [PATCH] MMC: enable TRIM/ERASE caps for SDHCI host.
Date: Mon,  4 Apr 2011 04:01:34 -0500
Message-ID: <1301907694-4533-1-git-send-email-andreiw@motorola.com>
References: <BANLkTik0ijdeccTgqxf8Mu87s8jxevaOhA@mail.gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og105.obsmtp.com ([64.18.0.180]:58162 "EHLO
	exprod5og105.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134Ab1DDIVc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Apr 2011 04:21:32 -0400
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.176.130.20])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p348Lq2U027835
	for <linux-mmc@vger.kernel.org>; Mon, 4 Apr 2011 04:21:52 -0400 (EDT)
Received: from mail-gx0-f170.google.com (mail-gx0-f170.google.com [209.85.161.170])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p348LhS0027796
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Mon, 4 Apr 2011 04:21:52 -0400 (EDT)
Received: by mail-gx0-f170.google.com with SMTP id 27so3066599gxk.15
        for <linux-mmc@vger.kernel.org>; Mon, 04 Apr 2011 01:21:29 -0700 (PDT)
In-Reply-To: <BANLkTik0ijdeccTgqxf8Mu87s8jxevaOhA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Andrei Warkentin <andreiw@motorola.com>

SDHCI host controller has TRIM/ERASE capability, enable these caps for erasing
purpose.

ERASE command needs R1B response, so fix R1B-type command
handling for SDHCI controller. For non-DAT commands using a busy
reponse, the cmd->cmd_timeout (in ms) field is used for timeout
calculations. cmd->cmd_timeout field is appropriately set to the
correct erase timeout in core/core.c.

Based on patch by Chuanxiao Dong <chuanxiao.dong@intel.com>
Signed-off-by: Andrei Warkentin <andreiw@motorola.com>
---
 drivers/mmc/core/core.c  |   40 ++++++++++++++++++++++------------------
 drivers/mmc/host/sdhci.c |   43 +++++++++++++++++++++++++++----------------
 include/linux/mmc/core.h |    2 +-
 3 files changed, 50 insertions(+), 35 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 1f453ac..85ef72c 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1187,9 +1187,9 @@ void mmc_init_erase(struct mmc_card *card)
 	}
 }
 
-static void mmc_set_mmc_erase_timeout(struct mmc_card *card,
-				      struct mmc_command *cmd,
-				      unsigned int arg, unsigned int qty)
+static unsigned int  mmc_mmc_erase_timeout(struct mmc_card *card,
+					   struct mmc_command *cmd,
+					   unsigned int arg, unsigned int qty)
 {
 	unsigned int erase_timeout;
 
@@ -1246,38 +1246,42 @@ static void mmc_set_mmc_erase_timeout(struct mmc_card *card,
 	if (mmc_host_is_spi(card->host) && erase_timeout < 1000)
 		erase_timeout = 1000;
 
-	cmd->erase_timeout = erase_timeout;
+	return erase_timeout;
 }
 
-static void mmc_set_sd_erase_timeout(struct mmc_card *card,
-				     struct mmc_command *cmd, unsigned int arg,
-				     unsigned int qty)
+static unsigned int mmc_sd_erase_timeout(struct mmc_card *card,
+					 struct mmc_command *cmd, unsigned int arg,
+					 unsigned int qty)
 {
+	unsigned int erase_timeout;
+
 	if (card->ssr.erase_timeout) {
 		/* Erase timeout specified in SD Status Register (SSR) */
-		cmd->erase_timeout = card->ssr.erase_timeout * qty +
-				     card->ssr.erase_offset;
+		erase_timeout = card->ssr.erase_timeout * qty +
+			card->ssr.erase_offset;
 	} else {
 		/*
 		 * Erase timeout not specified in SD Status Register (SSR) so
 		 * use 250ms per write block.
 		 */
-		cmd->erase_timeout = 250 * qty;
+		erase_timeout = 250 * qty;
 	}
 
 	/* Must not be less than 1 second */
-	if (cmd->erase_timeout < 1000)
-		cmd->erase_timeout = 1000;
+	if (erase_timeout < 1000)
+		erase_timeout = 1000;
+
+	return erase_timeout;
 }
 
-static void mmc_set_erase_timeout(struct mmc_card *card,
-				  struct mmc_command *cmd, unsigned int arg,
-				  unsigned int qty)
+static unsigned int mmc_erase_timeout(struct mmc_card *card,
+				      struct mmc_command *cmd, unsigned int arg,
+				      unsigned int qty)
 {
 	if (mmc_card_sd(card))
-		mmc_set_sd_erase_timeout(card, cmd, arg, qty);
+		return mmc_sd_erase_timeout(card, cmd, arg, qty);
 	else
-		mmc_set_mmc_erase_timeout(card, cmd, arg, qty);
+		return mmc_mmc_erase_timeout(card, cmd, arg, qty);
 }
 
 static int mmc_do_erase(struct mmc_card *card, unsigned int from,
@@ -1351,7 +1355,7 @@ static int mmc_do_erase(struct mmc_card *card, unsigned int from,
 	cmd.opcode = MMC_ERASE;
 	cmd.arg = arg;
 	cmd.flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
-	mmc_set_erase_timeout(card, &cmd, arg, qty);
+	cmd.cmd_timeout = mmc_erase_timeout(card, &cmd, arg, qty);
 	err = mmc_wait_for_cmd(card->host, &cmd, 0);
 	if (err) {
 		printk(KERN_ERR "mmc_erase: erase error %d, status %#x\n",
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
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index f8fa8de..3659289 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -92,7 +92,7 @@ struct mmc_command {
  *              actively failing requests
  */
 
-	unsigned int		erase_timeout;	/* in milliseconds */
+	unsigned int		cmd_timeout;	/* in milliseconds */
 
 	struct mmc_data		*data;		/* data segment associated with cmd */
 	struct mmc_request	*mrq;		/* associated request */
-- 
1.7.0.4

