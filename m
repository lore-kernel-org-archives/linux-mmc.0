From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 20/54] mmc: sdhci: Separate timer timeout for command and data requests
Date: Wed, 29 Jun 2016 16:24:33 +0300
Message-ID: <1467206707-30185-21-git-send-email-adrian.hunter@intel.com>
References: <1467206707-30185-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:55539 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932087AbcF2Naj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 29 Jun 2016 09:30:39 -0400
In-Reply-To: <1467206707-30185-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>

In order to support commands during data transfer, there will have to be up
to two active requests (mrqs) at a time, instead of just one. Provide two
timers instead of just one. One of the timers is for requests that do not
use the data lines, and the other one is for requests that do.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 62 ++++++++++++++++++++++++++++++++++++++++--------
 drivers/mmc/host/sdhci.h |  1 +
 2 files changed, 53 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index b7b68b31d36d..9580f76caf57 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1003,6 +1003,23 @@ static void sdhci_finish_data(struct sdhci_host *host)
 	}
 }
 
+static void sdhci_mod_timer(struct sdhci_host *host, struct mmc_request *mrq,
+			    unsigned long timeout)
+{
+	if (sdhci_data_line_cmd(mrq->cmd))
+		mod_timer(&host->data_timer, timeout);
+	else
+		mod_timer(&host->timer, timeout);
+}
+
+static void sdhci_del_timer(struct sdhci_host *host, struct mmc_request *mrq)
+{
+	if (sdhci_data_line_cmd(mrq->cmd))
+		del_timer(&host->data_timer);
+	else
+		del_timer(&host->timer);
+}
+
 void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 {
 	int flags;
@@ -1044,7 +1061,7 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 		timeout += DIV_ROUND_UP(cmd->busy_timeout, 1000) * HZ + HZ;
 	else
 		timeout += 10 * HZ;
-	mod_timer(&host->timer, timeout);
+	sdhci_mod_timer(host, cmd->mrq, timeout);
 
 	host->cmd = cmd;
 	if (sdhci_data_line_cmd(cmd)) {
@@ -2232,10 +2249,10 @@ static void sdhci_tasklet_finish(unsigned long param)
 		return;
 	}
 
-	del_timer(&host->timer);
-
 	mrq = host->mrq;
 
+	sdhci_del_timer(host, mrq);
+
 	/*
 	 * Always unmap the data buffers if they were mapped by
 	 * sdhci_prepare_data() whenever we finish with a request.
@@ -2289,7 +2306,30 @@ static void sdhci_timeout_timer(unsigned long data)
 
 	spin_lock_irqsave(&host->lock, flags);
 
-	if (host->mrq) {
+	if (host->cmd && !sdhci_data_line_cmd(host->cmd)) {
+		pr_err("%s: Timeout waiting for hardware cmd interrupt.\n",
+		       mmc_hostname(host->mmc));
+		sdhci_dumpregs(host);
+
+		host->cmd->error = -ETIMEDOUT;
+		sdhci_finish_mrq(host, host->cmd->mrq);
+	}
+
+	mmiowb();
+	spin_unlock_irqrestore(&host->lock, flags);
+}
+
+static void sdhci_timeout_data_timer(unsigned long data)
+{
+	struct sdhci_host *host;
+	unsigned long flags;
+
+	host = (struct sdhci_host *)data;
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	if (host->data || host->data_cmd ||
+	    (host->cmd && sdhci_data_line_cmd(host->cmd))) {
 		pr_err("%s: Timeout waiting for hardware interrupt.\n",
 		       mmc_hostname(host->mmc));
 		sdhci_dumpregs(host);
@@ -2297,13 +2337,12 @@ static void sdhci_timeout_timer(unsigned long data)
 		if (host->data) {
 			host->data->error = -ETIMEDOUT;
 			sdhci_finish_data(host);
+		} else if (host->data_cmd) {
+			host->data_cmd->error = -ETIMEDOUT;
+			sdhci_finish_mrq(host, host->data_cmd->mrq);
 		} else {
-			if (host->cmd)
-				host->cmd->error = -ETIMEDOUT;
-			else
-				host->mrq->cmd->error = -ETIMEDOUT;
-
-			sdhci_finish_mrq(host, host->mrq);
+			host->cmd->error = -ETIMEDOUT;
+			sdhci_finish_mrq(host, host->cmd->mrq);
 		}
 	}
 
@@ -3432,6 +3471,8 @@ int __sdhci_add_host(struct sdhci_host *host)
 		sdhci_tasklet_finish, (unsigned long)host);
 
 	setup_timer(&host->timer, sdhci_timeout_timer, (unsigned long)host);
+	setup_timer(&host->data_timer, sdhci_timeout_data_timer,
+		    (unsigned long)host);
 
 	init_waitqueue_head(&host->buf_ready_int);
 
@@ -3541,6 +3582,7 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
 	free_irq(host->irq, host);
 
 	del_timer_sync(&host->timer);
+	del_timer_sync(&host->data_timer);
 
 	tasklet_kill(&host->finish_tasklet);
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 7301c90f8500..a1de42232439 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -490,6 +490,7 @@ struct sdhci_host {
 	struct tasklet_struct finish_tasklet;	/* Tasklet structures */
 
 	struct timer_list timer;	/* Timer for timeouts */
+	struct timer_list data_timer;	/* Timer for data timeouts */
 
 	u32 caps;		/* CAPABILITY_0 */
 	u32 caps1;		/* CAPABILITY_1 */
-- 
1.9.1

