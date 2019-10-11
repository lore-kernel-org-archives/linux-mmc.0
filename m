From: Ludovic Barre <ludovic.Barre@st.com>
Subject: [PATCH 1/2] mmc: add unstuck function if host is in deadlock state
Date: Fri, 11 Oct 2019 15:15:01 +0200
Message-ID: <20191011131502.29579-2-ludovic.Barre@st.com>
References: <20191011131502.29579-1-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191011131502.29579-1-ludovic.Barre@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: srinivas.kandagatla@linaro.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, Ludovic Barre <ludovic.barre@st.com>
List-Id: linux-mmc@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

After a request a host may be in deadlock state, and wait
a specific action to unstuck the hardware block before
re-sending a new command.

This patch adds an optional callback mmc_hw_unstuck which
allows the host to unstuck the controller. In order to avoid
a critical context, this callback must be called when the
request is completed. Depending the mmc request, the completion
function is defined by mrq->done and could be in block.c or core.c.

mmc_hw_unstuck is called if the host returns an cmd/sbc/stop/data
DEADLK error.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/core/block.c | 11 +++++++++++
 drivers/mmc/core/core.c  | 35 +++++++++++++++++++++++++++++++++--
 include/linux/mmc/core.h |  1 +
 include/linux/mmc/host.h |  7 +++++++
 4 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 2c71a434c915..2f723e2f5fde 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1799,6 +1799,17 @@ static void mmc_blk_mq_rw_recovery(struct mmc_queue *mq, struct request *req)
 	u32 blocks;
 	int err;
 
+	/*
+	 * if the host return a deadlock, it needs to be unstuck
+	 * before to send a new command.
+	 */
+	if (brq->sbc.error == -EDEADLK || brq->cmd.error == -EDEADLK ||
+	    brq->stop.error == -EDEADLK || brq->data.error == -EDEADLK) {
+		pr_err("%s: host is in bad state, must be unstuck\n",
+		       req->rq_disk->disk_name);
+		mmc_hw_unstuck(card->host);
+	}
+
 	/*
 	 * Some errors the host driver might not have seen. Set the number of
 	 * bytes transferred to zero in that case.
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 221127324709..43fe59a7403b 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -397,6 +397,7 @@ static int __mmc_start_req(struct mmc_host *host, struct mmc_request *mrq)
 void mmc_wait_for_req_done(struct mmc_host *host, struct mmc_request *mrq)
 {
 	struct mmc_command *cmd;
+	int sbc_err, stop_err, data_err;
 
 	while (1) {
 		wait_for_completion(&mrq->completion);
@@ -420,8 +421,24 @@ void mmc_wait_for_req_done(struct mmc_host *host, struct mmc_request *mrq)
 				       mmc_hostname(host), __func__);
 			}
 		}
-		if (!cmd->error || !cmd->retries ||
-		    mmc_card_removed(host->card))
+
+		sbc_err =  mrq->sbc ? mrq->sbc->error : 0;
+		stop_err = mrq->stop ? mrq->stop->error : 0;
+		data_err =  mrq->data ? mrq->data->error : 0;
+
+		/*
+		 * if the host return a deadlock, it needs to be unstuck
+		 * before to send a new command.
+		 */
+		if (cmd->error == -EDEADLK || sbc_err == -EDEADLK ||
+		    stop_err == -EDEADLK || data_err == -EDEADLK) {
+			pr_debug("%s: host is in bad state, must be unstuck\n",
+				 mmc_hostname(host));
+			mmc_hw_unstuck(host);
+		}
+
+		if ((!cmd->error && !sbc_err && !stop_err && !data_err) ||
+		    !cmd->retries || mmc_card_removed(host->card))
 			break;
 
 		mmc_retune_recheck(host);
@@ -430,6 +447,12 @@ void mmc_wait_for_req_done(struct mmc_host *host, struct mmc_request *mrq)
 			 mmc_hostname(host), cmd->opcode, cmd->error);
 		cmd->retries--;
 		cmd->error = 0;
+		if (mrq->sbc)
+			mrq->sbc->error = 0;
+		if (mrq->stop)
+			mrq->stop->error = 0;
+		if (mrq->data)
+			mrq->data->error = 0;
 		__mmc_start_request(host, mrq);
 	}
 
@@ -2161,6 +2184,14 @@ int mmc_sw_reset(struct mmc_host *host)
 }
 EXPORT_SYMBOL(mmc_sw_reset);
 
+void mmc_hw_unstuck(struct mmc_host *host)
+{
+	if (!host->ops->hw_unstuck)
+		return;
+	host->ops->hw_unstuck(host);
+}
+EXPORT_SYMBOL(mmc_hw_unstuck);
+
 static int mmc_rescan_try_freq(struct mmc_host *host, unsigned freq)
 {
 	host->f_init = freq;
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index b7ba8810a3b5..eb10b8194073 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -173,6 +173,7 @@ void mmc_wait_for_req(struct mmc_host *host, struct mmc_request *mrq);
 int mmc_wait_for_cmd(struct mmc_host *host, struct mmc_command *cmd,
 		int retries);
 
+void mmc_hw_unstuck(struct mmc_host *host);
 int mmc_hw_reset(struct mmc_host *host);
 int mmc_sw_reset(struct mmc_host *host);
 void mmc_set_data_timeout(struct mmc_data *data, const struct mmc_card *card);
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index ba703384bea0..8b52cafcd1eb 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -163,6 +163,13 @@ struct mmc_host_ops {
 	void	(*hw_reset)(struct mmc_host *host);
 	void	(*card_event)(struct mmc_host *host);
 
+	/*
+	 * Optional callback, if your host could be in deadlock after a command
+	 * and need a specific action to unstuck the controller before sending
+	 * new command.
+	 */
+	void	(*hw_unstuck)(struct mmc_host *host);
+
 	/*
 	 * Optional callback to support controllers with HW issues for multiple
 	 * I/O. Returns the number of supported blocks for the request.
-- 
2.17.1
