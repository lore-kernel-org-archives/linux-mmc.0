From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH RFC 17/46] mmc: sdhci: Allow for finishing multiple requests
Date: Thu,  9 Jun 2016 14:52:17 +0300
Message-ID: <1465473166-22532-18-git-send-email-adrian.hunter@intel.com>
References: <1465473166-22532-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:63235 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751510AbcFIL56 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 9 Jun 2016 07:57:58 -0400
In-Reply-To: <1465473166-22532-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>

In order to support commands during data transfer, there will have to be up
to two active requests (mrqs) at a time, instead of just one. That means
recording which request is finished.  Doing that obsoletes host->mrq which
is therefore removed.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 71 +++++++++++++++++++++++++++++++++---------------
 drivers/mmc/host/sdhci.h |  5 +++-
 2 files changed, 53 insertions(+), 23 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index f04df6f42f35..fa527a89ee4c 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -938,6 +938,29 @@ static bool sdhci_needs_reset(struct sdhci_host *host, struct mmc_request *mrq)
 		 (host->quirks & SDHCI_QUIRK_RESET_AFTER_REQUEST)));
 }
 
+static void __sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
+{
+	int i;
+
+	for (i = 0; i < SDHCI_MAX_MRQS; i++) {
+		if (host->mrqs_done[i] == mrq) {
+			WARN_ON(1);
+			return;
+		}
+	}
+
+	for (i = 0; i < SDHCI_MAX_MRQS; i++) {
+		if (!host->mrqs_done[i]) {
+			host->mrqs_done[i] = mrq;
+			break;
+		}
+	}
+
+	WARN_ON(i >= SDHCI_MAX_MRQS);
+
+	tasklet_schedule(&host->finish_tasklet);
+}
+
 static void sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
 {
 	if (host->cmd && host->cmd->mrq == mrq)
@@ -952,7 +975,7 @@ static void sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
 	if (sdhci_needs_reset(host, mrq))
 		host->pending_reset = true;
 
-	tasklet_schedule(&host->finish_tasklet);
+	__sdhci_finish_mrq(host, mrq);
 }
 
 static void sdhci_finish_data(struct sdhci_host *host)
@@ -1440,8 +1463,6 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 
 	spin_lock_irqsave(&host->lock, flags);
 
-	WARN_ON(host->mrq != NULL);
-
 	sdhci_led_activate(host);
 
 	/*
@@ -1455,8 +1476,6 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		}
 	}
 
-	host->mrq = mrq;
-
 	if (!present || host->flags & SDHCI_DEVICE_DEAD) {
 		mrq->cmd->error = -ENOMEDIUM;
 		sdhci_finish_mrq(host, mrq);
@@ -1987,13 +2006,13 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 		cmd.flags = MMC_RSP_R1 | MMC_CMD_ADTC;
 		cmd.retries = 0;
 		cmd.data = NULL;
+		cmd.mrq = &mrq;
 		cmd.error = 0;
 
 		if (tuning_loop_counter-- == 0)
 			break;
 
 		mrq.cmd = &cmd;
-		host->mrq = &mrq;
 
 		/*
 		 * In response to CMD19, the card sends 64 bytes of tuning
@@ -2023,7 +2042,6 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 		sdhci_send_command(host, &cmd);
 
 		host->cmd = NULL;
-		host->mrq = NULL;
 
 		spin_unlock_irqrestore(&host->lock, flags);
 		/* Wait for Buffer Read Ready interrupt */
@@ -2224,26 +2242,26 @@ static const struct mmc_host_ops sdhci_ops = {
  *                                                                           *
 \*****************************************************************************/
 
-static void sdhci_tasklet_finish(unsigned long param)
+static bool sdhci_request_done(struct sdhci_host *host)
 {
-	struct sdhci_host *host;
 	unsigned long flags;
 	struct mmc_request *mrq;
-
-	host = (struct sdhci_host*)param;
+	int i;
 
 	spin_lock_irqsave(&host->lock, flags);
 
-        /*
-         * If this tasklet gets rescheduled while running, it will
-         * be run again afterwards but without any active request.
-         */
-	if (!host->mrq) {
-		spin_unlock_irqrestore(&host->lock, flags);
-		return;
+	for (i = 0; i < SDHCI_MAX_MRQS; i++) {
+		mrq = host->mrqs_done[i];
+		if (mrq) {
+			host->mrqs_done[i] = NULL;
+			break;
+		}
 	}
 
-	mrq = host->mrq;
+	if (!mrq) {
+		spin_unlock_irqrestore(&host->lock, flags);
+		return true;
+	}
 
 	sdhci_del_timer(host, mrq);
 
@@ -2281,14 +2299,23 @@ static void sdhci_tasklet_finish(unsigned long param)
 		host->pending_reset = false;
 	}
 
-	host->mrq = NULL;
-
-	sdhci_led_deactivate(host);
+	if (!sdhci_has_requests(host))
+		sdhci_led_deactivate(host);
 
 	mmiowb();
 	spin_unlock_irqrestore(&host->lock, flags);
 
 	mmc_request_done(host->mmc, mrq);
+
+	return false;
+}
+
+static void sdhci_tasklet_finish(unsigned long param)
+{
+	struct sdhci_host *host = (struct sdhci_host *)param;
+
+	while (!sdhci_request_done(host))
+		;
 }
 
 static void sdhci_timeout_timer(unsigned long data)
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 10f835f785f7..7c1f3cf4c459 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -314,6 +314,9 @@ struct sdhci_adma2_64_desc {
  */
 #define SDHCI_MAX_SEGS		128
 
+/* Allow for a a command request and a data request at the same time */
+#define SDHCI_MAX_MRQS		2
+
 enum sdhci_cookie {
 	COOKIE_UNMAPPED,
 	COOKIE_PRE_MAPPED,	/* mapped by sdhci_pre_req() */
@@ -462,7 +465,7 @@ struct sdhci_host {
 	bool preset_enabled;	/* Preset is enabled */
 	bool pending_reset;	/* Cmd/data reset is pending */
 
-	struct mmc_request *mrq;	/* Current request */
+	struct mmc_request *mrqs_done[SDHCI_MAX_MRQS];	/* Requests done */
 	struct mmc_command *cmd;	/* Current command */
 	struct mmc_command *data_cmd;	/* Current data command */
 	struct mmc_data *data;	/* Current data request */
-- 
1.9.1

