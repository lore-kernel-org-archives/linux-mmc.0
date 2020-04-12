Return-Path: <SRS0=xqUN=54=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46514C2BB85
	for <linux-mmc@archiver.kernel.org>; Sun, 12 Apr 2020 09:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22FE020575
	for <linux-mmc@archiver.kernel.org>; Sun, 12 Apr 2020 09:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgDLJEq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 12 Apr 2020 05:04:46 -0400
Received: from mga12.intel.com ([192.55.52.136]:20973 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbgDLJEq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 12 Apr 2020 05:04:46 -0400
IronPort-SDR: TfphDBdnqYP5VnMhxFWMQGvBEGg7W220VKuGhunehdymj/tLo2lc/y4lJ2DgOztpv3CbDW08rp
 QS8+FT1QGXTQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2020 02:04:46 -0700
IronPort-SDR: MkXWtZHbWj2T32Vf5t5Uw3jiBXYdPoBX0eD3FCHpLnXikTGVCP9TAl2mbs7rpgh88f8Y0HUmcM
 zd11wnFi2EnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,374,1580803200"; 
   d="scan'208";a="362835175"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.87])
  by fmsmga001.fm.intel.com with ESMTP; 12 Apr 2020 02:04:44 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>
Subject: [PATCH 5/5] mmc: sdhci: Reduce maximum time under spinlock in sdhci_send_command()
Date:   Sun, 12 Apr 2020 12:03:49 +0300
Message-Id: <20200412090349.1607-6-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200412090349.1607-1-adrian.hunter@intel.com>
References: <20200412090349.1607-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Spending time under spinlock increases IRQ latencies and also
response times because preemption is disabled.

sdhci_send_command() waits up to 10 ms under spinlock for inhibit bits
to clear. In general inhibit bits will not be set, but there may be
corner cases, especially in the face of errors, where waiting helps.
There might also be dysfunctional hardware that needs the waiting. So
retain the legacy behaviour but do not wait for inhibit bits while under
spinlock. Instead adjust the logic to enable waiting while not under
spinlock. That is mostly straight forward, but in the interrupt handler
it requires deferring an "inhibited" command to the IRQ thread where
sleeping is allowed.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 126 ++++++++++++++++++++++++++++++---------
 drivers/mmc/host/sdhci.h |   1 +
 2 files changed, 99 insertions(+), 28 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index b9ddc8edffe2..10b9570f48aa 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -50,7 +50,7 @@ static unsigned int debug_quirks2;
 
 static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable);
 
-static void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd);
+static bool sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd);
 
 void sdhci_dumpregs(struct sdhci_host *host)
 {
@@ -1478,6 +1478,9 @@ static void __sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
 	if (host->data_cmd && host->data_cmd->mrq == mrq)
 		host->data_cmd = NULL;
 
+	if (host->deferred_cmd && host->deferred_cmd->mrq == mrq)
+		host->deferred_cmd = NULL;
+
 	if (host->data && host->data->mrq == mrq)
 		host->data = NULL;
 
@@ -1499,7 +1502,7 @@ static void sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
 	queue_work(host->complete_wq, &host->complete_work);
 }
 
-static void sdhci_finish_data(struct sdhci_host *host)
+static void __sdhci_finish_data(struct sdhci_host *host, bool sw_data_timeout)
 {
 	struct mmc_command *data_cmd = host->data_cmd;
 	struct mmc_data *data = host->data;
@@ -1551,14 +1554,31 @@ static void sdhci_finish_data(struct sdhci_host *host)
 		} else {
 			/* Avoid triggering warning in sdhci_send_command() */
 			host->cmd = NULL;
-			sdhci_send_command(host, data->stop);
+			if (!sdhci_send_command(host, data->stop)) {
+				if (sw_data_timeout) {
+					/*
+					 * This is anyway a sw data timeout, so
+					 * give up now.
+					 */
+					data->stop->error = -EIO;
+					__sdhci_finish_mrq(host, data->mrq);
+				} else {
+					WARN_ON(host->deferred_cmd);
+					host->deferred_cmd = data->stop;
+				}
+			}
 		}
 	} else {
 		__sdhci_finish_mrq(host, data->mrq);
 	}
 }
 
