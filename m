From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v2 2/6] mmc: tmio: refactor handling mrq
Date: Fri, 19 May 2017 15:31:51 +0200
Message-ID: <20170519133155.22945-3-wsa+renesas@sang-engineering.com>
References: <20170519133155.22945-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170519133155.22945-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-mmc@vger.kernel.org

Split handling mrq into a seperate function. We need to call it from
another place soon.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/tmio_mmc_core.c | 46 +++++++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 5f5a4a2d81be7c..bfe70b1cf1e1ea 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -894,12 +894,36 @@ static int tmio_mmc_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	return ret;
 }
 
+static void tmio_process_mrq(struct tmio_mmc_host *host, struct mmc_request *mrq)
+{
+	int ret;
+
+	if (mrq->data) {
+		ret = tmio_mmc_start_data(host, mrq->data);
+		if (ret)
+			goto fail;
+	}
+
+	ret = tmio_mmc_start_command(host, mrq->cmd);
+	if (ret)
+		goto fail;
+
+	schedule_delayed_work(&host->delayed_reset_work,
+			      msecs_to_jiffies(CMDREQ_TIMEOUT));
+	return;
+
+fail:
+	host->force_pio = false;
+	host->mrq = NULL;
+	mrq->cmd->error = ret;
+	mmc_request_done(host->mmc, mrq);
+}
+
 /* Process requests from the MMC layer */
 static void tmio_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
 {
 	struct tmio_mmc_host *host = mmc_priv(mmc);
 	unsigned long flags;
-	int ret;
 
 	spin_lock_irqsave(&host->lock, flags);
 
@@ -919,25 +943,7 @@ static void tmio_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
 
 	spin_unlock_irqrestore(&host->lock, flags);
 
-	if (mrq->data) {
-		ret = tmio_mmc_start_data(host, mrq->data);
-		if (ret)
-			goto fail;
-	}
-
-	ret = tmio_mmc_start_command(host, mrq->cmd);
-	if (ret)
-		goto fail;
-
-	schedule_delayed_work(&host->delayed_reset_work,
-			      msecs_to_jiffies(CMDREQ_TIMEOUT));
-	return;
-
-fail:
-	host->force_pio = false;
-	host->mrq = NULL;
-	mrq->cmd->error = ret;
-	mmc_request_done(mmc, mrq);
+	tmio_process_mrq(host, mrq);
 }
 
 static int tmio_mmc_clk_enable(struct tmio_mmc_host *host)
-- 
2.11.0
