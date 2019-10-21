From: Ram Prakash Gupta <rampraka@codeaurora.org>
Subject: [RFC 3/6] mmc: core: Initialize clk scaling for mmc and SDCard
Date: Mon, 21 Oct 2019 19:59:34 +0530
Message-ID: <1571668177-3766-4-git-send-email-rampraka@codeaurora.org>
References: <1571668177-3766-1-git-send-email-rampraka@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1571668177-3766-1-git-send-email-rampraka@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: asutoshd@codeaurora.org, stummala@codeaurora.org, sayalil@codeaurora.org, rampraka@codeaurora.org, vbadigan@codeaurora.org, cang@codeaurora.org, ppvk@codeaurora.org, adrian.hunter@intel.com, ulf.hansson@linaro.org, robh+dt@kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: Sujit Reddy Thumma <sthumma@codeaurora.org>, Talel Shenhar <tatias@codeaurora.org>, Ritesh Harjani <riteshh@codeaurora.org>, "Bao D. Nguyen" <nguyenb@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

Initialize clk scaling for mmc and SDCard driver.
For mmc scaling is initialized for both cqe and legacy mode.

Signed-off-by: Sujit Reddy Thumma <sthumma@codeaurora.org>
Signed-off-by: Talel Shenhar <tatias@codeaurora.org>
Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Signed-off-by: Bao D. Nguyen <nguyenb@codeaurora.org>
Signed-off-by: Can Guo <cang@codeaurora.org>
Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
Co-Developed-by: Ram Prakash Gupta <rampraka@codeaurora.org>
Signed-off-by: Ram Prakash Gupta <rampraka@codeaurora.org>
---
 drivers/mmc/core/block.c | 19 ++++++++++++++++-
 drivers/mmc/core/core.c  |  8 +++++++
 drivers/mmc/core/host.c  | 10 +++++++++
 drivers/mmc/core/mmc.c   | 54 +++++++++++++++++++++++++++++++++++++++++++++---
 drivers/mmc/core/queue.c |  2 ++
 drivers/mmc/core/sd.c    | 32 ++++++++++++++++++++++++++--
 6 files changed, 119 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 2c71a43..ce6a754 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -877,6 +877,7 @@ static inline int mmc_blk_part_switch(struct mmc_card *card,
 		}
 
 		card->ext_csd.part_config = part_config;
+		card->part_curr = part_type;
 
 		ret = mmc_blk_part_switch_post(card, main_md->part_curr);
 	}
@@ -1457,6 +1458,7 @@ static void mmc_blk_cqe_complete_rq(struct mmc_queue *mq, struct request *req)
 	unsigned long flags;
 	bool put_card;
 	int err;
+	bool is_dcmd = false;
 
 	mmc_cqe_post_req(host, mrq);
 
@@ -1484,16 +1486,20 @@ static void mmc_blk_cqe_complete_rq(struct mmc_queue *mq, struct request *req)
 	spin_lock_irqsave(&mq->lock, flags);
 
 	mq->in_flight[mmc_issue_type(mq, req)] -= 1;
+	atomic_dec(&host->active_reqs);
 
 	put_card = (mmc_tot_in_flight(mq) == 0);
 
 	mmc_cqe_check_busy(mq);
 
+	is_dcmd = (mmc_issue_type(mq, req) ==  MMC_ISSUE_DCMD);
 	spin_unlock_irqrestore(&mq->lock, flags);
 
 	if (!mq->cqe_busy)
 		blk_mq_run_hw_queues(q, true);
 
+	mmc_cqe_clk_scaling_stop_busy(host, true, is_dcmd);
+
 	if (put_card)
 		mmc_put_card(mq->card, &mq->ctx);
 }