-static void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
+static void sdhci_finish_data(struct sdhci_host *host)
+{
+	__sdhci_finish_data(host, false);
+}
+
+static bool sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 {
 	int flags;
 	u32 mask;
@@ -1573,9 +1593,6 @@ static void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 	    cmd->opcode == MMC_STOP_TRANSMISSION)
 		cmd->flags |= MMC_RSP_BUSY;
 
-	/* Wait max 10 ms */
-	timeout = 10;
-
 	mask = SDHCI_CMD_INHIBIT;
 	if (sdhci_data_line_cmd(cmd))
 		mask |= SDHCI_DATA_INHIBIT;
@@ -1585,18 +1602,8 @@ static void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 	if (cmd->mrq->data && (cmd == cmd->mrq->data->stop))
 		mask &= ~SDHCI_DATA_INHIBIT;
 
-	while (sdhci_readl(host, SDHCI_PRESENT_STATE) & mask) {
-		if (timeout == 0) {
-			pr_err("%s: Controller never released inhibit bit(s).\n",
-			       mmc_hostname(host->mmc));
-			sdhci_dumpregs(host);
-			cmd->error = -EIO;
-			sdhci_finish_mrq(host, cmd->mrq);
-			return;
-		}
-		timeout--;
-		mdelay(1);
-	}
+	if (sdhci_readl(host, SDHCI_PRESENT_STATE) & mask)
+		return false;
 
 	host->cmd = cmd;
 	host->data_timeout = 0;
@@ -1618,11 +1625,13 @@ static void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 	sdhci_set_transfer_mode(host, cmd);
 
 	if ((cmd->flags & MMC_RSP_136) && (cmd->flags & MMC_RSP_BUSY)) {
-		pr_err("%s: Unsupported response type!\n",
-			mmc_hostname(host->mmc));
-		cmd->error = -EINVAL;
-		sdhci_finish_mrq(host, cmd->mrq);
-		return;
+		WARN_ONCE(1, "Unsupported response type!\n");
+		/*
+		 * This does not happen in practice because 136-bit response
+		 * commands never have busy waiting, so rather than complicate
+		 * the error path, just remove busy waiting and continue.
+		 */
+		cmd->flags &= ~MMC_RSP_BUSY;
 	}
 
 	if (!(cmd->flags & MMC_RSP_PRESENT))
@@ -1657,6 +1666,8 @@ static void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 		sdhci_external_dma_pre_transfer(host, cmd);
 
 	sdhci_writew(host, SDHCI_MAKE_CMD(cmd->opcode, flags), SDHCI_COMMAND);
