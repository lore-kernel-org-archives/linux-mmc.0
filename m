From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH RFC 10/46] mmc: sdhci: Factor out sdhci_finish_mrq()
Date: Thu,  9 Jun 2016 14:52:10 +0300
Message-ID: <1465473166-22532-11-git-send-email-adrian.hunter@intel.com>
References: <1465473166-22532-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:56076 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751150AbcFIL5w (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 9 Jun 2016 07:57:52 -0400
In-Reply-To: <1465473166-22532-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>

In order to support commands during data transfer, there will have to be up
to two active requests (mrqs) at a time, instead of just one. That means
the driver must identify which one to finish. Prepare for that by factoring
out sdhci_finish_mrq().

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 1edb827bbab2..e6eec10b46de 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -923,6 +923,11 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
 	sdhci_writew(host, mode, SDHCI_TRANSFER_MODE);
 }
 
+static void sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
+{
+	tasklet_schedule(&host->finish_tasklet);
+}
+
 static void sdhci_finish_data(struct sdhci_host *host)
 {
 	struct mmc_data *data;
@@ -966,8 +971,9 @@ static void sdhci_finish_data(struct sdhci_host *host)
 		}
 
 		sdhci_send_command(host, data->stop);
-	} else
-		tasklet_schedule(&host->finish_tasklet);
+	} else {
+		sdhci_finish_mrq(host, data->mrq);
+	}
 }
 
 void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
@@ -999,7 +1005,7 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 			       mmc_hostname(host->mmc));
 			sdhci_dumpregs(host);
 			cmd->error = -EIO;
-			tasklet_schedule(&host->finish_tasklet);
+			sdhci_finish_mrq(host, cmd->mrq);
 			return;
 		}
 		timeout--;
@@ -1029,7 +1035,7 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 		pr_err("%s: Unsupported response type!\n",
 			mmc_hostname(host->mmc));
 		cmd->error = -EINVAL;
-		tasklet_schedule(&host->finish_tasklet);
+		sdhci_finish_mrq(host, cmd->mrq);
 		return;
 	}
 
@@ -1109,7 +1115,7 @@ static void sdhci_finish_command(struct sdhci_host *host)
 			sdhci_finish_data(host);
 
 		if (!cmd->data)
-			tasklet_schedule(&host->finish_tasklet);
+			sdhci_finish_mrq(host, cmd->mrq);
 	}
 }
 
@@ -1409,7 +1415,7 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 
 	if (!present || host->flags & SDHCI_DEVICE_DEAD) {
 		mrq->cmd->error = -ENOMEDIUM;
-		tasklet_schedule(&host->finish_tasklet);
+		sdhci_finish_mrq(host, mrq);
 	} else {
 		if (mrq->sbc && !(host->flags & SDHCI_AUTO_CMD23))
 			sdhci_send_command(host, mrq->sbc);
@@ -2128,7 +2134,7 @@ static void sdhci_card_event(struct mmc_host *mmc)
 		sdhci_do_reset(host, SDHCI_RESET_DATA);
 
 		host->mrq->cmd->error = -ENOMEDIUM;
-		tasklet_schedule(&host->finish_tasklet);
+		sdhci_finish_mrq(host, host->mrq);
 	}
 
 	spin_unlock_irqrestore(&host->lock, flags);
@@ -2254,7 +2260,7 @@ static void sdhci_timeout_timer(unsigned long data)
 			else
 				host->mrq->cmd->error = -ETIMEDOUT;
 
-			tasklet_schedule(&host->finish_tasklet);
+			sdhci_finish_mrq(host, host->mrq);
 		}
 	}
 
@@ -2301,7 +2307,7 @@ static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask, u32 *mask)
 			return;
 		}
 
-		tasklet_schedule(&host->finish_tasklet);
+		sdhci_finish_mrq(host, host->cmd->mrq);
 		return;
 	}
 
@@ -2376,7 +2382,7 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 		if (data_cmd && (data_cmd->flags & MMC_RSP_BUSY)) {
 			if (intmask & SDHCI_INT_DATA_TIMEOUT) {
 				data_cmd->error = -ETIMEDOUT;
-				tasklet_schedule(&host->finish_tasklet);
+				sdhci_finish_mrq(host, data_cmd->mrq);
 				return;
 			}
 			if (intmask & SDHCI_INT_DATA_END) {
@@ -2388,7 +2394,7 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 				if (host->cmd == data_cmd)
 					return;
 
-				tasklet_schedule(&host->finish_tasklet);
+				sdhci_finish_mrq(host, data_cmd->mrq);
 				return;
 			}
 		}
@@ -3394,7 +3400,7 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
 				" transfer!\n", mmc_hostname(mmc));
 
 			host->mrq->cmd->error = -ENOMEDIUM;
-			tasklet_schedule(&host->finish_tasklet);
+			sdhci_finish_mrq(host, host->mrq);
 		}
 
 		spin_unlock_irqrestore(&host->lock, flags);
-- 
1.9.1

