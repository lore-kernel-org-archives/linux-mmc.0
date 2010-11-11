From: "Chuanxiao.Dong" <chuanxiao.dong@intel.com>
Subject: [PATCH v1 1/3]Add erase timeout calculation routine for sdhci host
Date: Thu, 11 Nov 2010 17:05:19 +0800
Message-ID: <20101111090519.GB18170@intel.com>
Reply-To: "Chuanxiao.Dong" <chuanxiao.dong@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:13608 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1749667Ab0KKJHI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 11 Nov 2010 04:07:08 -0500
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: adrian.hunter@nokia.com, linux-mmc@vger.kernel.org

>From 04704a1c769dc4d15b5fb54d65d8ad46f6c5f57a Mon Sep 17 00:00:00 2001
From: Chuanxiao Dong <chuanxiao.dong@intel.com>
Date: Thu, 11 Nov 2010 13:42:32 +0800
Subject: [PATCH 1/3] mmc: add erase timeout calculation routine for sdhci host

Erase command needs R1b response which means after HD handle
a CMD_RESPONSE interrupt, driver also need to wait for a while.
For SDHCI host controller, HD also need to handle a DATA_END
interrupt.
During device handle erase cmd, if the blocks need to be erased
are too many, some SDHCI host controller maybe launch a TIMEOUT
interrupt before the erase cmd finishing. To avoid this kind of
situation, SDHCI HD need to calculate a correct timeout value
before issuing erase cmd. Patch added a routine to implement
this.

Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
---
 drivers/mmc/core/core.c  |    4 ++++
 drivers/mmc/host/sdhci.c |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 8bf542c..d48bb26 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -170,6 +170,9 @@ mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 
 	mrq->cmd->error = 0;
 	mrq->cmd->mrq = mrq;
+	if (mrq->cmd->opcode != MMC_ERASE)
+		mrq->cmd->erase_timeout = 0;
+
 	if (mrq->data) {
 		BUG_ON(mrq->data->blksz > host->max_blk_size);
 		BUG_ON(mrq->data->blocks > host->max_blk_count);
@@ -190,6 +193,7 @@ mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 			mrq->data->stop = mrq->stop;
 			mrq->stop->error = 0;
 			mrq->stop->mrq = mrq;
+			mrq->stop->erase_timeout = 0;
 		}
 	}
 	mmc_host_clk_ungate(host);
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 154cbf8..79fcca2 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -879,6 +879,48 @@ static void sdhci_finish_data(struct sdhci_host *host)
 		tasklet_schedule(&host->finish_tasklet);
 }
 
+static void sdhci_set_erasetimeout(struct sdhci_host *host,
+		unsigned int erase_timeout)
+{
+	u64 current_timeout;
+	int count = 0xe;
+	/*
+	 * If the host controller provides us with an incorrect timeout
+	 * value, just skip the check and use 0xE.  The hardware may take
+	 * longer to time out, but that's much better than having a too-short
+	 * timeout value.
+	 */
+	if (host->quirks & SDHCI_QUIRK_BROKEN_TIMEOUT_VAL)
+		goto out;
+
+	if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)
+		host->timeout_clk = host->clock / 1000;
+
+	/* Caculate the MAX timeout time for host controller */
+
+	/* Timeout in ms */
+	count = 0xe;
+	current_timeout = (1 << 27) / host->timeout_clk;
+	while (current_timeout > erase_timeout) {
+		current_timeout >>= 1;
+		count--;
+		if (count == 0)
+			break;
+	}
+
+	if (count == 0xe) {
+		/* host controller should disable timeout interrupt
+		 * here. But right now some host controller timeout
+		 * interrupt cannot be disabled
+		 * */
+		pr_warn("warning: device may have not enough time "
+				"to wait for erase cmd finishing\n");
+	} else
+		count += 1;
+out:
+	sdhci_writeb(host, count, SDHCI_TIMEOUT_CONTROL);
+}
+
 static void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 {
 	int flags;
@@ -946,6 +988,9 @@ static void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 	if (cmd->data)
 		flags |= SDHCI_CMD_DATA;
 
+	if (cmd->erase_timeout)
+		sdhci_set_erasetimeout(host, cmd->erase_timeout);
+
 	sdhci_writew(host, SDHCI_MAKE_CMD(cmd->opcode, flags), SDHCI_COMMAND);
 }
 
@@ -1857,6 +1902,7 @@ int sdhci_add_host(struct sdhci_host *host)
 		mmc->f_min = host->max_clk / SDHCI_MAX_DIV_SPEC_200;
 	mmc->f_max = host->max_clk;
 	mmc->caps |= MMC_CAP_SDIO_IRQ;
+	mmc->caps |= MMC_CAP_ERASE;
 
 	if (!(host->quirks & SDHCI_QUIRK_FORCE_1_BIT_DATA))
 		mmc->caps |= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA;
-- 
1.6.6.1