+
+	return true;
 }
 
 static bool sdhci_present_error(struct sdhci_host *host,
@@ -1670,6 +1681,47 @@ static bool sdhci_present_error(struct sdhci_host *host,
 	return false;
 }
 
+static bool sdhci_send_command_retry(struct sdhci_host *host,
+				     struct mmc_command *cmd,
+				     unsigned long flags)
+	__releases(host->lock)
+	__acquires(host->lock)
+{
+	struct mmc_command *deferred_cmd = host->deferred_cmd;
+	int timeout = 10; /* Approx. 10 ms */
+	bool present;
+
+	while (!sdhci_send_command(host, cmd)) {
+		if (!timeout--) {
+			pr_err("%s: Controller never released inhibit bit(s).\n",
+			       mmc_hostname(host->mmc));
+			sdhci_dumpregs(host);
+			cmd->error = -EIO;
+			return false;
+		}
+
+		spin_unlock_irqrestore(&host->lock, flags);
+
+		usleep_range(1000, 1250);
+
+		present = host->mmc->ops->get_cd(host->mmc);
+
+		spin_lock_irqsave(&host->lock, flags);
+
+		/* A deferred command might disappear, handle that */
+		if (cmd == deferred_cmd && cmd != host->deferred_cmd)
+			return true;
+
+		if (sdhci_present_error(host, cmd, present))
+			return false;
+	}
+
+	if (cmd == host->deferred_cmd)
+		host->deferred_cmd = NULL;
+
+	return true;
+}
+
 static void sdhci_read_rsp_136(struct sdhci_host *host, struct mmc_command *cmd)
 {
 	int i, reg;
@@ -1729,7 +1781,10 @@ static void sdhci_finish_command(struct sdhci_host *host)
 
 	/* Finished CMD23, now send actual command. */
 	if (cmd == cmd->mrq->sbc) {
-		sdhci_send_command(host, cmd->mrq->cmd);
+		if (!sdhci_send_command(host, cmd->mrq->cmd)) {
+			WARN_ON(host->deferred_cmd);
+			host->deferred_cmd = cmd->mrq->cmd;
+		}
 	} else {
 
 		/* Processed actual command. */
@@ -2076,7 +2131,8 @@ void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 
 	cmd = sdhci_manual_cmd23(host, mrq) ? mrq->sbc : mrq->cmd;
 
-	sdhci_send_command(host, cmd);
+	if (!sdhci_send_command_retry(host, cmd, flags))
+		goto out_finish;
 
 	spin_unlock_irqrestore(&host->lock, flags);
 
@@ -2624,7 +2680,11 @@ void sdhci_send_tuning(struct sdhci_host *host, u32 opcode)
 	 */
 	sdhci_writew(host, SDHCI_TRNS_READ, SDHCI_TRANSFER_MODE);
 
-	sdhci_send_command(host, &cmd);
+	if (!sdhci_send_command_retry(host, &cmd, flags)) {
+		spin_unlock_irqrestore(&host->lock, flags);
+		host->tuning_done = 0;
+		return;
+	}
 
 	host->cmd = NULL;
 
@@ -3042,7 +3102,7 @@ static void sdhci_timeout_data_timer(struct timer_list *t)
 
 		if (host->data) {
 			host->data->error = -ETIMEDOUT;
-			sdhci_finish_data(host);
+			__sdhci_finish_data(host, true);
 			queue_work(host->complete_wq, &host->complete_work);
 		} else if (host->data_cmd) {
 			host->data_cmd->error = -ETIMEDOUT;
@@ -3414,6 +3474,9 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 		}
 	}
 out:
+	if (host->deferred_cmd)
+		result = IRQ_WAKE_THREAD;
+
 	spin_unlock(&host->lock);
 
 	/* Process mrqs ready for immediate completion */
@@ -3439,6 +3502,7 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 static irqreturn_t sdhci_thread_irq(int irq, void *dev_id)
 {
 	struct sdhci_host *host = dev_id;
+	struct mmc_command *cmd;
 	unsigned long flags;
 	u32 isr;
 
@@ -3446,8 +3510,14 @@ static irqreturn_t sdhci_thread_irq(int irq, void *dev_id)
 		;
 
 	spin_lock_irqsave(&host->lock, flags);
+
 	isr = host->thread_isr;
 	host->thread_isr = 0;
+
+	cmd = host->deferred_cmd;
+	if (cmd && !sdhci_send_command_retry(host, cmd, flags))
+		sdhci_finish_mrq(host, cmd->mrq);
+
 	spin_unlock_irqrestore(&host->lock, flags);
 
 	if (isr & (SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE)) {
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 47324feeba86..a7e469c00617 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -540,6 +540,7 @@ struct sdhci_host {
 	struct mmc_request *mrqs_done[SDHCI_MAX_MRQS];	/* Requests done */
 	struct mmc_command *cmd;	/* Current command */
 	struct mmc_command *data_cmd;	/* Current data command */
+	struct mmc_command *deferred_cmd;	/* Deferred command */
 	struct mmc_data *data;	/* Current data request */
 	unsigned int data_early:1;	/* Data finished before cmd */
 
-- 
2.17.1

