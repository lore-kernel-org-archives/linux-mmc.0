From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH 4/6] mmc: tmio: move finish_request function further down
Date: Mon,  1 May 2017 11:03:44 +0200
Message-ID: <20170501090346.10801-5-wsa+renesas@sang-engineering.com>
References: <20170501090346.10801-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:48110 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1035596AbdEAJD6 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 1 May 2017 05:03:58 -0400
In-Reply-To: <20170501090346.10801-1-wsa+renesas@sang-engineering.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>

Plain code move with no changes. Needed for refactoring. Also, looks
nicer if request and finish_request are next to each other.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/tmio_mmc_pio.c | 76 ++++++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 36539950347fbc..b3ecb2e2e344c3 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -279,44 +279,6 @@ static void tmio_mmc_reset_work(struct work_struct *work)
 	mmc_request_done(host->mmc, mrq);
 }
 
-static void tmio_mmc_finish_request(struct tmio_mmc_host *host)
-{
-	struct mmc_request *mrq;
-	unsigned long flags;
-
-	spin_lock_irqsave(&host->lock, flags);
-
-	mrq = host->mrq;
-	if (IS_ERR_OR_NULL(mrq)) {
-		spin_unlock_irqrestore(&host->lock, flags);
-		return;
-	}
-
-	host->cmd = NULL;
-	host->data = NULL;
-	host->force_pio = false;
-
-	cancel_delayed_work(&host->delayed_reset_work);
-
-	host->mrq = NULL;
-	spin_unlock_irqrestore(&host->lock, flags);
-
-	if (mrq->cmd->error || (mrq->data && mrq->data->error))
-		tmio_mmc_abort_dma(host);
-
-	if (host->check_scc_error)
-		host->check_scc_error(host);
-
-	mmc_request_done(host->mmc, mrq);
-}
-
-static void tmio_mmc_done_work(struct work_struct *work)
-{
-	struct tmio_mmc_host *host = container_of(work, struct tmio_mmc_host,
-						  done);
-	tmio_mmc_finish_request(host);
-}
-
 /* These are the bitmasks the tmio chip requires to implement the MMC response
  * types. Note that R1 and R6 are the same in this scheme. */
 #define APP_CMD        0x0040
@@ -908,6 +870,44 @@ static void tmio_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	tmio_process_mrq(host, mrq);
 }
 
+static void tmio_mmc_finish_request(struct tmio_mmc_host *host)
+{
+	struct mmc_request *mrq;
+	unsigned long flags;
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	mrq = host->mrq;
+	if (IS_ERR_OR_NULL(mrq)) {
+		spin_unlock_irqrestore(&host->lock, flags);
+		return;
+	}
+
+	host->cmd = NULL;
+	host->data = NULL;
+	host->force_pio = false;
+
+	cancel_delayed_work(&host->delayed_reset_work);
+
+	host->mrq = NULL;
+	spin_unlock_irqrestore(&host->lock, flags);
+
+	if (mrq->cmd->error || (mrq->data && mrq->data->error))
+		tmio_mmc_abort_dma(host);
+
+	if (host->check_scc_error)
+		host->check_scc_error(host);
+
+	mmc_request_done(host->mmc, mrq);
+}
+
+static void tmio_mmc_done_work(struct work_struct *work)
+{
+	struct tmio_mmc_host *host = container_of(work, struct tmio_mmc_host,
+						  done);
+	tmio_mmc_finish_request(host);
+}
+
 static int tmio_mmc_clk_enable(struct tmio_mmc_host *host)
 {
 	if (!host->clk_enable)
-- 
2.11.0