@@ -1572,10 +1578,19 @@ static int mmc_blk_cqe_issue_flush(struct mmc_queue *mq, struct request *req)
 static int mmc_blk_cqe_issue_rw_rq(struct mmc_queue *mq, struct request *req)
 {
 	struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
+	int err = 0;
 
 	mmc_blk_data_prep(mq, mqrq, 0, NULL, NULL);
 
-	return mmc_blk_cqe_start_req(mq->card->host, &mqrq->brq.mrq);
+	mmc_deferred_scaling(mq->card->host);
+	mmc_cqe_clk_scaling_start_busy(mq, mq->card->host, true);
+
+	err =  mmc_blk_cqe_start_req(mq->card->host, &mqrq->brq.mrq);
+
+	if (err)
+		mmc_cqe_clk_scaling_stop_busy(mq->card->host, true, false);
+
+	return err;
 }
 
 static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
@@ -1986,12 +2001,14 @@ static void mmc_blk_mq_poll_completion(struct mmc_queue *mq,
 
 static void mmc_blk_mq_dec_in_flight(struct mmc_queue *mq, struct request *req)
 {
+	struct mmc_host *host = mq->card->host;
 	unsigned long flags;
 	bool put_card;
 
 	spin_lock_irqsave(&mq->lock, flags);
 
 	mq->in_flight[mmc_issue_type(mq, req)] -= 1;
+	atomic_dec(&host->active_reqs);
 
 	put_card = (mmc_tot_in_flight(mq) == 0);
 
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index f0c233c..6e99c30 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -909,6 +909,9 @@ void mmc_request_done(struct mmc_host *host, struct mmc_request *mrq)
 	struct mmc_command *cmd = mrq->cmd;
 	int err = cmd->error;
 
+	if (host->clk_scaling.is_busy_started)
+		mmc_clk_scaling_stop_busy(host, true);
+
 	/* Flag re-tuning needed on CRC errors */
 	if (cmd->opcode != MMC_SEND_TUNING_BLOCK &&
 	    cmd->opcode != MMC_SEND_TUNING_BLOCK_HS200 &&
@@ -1120,6 +1123,11 @@ int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 	if (err)
 		return err;
 
+	if (mmc_is_data_request(mrq)) {
+		mmc_deferred_scaling(host);
+		mmc_clk_scaling_start_busy(host, true);
+	}
+
 	led_trigger_event(host->led, LED_FULL);
 	__mmc_start_request(host, mrq);
 
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 672f2d6..9138041 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -31,6 +31,10 @@
 
 #define cls_dev_to_mmc_host(d)	container_of(d, struct mmc_host, class_dev)
 
+#define MMC_DEVFRQ_DEFAULT_UP_THRESHOLD 35
+#define MMC_DEVFRQ_DEFAULT_DOWN_THRESHOLD 5
+#define MMC_DEVFRQ_DEFAULT_POLLING_MSEC 100
+
 static DEFINE_IDA(mmc_host_ida);
 
 static void mmc_host_classdev_release(struct device *dev)
@@ -493,6 +497,7 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 	}
 
 	spin_lock_init(&host->lock);
+	atomic_set(&host->active_reqs, 0);
 	init_waitqueue_head(&host->wq);
 	INIT_DELAYED_WORK(&host->detect, mmc_rescan);
 	INIT_DELAYED_WORK(&host->sdio_irq_work, sdio_irq_work);
@@ -537,6 +542,11 @@ int mmc_add_host(struct mmc_host *host)
 		return err;
 
 	led_trigger_register_simple(dev_name(&host->class_dev), &host->led);
+	host->clk_scaling.upthreshold = MMC_DEVFRQ_DEFAULT_UP_THRESHOLD;
+	host->clk_scaling.downthreshold = MMC_DEVFRQ_DEFAULT_DOWN_THRESHOLD;
+	host->clk_scaling.polling_delay_ms = MMC_DEVFRQ_DEFAULT_POLLING_MSEC;
+	host->clk_scaling.skip_clk_scale_freq_update = false;
+
 
 #ifdef CONFIG_DEBUG_FS
 	mmc_add_host_debugfs(host);
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index c9fccfc..bd8af5c 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1967,6 +1967,16 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 		}
 	}
 
