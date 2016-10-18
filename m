From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH 5/8] mmc: core: remove BUG_ONs from core.c
Date: Tue, 18 Oct 2016 20:04:19 +0800
Message-ID: <1476792259-6472-1-git-send-email-shawn.lin@rock-chips.com>
References: <1476792192-6265-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:59117 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757966AbcJRL6e (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Oct 2016 07:58:34 -0400
In-Reply-To: <1476792192-6265-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

BUG_ONs doesn't help anything except for stop the system from
running. If it occurs, it implies we should deploy proper error
handling for that. So this patch is gonna discard these meaningless
BUG_ONs and deploy error handling if needed.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/core/core.c | 40 ++++++++++++++--------------------------
 1 file changed, 14 insertions(+), 26 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 2553d90..d8b166b 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -306,16 +306,16 @@ static int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 		mrq->sbc->mrq = mrq;
 	}
 	if (mrq->data) {
-		BUG_ON(mrq->data->blksz > host->max_blk_size);
-		BUG_ON(mrq->data->blocks > host->max_blk_count);
-		BUG_ON(mrq->data->blocks * mrq->data->blksz >
-			host->max_req_size);
-
+		if (mrq->data->blksz > host->max_blk_size ||
+		    mrq->data->blocks > host->max_blk_count ||
+		    mrq->data->blocks * mrq->data->blksz > host->max_req_size)
+			return -EINVAL;
 #ifdef CONFIG_MMC_DEBUG
 		sz = 0;
 		for_each_sg(mrq->data->sg, sg, mrq->data->sg_len, i)
 			sz += sg->length;
-		BUG_ON(sz != mrq->data->blocks * mrq->data->blksz);
+		if (sz != mrq->data->blocks * mrq->data->blksz)
+			return -EINVAL;
 #endif
 
 		mrq->cmd->data = mrq->data;
@@ -349,9 +349,8 @@ void mmc_start_bkops(struct mmc_card *card, bool from_exception)
 	int timeout;
 	bool use_busy_signal;
 
-	BUG_ON(!card);
-
-	if (!card->ext_csd.man_bkops_en || mmc_card_doing_bkops(card))
+	if (!card || !card->ext_csd.man_bkops_en ||
+	    mmc_card_doing_bkops(card))
 		return;
 
 	err = mmc_read_bkops_status(card);
@@ -754,8 +753,6 @@ int mmc_interrupt_hpi(struct mmc_card *card)
 	u32 status;
 	unsigned long prg_wait;
 
-	BUG_ON(!card);
-
 	if (!card->ext_csd.hpi_en) {
 		pr_info("%s: HPI enable bit unset\n", mmc_hostname(card->host));
 		return 1;
@@ -850,7 +847,9 @@ int mmc_stop_bkops(struct mmc_card *card)
 {
 	int err = 0;
 
-	BUG_ON(!card);
+	if (!card)
+		return -EINVAL;
+
 	err = mmc_interrupt_hpi(card);
 
 	/*
@@ -1666,8 +1665,6 @@ int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage, u32 ocr)
 	int err = 0;
 	u32 clock;
 
-	BUG_ON(!host);
-
 	/*
 	 * Send CMD11 only if the request is to switch the card to
 	 * 1.8V signalling.
@@ -1884,9 +1881,7 @@ void mmc_power_cycle(struct mmc_host *host, u32 ocr)
  */
 static void __mmc_release_bus(struct mmc_host *host)
 {
-	BUG_ON(!host);
-	BUG_ON(host->bus_refs);
-	BUG_ON(!host->bus_dead);
+	WARN_ON(!host->bus_dead);
 
 	host->bus_ops = NULL;
 }
@@ -1926,15 +1921,12 @@ void mmc_attach_bus(struct mmc_host *host, const struct mmc_bus_ops *ops)
 {
 	unsigned long flags;
 
-	BUG_ON(!host);
-	BUG_ON(!ops);
-
 	WARN_ON(!host->claimed);
 
 	spin_lock_irqsave(&host->lock, flags);
 
-	BUG_ON(host->bus_ops);
-	BUG_ON(host->bus_refs);
+	WARN_ON(host->bus_ops);
+	WARN_ON(host->bus_refs);
 
 	host->bus_ops = ops;
 	host->bus_refs = 1;
@@ -1950,8 +1942,6 @@ void mmc_detach_bus(struct mmc_host *host)
 {
 	unsigned long flags;
 
-	BUG_ON(!host);
-
 	WARN_ON(!host->claimed);
 	WARN_ON(!host->bus_ops);
 
@@ -2865,8 +2855,6 @@ void mmc_stop_host(struct mmc_host *host)
 	}
 	mmc_bus_put(host);
 
-	BUG_ON(host->card);
-
 	mmc_claim_host(host);
 	mmc_power_off(host);
 	mmc_release_host(host);
-- 
2.3.7


