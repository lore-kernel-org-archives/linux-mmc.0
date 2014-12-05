From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 04/13] mmc: core: Move mmc_card_removed() into mmc_start_request()
Date: Fri,  5 Dec 2014 19:41:02 +0200
Message-ID: <1417801271-15575-5-git-send-email-adrian.hunter@intel.com>
References: <1417801271-15575-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:60356 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751479AbaLERnT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 5 Dec 2014 12:43:19 -0500
In-Reply-To: <1417801271-15575-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Girish K S <girish.shivananjappa@linaro.org>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

Both callers of mmc_start_request() call mmc_card_removed()
so move that call into mmc_start_request().

This patch is preparation for adding re-tuning support.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/core.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index fcde4da..884f35a 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -185,13 +185,14 @@ void mmc_request_done(struct mmc_host *host, struct mmc_request *mrq)
 
 EXPORT_SYMBOL(mmc_request_done);
 
-static void
-mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
+static int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 {
 #ifdef CONFIG_MMC_DEBUG
 	unsigned int i, sz;
 	struct scatterlist *sg;
 #endif
+	if (mmc_card_removed(host->card))
+		return -ENOMEDIUM;
 
 	if (mrq->sbc) {
 		pr_debug("<%s: starting CMD%u arg %08x flags %08x>\n",
@@ -251,6 +252,8 @@ mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 	mmc_host_clk_hold(host);
 	led_trigger_event(host->led, LED_FULL);
 	host->ops->request(host, mrq);
+
+	return 0;
 }
 
 /**
@@ -345,29 +348,34 @@ static void mmc_wait_done(struct mmc_request *mrq)
  */
 static int __mmc_start_data_req(struct mmc_host *host, struct mmc_request *mrq)
 {
+	int err;
+
 	mrq->done = mmc_wait_data_done;
 	mrq->host = host;
-	if (mmc_card_removed(host->card)) {
-		mrq->cmd->error = -ENOMEDIUM;
+
+	err = mmc_start_request(host, mrq);
+	if (err) {
+		mrq->cmd->error = err;
 		mmc_wait_data_done(mrq);
-		return -ENOMEDIUM;
 	}
-	mmc_start_request(host, mrq);
 
-	return 0;
+	return err;
 }
 
 static int __mmc_start_req(struct mmc_host *host, struct mmc_request *mrq)
 {
+	int err;
+
 	init_completion(&mrq->completion);
 	mrq->done = mmc_wait_done;
-	if (mmc_card_removed(host->card)) {
-		mrq->cmd->error = -ENOMEDIUM;
+
+	err = mmc_start_request(host, mrq);
+	if (err) {
+		mrq->cmd->error = err;
 		complete(&mrq->completion);
-		return -ENOMEDIUM;
 	}
-	mmc_start_request(host, mrq);
-	return 0;
+
+	return err;
 }
 
 /*
-- 
1.9.1