+	card->clk_scaling_lowest = host->f_min;
+	if ((card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400) ||
+			(card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS200))
+		card->clk_scaling_highest = card->ext_csd.hs200_max_dtr;
+	else if ((card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS) ||
+			(card->mmc_avail_type & EXT_CSD_CARD_TYPE_DDR_52))
+		card->clk_scaling_highest = card->ext_csd.hs_max_dtr;
+	else
+		card->clk_scaling_highest = card->csd.max_dtr;
+
 	/*
 	 * Choose the power class with selected bus interface
 	 */
@@ -2164,6 +2174,7 @@ static int mmc_poweroff_notify(struct mmc_card *card, unsigned int notify_type)
  */
 static void mmc_remove(struct mmc_host *host)
 {
+	mmc_exit_clk_scaling(host);
 	mmc_remove_card(host->card);
 	host->card = NULL;
 }
@@ -2207,6 +2218,12 @@ static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
 	int err = 0;
 	unsigned int notify_type = is_suspend ? EXT_CSD_POWER_OFF_SHORT :
 					EXT_CSD_POWER_OFF_LONG;
+	err = mmc_suspend_clk_scaling(host);
+	if (err) {
+		pr_err("%s: %s: fail to suspend clock scaling (%d)\n",
+			mmc_hostname(host), __func__, err);
+		return err;
+	}
 
 	mmc_claim_host(host);
 
@@ -2231,6 +2248,9 @@ static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
 	}
 out:
 	mmc_release_host(host);
+	if (err)
+		mmc_resume_clk_scaling(host);
+
 	return err;
 }
 
@@ -2260,15 +2280,21 @@ static int _mmc_resume(struct mmc_host *host)
 
 	mmc_claim_host(host);
 
-	if (!mmc_card_suspended(host->card))
+	if (!mmc_card_suspended(host->card)) {
+		mmc_release_host(host);
 		goto out;
+	}
 
 	mmc_power_up(host, host->card->ocr);
 	err = mmc_init_card(host, host->card->ocr, host->card);
 	mmc_card_clr_suspended(host->card);
 
-out:
 	mmc_release_host(host);
+	err = mmc_resume_clk_scaling(host);
+	if (err)
+		pr_err("%s: %s: fail to resume clock scaling (%d)\n",
+			mmc_hostname(host), __func__, err);
+out:
 	return err;
 }
 
@@ -2286,6 +2312,12 @@ static int mmc_shutdown(struct mmc_host *host)
 	if (mmc_can_poweroff_notify(host->card) &&
 		!(host->caps2 & MMC_CAP2_FULL_PWR_CYCLE))
 		err = _mmc_resume(host);
+	/*
+	 * Exit clock scaling so that it doesn't kick in after
+	 * power off notification is sent
+	 */
+	if (host->caps2 & MMC_CAP2_CLK_SCALE)
+		mmc_exit_clk_scaling(host);
 
 	if (!err)
 		err = _mmc_suspend(host, false);
@@ -2348,6 +2380,7 @@ static int mmc_can_reset(struct mmc_card *card)
 static int _mmc_hw_reset(struct mmc_host *host)
 {
 	struct mmc_card *card = host->card;
+	int ret;
 
 	/*
 	 * In the case of recovery, we can't expect flushing the cache to work
@@ -2367,7 +2400,15 @@ static int _mmc_hw_reset(struct mmc_host *host)
 		mmc_power_cycle(host, card->ocr);
 		mmc_pwrseq_reset(host);
 	}
-	return mmc_init_card(host, card->ocr, card);
+
+	ret = mmc_init_card(host, host->card->ocr, host->card);
+	if (ret) {
+		pr_err("%s: %s: mmc_init_card failed (%d)\n",
+			mmc_hostname(host), __func__, ret);
+		return ret;
+	}
+
+	return ret;
 }
 
 static const struct mmc_bus_ops mmc_ops = {
@@ -2380,6 +2421,7 @@ static int _mmc_hw_reset(struct mmc_host *host)
 	.alive = mmc_alive,
 	.shutdown = mmc_shutdown,
 	.hw_reset = _mmc_hw_reset,
+	.change_bus_speed = mmc_change_bus_speed,
 };
 
 /*
@@ -2436,6 +2478,12 @@ int mmc_attach_mmc(struct mmc_host *host)
 		goto remove_card;
 
 	mmc_claim_host(host);
+	err = mmc_init_clk_scaling(host);
+	if (err) {
+		mmc_release_host(host);
+		goto remove_card;
+	}
+
 	return 0;
 
 remove_card:
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 9edc086..da22510 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -296,6 +296,7 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
 	mq->busy = true;
 
 	mq->in_flight[issue_type] += 1;
+	atomic_inc(&host->active_reqs);
 	get_card = (mmc_tot_in_flight(mq) == 1);
 	cqe_retune_ok = (mmc_cqe_qcnt(mq) == 1);
 
@@ -335,6 +336,7 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 		spin_lock_irq(&mq->lock);
 		mq->in_flight[issue_type] -= 1;
+		atomic_dec(&host->active_reqs);
 		if (mmc_tot_in_flight(mq) == 0)
 			put_card = true;
 		mq->busy = false;
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index fc78c09..54b8d92 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -645,7 +645,6 @@ static int mmc_sd_change_bus_speed(struct mmc_host *host, unsigned long *freq)
 	return err;
 }
 
-
 /*
  * UHS-I specific initialization procedure
  */
@@ -966,7 +965,10 @@ unsigned mmc_sd_get_max_clock(struct mmc_card *card)
 {
 	unsigned max_dtr = (unsigned int)-1;
 
-	if (mmc_card_hs(card)) {
+	if (mmc_card_uhs(card)) {
+		if (max_dtr > card->sw_caps.uhs_max_dtr)
+			max_dtr = card->sw_caps.uhs_max_dtr;
+	} else if (mmc_card_hs(card)) {
 		if (max_dtr > card->sw_caps.hs_max_dtr)
 			max_dtr = card->sw_caps.hs_max_dtr;
 	} else if (max_dtr > card->csd.max_dtr) {
@@ -1143,6 +1145,9 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 		err = -EINVAL;
 		goto free_card;
 	}
+
+	card->clk_scaling_highest = mmc_sd_get_max_clock(card);
+	card->clk_scaling_lowest = host->f_min;
 done:
 	host->card = card;
 	return 0;
@@ -1159,6 +1164,7 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
  */
 static void mmc_sd_remove(struct mmc_host *host)
 {
+	mmc_exit_clk_scaling(host);
 	mmc_remove_card(host->card);
 	host->card = NULL;
 }
@@ -1201,6 +1207,13 @@ static int _mmc_sd_suspend(struct mmc_host *host)
 {
 	int err = 0;
 
+	err = mmc_suspend_clk_scaling(host);
+	if (err) {
+		pr_err("%s: %s: fail to suspend clock scaling (%d)\n",
+			mmc_hostname(host), __func__,  err);
+		return err;
+	}
+
 	mmc_claim_host(host);
 
 	if (mmc_card_suspended(host->card))
@@ -1252,6 +1265,13 @@ static int _mmc_sd_resume(struct mmc_host *host)
 	err = mmc_sd_init_card(host, host->card->ocr, host->card);
 	mmc_card_clr_suspended(host->card);
 
+	err = mmc_resume_clk_scaling(host);
+	if (err) {
+		pr_err("%s: %s: fail to resume clock scaling (%d)\n",
+			mmc_hostname(host), __func__, err);
+		goto out;
+	}
+
 out:
 	mmc_release_host(host);
 	return err;
@@ -1315,6 +1335,7 @@ static int mmc_sd_hw_reset(struct mmc_host *host)
 	.alive = mmc_sd_alive,
 	.shutdown = mmc_sd_suspend,
 	.hw_reset = mmc_sd_hw_reset,
+	.change_bus_speed = mmc_sd_change_bus_speed,
 };
 
 /*
@@ -1375,6 +1396,13 @@ int mmc_attach_sd(struct mmc_host *host)
 		goto remove_card;
 
 	mmc_claim_host(host);
+
+	err = mmc_init_clk_scaling(host);
+	if (err) {
+		mmc_release_host(host);
+		goto remove_card;
+	}
+
 	return 0;
 
 remove_card:
-- 
1.9.1
