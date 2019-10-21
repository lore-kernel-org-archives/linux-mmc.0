From: Ram Prakash Gupta <rampraka@codeaurora.org>
Subject: [RFC 2/6] mmc: core: Add core scaling support in driver
Date: Mon, 21 Oct 2019 19:59:33 +0530
Message-ID: <1571668177-3766-3-git-send-email-rampraka@codeaurora.org>
References: <1571668177-3766-1-git-send-email-rampraka@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1571668177-3766-1-git-send-email-rampraka@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: asutoshd@codeaurora.org, stummala@codeaurora.org, sayalil@codeaurora.org, rampraka@codeaurora.org, vbadigan@codeaurora.org, cang@codeaurora.org, ppvk@codeaurora.org, adrian.hunter@intel.com, ulf.hansson@linaro.org, robh+dt@kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: Sujit Reddy Thumma <sthumma@codeaurora.org>, Talel Shenhar <tatias@codeaurora.org>, Ritesh Harjani <riteshh@codeaurora.org>, "Bao D. Nguyen" <nguyenb@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

Adding clock scaling support in clock scaling driver.

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
 drivers/mmc/core/core.c | 769 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/core/core.h |  17 ++
 drivers/mmc/core/mmc.c  | 192 ++++++++++++
 drivers/mmc/core/sd.c   |  54 ++++
 4 files changed, 1032 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 2211273..f0c233c 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -11,6 +11,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/completion.h>
+#include <linux/devfreq.h>
 #include <linux/device.h>
 #include <linux/delay.h>
 #include <linux/pagemap.h>
@@ -39,6 +40,7 @@
 #include "card.h"
 #include "bus.h"
 #include "host.h"
+#include "queue.h"
 #include "sdio_bus.h"
 #include "pwrseq.h"
 
@@ -109,6 +111,773 @@ static inline void mmc_should_fail_request(struct mmc_host *host,
 
 #endif /* CONFIG_FAIL_MMC_REQUEST */
 
+static bool mmc_is_data_request(struct mmc_request *mmc_request)
+{
+	switch (mmc_request->cmd->opcode) {
+	case MMC_READ_SINGLE_BLOCK:
+	case MMC_READ_MULTIPLE_BLOCK:
+	case MMC_WRITE_BLOCK:
+	case MMC_WRITE_MULTIPLE_BLOCK:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static void mmc_clk_scaling_start_busy(struct mmc_host *host, bool lock_needed)
+{
+	struct mmc_devfeq_clk_scaling *clk_scaling = &host->clk_scaling;
+
+	if (!clk_scaling->enable)
+		return;
+
+	if (lock_needed)
+		spin_lock_bh(&clk_scaling->lock);
+
+	clk_scaling->start_busy = ktime_get();
+	clk_scaling->is_busy_started = true;
+
+	if (lock_needed)
+		spin_unlock_bh(&clk_scaling->lock);
+}
+
+static void mmc_clk_scaling_stop_busy(struct mmc_host *host, bool lock_needed)
+{
+	struct mmc_devfeq_clk_scaling *clk_scaling = &host->clk_scaling;
+
+	if (!clk_scaling->enable)
+		return;
+
+	if (lock_needed)
+		spin_lock_bh(&clk_scaling->lock);
+
+	if (!clk_scaling->is_busy_started) {
+		WARN_ON(1);
+		goto out;
+	}
+
+	clk_scaling->total_busy_time_us +=
+		ktime_to_us(ktime_sub(ktime_get(),
+			clk_scaling->start_busy));
+	pr_debug("%s: accumulated busy time is %lu usec\n",
+		mmc_hostname(host), clk_scaling->total_busy_time_us);
+	clk_scaling->is_busy_started = false;
+
+out:
+	if (lock_needed)
+		spin_unlock_bh(&clk_scaling->lock);
+}
+
+/* mmc_cqe_clk_scaling_start_busy() - start busy timer for data requests
+ * @host: pointer to mmc host structure
+ * @lock_needed: flag indication if locking is needed
+ *
+ * This function starts the busy timer in case it was not already started.
+ */
+void mmc_cqe_clk_scaling_start_busy(struct mmc_queue *mq,
+			struct mmc_host *host, bool lock_needed)
+{
+	unsigned long flags;
+
+	if (!host->clk_scaling.enable)
+		return;
+
+	if (lock_needed)
+		spin_lock_irqsave(&host->clk_scaling.lock, flags);
+
+	if (!host->clk_scaling.is_busy_started &&
+			!(mq->cqe_busy & MMC_CQE_DCMD_BUSY)) {
+		host->clk_scaling.start_busy = ktime_get();
+		host->clk_scaling.is_busy_started = true;
+	}
+
+	if (lock_needed)
+		spin_unlock_irqrestore(&host->clk_scaling.lock, flags);
+}
+EXPORT_SYMBOL(mmc_cqe_clk_scaling_start_busy);
+
+/**
+ * mmc_cqe_clk_scaling_stop_busy() - stop busy timer for last data requests
+ * @host: pointer to mmc host structure
+ * @lock_needed: flag indication if locking is needed
+ *
+ * This function stops the busy timer in case it is the last data request.
+ * In case the current request is not the last one, the busy time till
+ * now will be accumulated and the counter will be restarted.
+ */
+void mmc_cqe_clk_scaling_stop_busy(struct mmc_host *host,
+	bool lock_needed, bool is_cqe_dcmd)
+{
+	unsigned int cqe_active_reqs = 0;
+
+	if (!host->clk_scaling.enable)
+		return;
+
+	cqe_active_reqs = atomic_read(&host->active_reqs);
+
+	/*
+	 * This gets invoked from CQE completion path which is hard IRQ context
+	 * So use spin_lock() instread of spin_lock_irqsave()
+	 */
+	if (lock_needed)
+		spin_lock(&host->clk_scaling.lock);
+
+	/*
+	 *  For CQ mode: In completion of DCMD request, start busy time in
+	 *  case of pending data requests
+	 */
+	if (is_cqe_dcmd) {
+		if (cqe_active_reqs && !host->clk_scaling.is_busy_started) {
+			host->clk_scaling.is_busy_started = true;
+			host->clk_scaling.start_busy = ktime_get();
+		}
+		goto out;
+	}
+
+	host->clk_scaling.total_busy_time_us +=
+		ktime_to_us(ktime_sub(ktime_get(),
+			host->clk_scaling.start_busy));
+
+	if (cqe_active_reqs) {
+		host->clk_scaling.is_busy_started = true;
+		host->clk_scaling.start_busy = ktime_get();
+	} else {
+		host->clk_scaling.is_busy_started = false;
+	}
+out:
+	if (lock_needed)
+		spin_unlock(&host->clk_scaling.lock);
+
+}
+EXPORT_SYMBOL(mmc_cqe_clk_scaling_stop_busy);
+
+/**
+ * mmc_can_scale_clk() - Check clock scaling capability
+ * @host: pointer to mmc host structure
+ */
+bool mmc_can_scale_clk(struct mmc_host *host)
+{
+	if (!host) {
+		pr_err("bad host parameter\n");
+		WARN_ON(1);
+		return false;
+	}
+
+	return host->caps2 & MMC_CAP2_CLK_SCALE;
+}
+EXPORT_SYMBOL(mmc_can_scale_clk);
+
+static int mmc_devfreq_get_dev_status(struct device *dev,
+		struct devfreq_dev_status *status)
+{
+	struct mmc_host *host = container_of(dev, struct mmc_host, class_dev);
+	struct mmc_devfeq_clk_scaling *clk_scaling;
+	unsigned long flags;
+
+	if (!host) {
+		pr_err("bad host parameter\n");
+		WARN_ON(1);
+		return -EINVAL;
+	}
+
+	clk_scaling = &host->clk_scaling;
+
+	if (!clk_scaling->enable)
+		return 0;
+
+	spin_lock_irqsave(&host->clk_scaling.lock, flags);
+
+	/* accumulate the busy time of ongoing work */
+	memset(status, 0, sizeof(*status));
+	if (clk_scaling->is_busy_started) {
+		if (host->cqe_on) {
+			/* the "busy-timer" will be restarted in case there
+			 * are pending data requests
+			 */
+			mmc_cqe_clk_scaling_stop_busy(host, false, false);
+		} else {
+			mmc_clk_scaling_stop_busy(host, false);
+			mmc_clk_scaling_start_busy(host, false);
+		}
+	}
+
+	status->busy_time = clk_scaling->total_busy_time_us;
+	status->total_time = ktime_to_us(ktime_sub(ktime_get(),
+		clk_scaling->measure_interval_start));
+	clk_scaling->total_busy_time_us = 0;
+	status->current_frequency = clk_scaling->curr_freq;
+	clk_scaling->measure_interval_start = ktime_get();
+
+	pr_debug("%s: status: load = %lu%% - total_time=%lu busy_time = %lu, clk=%lu\n",
+		mmc_hostname(host),
+		(status->busy_time*100)/status->total_time,
+		status->total_time, status->busy_time,
+		status->current_frequency);
+
+	spin_unlock_irqrestore(&host->clk_scaling.lock, flags);
+
+	return 0;
+}
+
+static bool mmc_is_valid_state_for_clk_scaling(struct mmc_host *host)
+{
+	struct mmc_card *card = host->card;
+	u32 status;
+
+	/*
+	 * If the current partition type is RPMB, clock switching may not
+	 * work properly as sending tuning command (CMD21) is illegal in
+	 * this mode.
+	 */
+	if (!card || (mmc_card_mmc(card) &&
+			(card->part_curr == EXT_CSD_PART_CONFIG_ACC_RPMB)))
+		return false;
+
+	if (mmc_send_status(card, &status)) {
+		pr_err("%s: Get card status fail\n", mmc_hostname(card->host));
+		return false;
+	}
+
+	return R1_CURRENT_STATE(status) == R1_STATE_TRAN;
+}
+
+int mmc_clk_update_freq(struct mmc_host *host,
+		unsigned long freq, enum mmc_load state)
+{
+	int err = 0;
+
+	if (!host) {
+		pr_err("bad host parameter\n");
+		WARN_ON(1);
+		return -EINVAL;
+	}
+
+	/* make sure the card supports the frequency we want */
+	if (unlikely(freq > host->card->clk_scaling_highest)) {
+		freq = host->card->clk_scaling_highest;
+		pr_warn("%s: %s: High freq was overridden to %lu\n",
+				mmc_hostname(host), __func__,
+				host->card->clk_scaling_highest);
+	}
+
+	if (unlikely(freq < host->card->clk_scaling_lowest)) {
+		freq = host->card->clk_scaling_lowest;
+		pr_warn("%s: %s: Low freq was overridden to %lu\n",
+			mmc_hostname(host), __func__,
+			host->card->clk_scaling_lowest);
+	}
+
+	if (freq == host->clk_scaling.curr_freq)
+		goto out;
+
+	if (host->cqe_on) {
+		err = host->cqe_ops->cqe_wait_for_idle(host);
+		if (err) {
+			pr_err("%s: %s: CQE went in recovery path\n",
+				mmc_hostname(host), __func__);
+			goto out;
+		}
+		host->cqe_ops->cqe_off(host);
+	}
+
+	if (!mmc_is_valid_state_for_clk_scaling(host)) {
+		pr_debug("%s: invalid state for clock scaling - skipping\n",
+			mmc_hostname(host));
+		goto out;
+	}
+
+	err = host->bus_ops->change_bus_speed(host, &freq);
+	if (!err)
+		host->clk_scaling.curr_freq = freq;
+	else
+		pr_err("%s: %s: failed (%d) at freq=%lu\n",
+			mmc_hostname(host), __func__, err, freq);
+
+	/*
+	 * CQE would be enabled as part of CQE issueing path
+	 * So no need to unhalt it explicitly
+	 */
+
+out:
+	return err;
+}
+EXPORT_SYMBOL(mmc_clk_update_freq);
+
+static int mmc_devfreq_set_target(struct device *dev,
+				unsigned long *freq, u32 devfreq_flags)
+{
+	struct mmc_host *host = container_of(dev, struct mmc_host, class_dev);
+	struct mmc_devfeq_clk_scaling *clk_scaling;
+	int err = 0;
+	int abort;
+	unsigned long pflags = current->flags;
+	unsigned long flags;
+
+	/* Ensure scaling would happen even in memory pressure conditions */
+	current->flags |= PF_MEMALLOC;
+
+	if (!(host && freq)) {
+		pr_err("%s: unexpected host/freq parameter\n", __func__);
+		err = -EINVAL;
+		goto out;
+	}
+
+	clk_scaling = &host->clk_scaling;
+
+	if (!clk_scaling->enable)
+		goto out;
+
+	pr_debug("%s: target freq = %lu (%s)\n", mmc_hostname(host),
+		*freq, current->comm);
+
+	spin_lock_irqsave(&clk_scaling->lock, flags);
+	if (clk_scaling->target_freq == *freq ||
+		clk_scaling->skip_clk_scale_freq_update) {
+		spin_unlock_irqrestore(&clk_scaling->lock, flags);
+		goto out;
+	}
+
+	clk_scaling->need_freq_change = true;
+	clk_scaling->target_freq = *freq;
+	clk_scaling->state = *freq < clk_scaling->curr_freq ?
+		MMC_LOAD_LOW : MMC_LOAD_HIGH;
+	spin_unlock_irqrestore(&clk_scaling->lock, flags);
+
+	if (!clk_scaling->is_suspended && host->ios.clock)
+		abort = __mmc_claim_host(host, NULL,
+				&clk_scaling->devfreq_abort);
+	else
+		goto out;
+
+	if (abort)
+		goto out;
+
+	/*
+	 * In case we were able to claim host there is no need to
+	 * defer the frequency change. It will be done now
+	 */
+	clk_scaling->need_freq_change = false;
+
+	err = mmc_clk_update_freq(host, *freq, clk_scaling->state);
+	if (err && err != -EAGAIN)
+		pr_err("%s: clock scale to %lu failed with error %d\n",
+			mmc_hostname(host), *freq, err);
+	else
+		pr_debug("%s: clock change to %lu finished successfully (%s)\n",
+			mmc_hostname(host), *freq, current->comm);
+
+	mmc_release_host(host);
+out:
+	current_restore_flags(pflags, PF_MEMALLOC);
+	return err;
+}
+
+/**
+ * mmc_deferred_scaling() - scale clocks from data path (mmc thread context)
+ * @host: pointer to mmc host structure
+ *
+ * This function does clock scaling in case "need_freq_change" flag was set
+ * by the clock scaling logic.
+ */
+void mmc_deferred_scaling(struct mmc_host *host)
+{
+	unsigned long target_freq;
+	int err;
+	struct mmc_devfeq_clk_scaling clk_scaling;
+	unsigned long flags;
+
+	if (!host->clk_scaling.enable)
+		return;
+
+	spin_lock_irqsave(&host->clk_scaling.lock, flags);
+
+	if (!host->clk_scaling.need_freq_change) {
+		spin_unlock_irqrestore(&host->clk_scaling.lock, flags);
+		return;
+	}
+
+	atomic_inc(&host->clk_scaling.devfreq_abort);
+	target_freq = host->clk_scaling.target_freq;
+	/*
+	 * Store the clock scaling state while the lock is acquired so that
+	 * if devfreq context modifies clk_scaling, it will get reflected only
+	 * in the next deferred scaling check.
+	 */
+	clk_scaling = host->clk_scaling;
+	host->clk_scaling.need_freq_change = false;
+	spin_unlock_irqrestore(&host->clk_scaling.lock, flags);
+
+	pr_debug("%s: doing deferred frequency change (%lu) (%s)\n",
+				mmc_hostname(host),
+				target_freq, current->comm);
+
+	err = mmc_clk_update_freq(host, target_freq,
+		clk_scaling.state);
+	if (err && err != -EAGAIN)
+		pr_err("%s: failed on deferred scale clocks (%d)\n",
+			mmc_hostname(host), err);
+	else
+		pr_debug("%s: clocks were successfully scaled to %lu (%s)\n",
+			mmc_hostname(host),
+			target_freq, current->comm);
+	atomic_dec(&host->clk_scaling.devfreq_abort);
+}
+EXPORT_SYMBOL(mmc_deferred_scaling);
+
+static int mmc_devfreq_create_freq_table(struct mmc_host *host)
+{
+	int i;
+	struct mmc_devfeq_clk_scaling *clk_scaling = &host->clk_scaling;
+
+	pr_debug("%s: supported: lowest=%lu, highest=%lu\n",
+		mmc_hostname(host),
+		host->card->clk_scaling_lowest,
+		host->card->clk_scaling_highest);
+
+	/*
+	 * Create the frequency table and initialize it with default values.
+	 * Initialize it with platform specific frequencies if the frequency
+	 * table supplied by platform driver is present, otherwise initialize
+	 * it with min and max frequencies supported by the card.
+	 */
+	if (!clk_scaling->freq_table) {
+		if (clk_scaling->pltfm_freq_table_sz)
+			clk_scaling->freq_table_sz =
+				clk_scaling->pltfm_freq_table_sz;
+		else
+			clk_scaling->freq_table_sz = 2;
+
+		clk_scaling->freq_table = kcalloc(
+			clk_scaling->freq_table_sz,
+			sizeof(*(clk_scaling->freq_table)), GFP_KERNEL);
+		if (!clk_scaling->freq_table)
+			return -ENOMEM;
+
+		if (clk_scaling->pltfm_freq_table) {
+			memcpy(clk_scaling->freq_table,
+				clk_scaling->pltfm_freq_table,
+				(clk_scaling->pltfm_freq_table_sz *
+				sizeof(*(clk_scaling->pltfm_freq_table))));
+		} else {
+			pr_debug("%s: no frequency table defined -  setting default\n",
+				mmc_hostname(host));
+			clk_scaling->freq_table[0] =
+				host->card->clk_scaling_lowest;
+			clk_scaling->freq_table[1] =
+				host->card->clk_scaling_highest;
+			goto out;
+		}
+	}
+
+	if (host->card->clk_scaling_lowest >
+		clk_scaling->freq_table[0])
+		pr_debug("%s: frequency table undershot possible freq\n",
+			mmc_hostname(host));
+
+	for (i = 0; i < clk_scaling->freq_table_sz; i++) {
+		if (clk_scaling->freq_table[i] <=
+			host->card->clk_scaling_highest)
+			continue;
+		clk_scaling->freq_table[i] =
+			host->card->clk_scaling_highest;
+		clk_scaling->freq_table_sz = i + 1;
+		pr_debug("%s: frequency table overshot possible freq (%d)\n",
+				mmc_hostname(host), clk_scaling->freq_table[i]);
+		break;
+	}
+
+out:
+	/**
+	 * devfreq requires unsigned long type freq_table while the
+	 * freq_table in clk_scaling is un32. Here allocates an individual
+	 * memory space for it and release it when exit clock scaling.
+	 */
+	clk_scaling->devfreq_profile.freq_table =  kcalloc(
+			clk_scaling->freq_table_sz,
+			sizeof(*(clk_scaling->devfreq_profile.freq_table)),
+			GFP_KERNEL);
+	if (!clk_scaling->devfreq_profile.freq_table) {
+		kfree(clk_scaling->freq_table);
+		return -ENOMEM;
+	}
+	clk_scaling->devfreq_profile.max_state = clk_scaling->freq_table_sz;
+
+	for (i = 0; i < clk_scaling->freq_table_sz; i++) {
+		clk_scaling->devfreq_profile.freq_table[i] =
+			clk_scaling->freq_table[i];
+		pr_debug("%s: freq[%d] = %u\n",
+			mmc_hostname(host), i, clk_scaling->freq_table[i]);
+	}
+
+	return 0;
+}
+
+/**
+ * mmc_init_devfreq_clk_scaling() - Initialize clock scaling
+ * @host: pointer to mmc host structure
+ *
+ * Initialize clock scaling for supported hosts. It is assumed that the caller
+ * ensure clock is running at maximum possible frequency before calling this
+ * function. Shall use struct devfreq_simple_ondemand_data to configure
+ * governor.
+ */
+int mmc_init_clk_scaling(struct mmc_host *host)
+{
+	int err;
+	struct devfreq *devfreq;
+
+	if (!host || !host->card) {
+		pr_err("%s: unexpected host/card parameters\n",
+			__func__);
+		return -EINVAL;
+	}
+
+	if (!mmc_can_scale_clk(host) ||
+		!host->bus_ops->change_bus_speed) {
+		pr_debug("%s: clock scaling is not supported\n",
+			mmc_hostname(host));
+		return 0;
+	}
+
+	pr_debug("registering %s dev (%pK) to devfreq\n",
+		mmc_hostname(host),
+		mmc_classdev(host));
+
+	if (host->clk_scaling.devfreq) {
+		pr_err("%s: dev is already registered for dev %pK\n",
+			mmc_hostname(host),
+			mmc_dev(host));
+		return -EPERM;
+	}
+	spin_lock_init(&host->clk_scaling.lock);
+	atomic_set(&host->clk_scaling.devfreq_abort, 0);
+	host->clk_scaling.curr_freq = host->ios.clock;
+	host->clk_scaling.need_freq_change = false;
+	host->clk_scaling.is_busy_started = false;
+
+	host->clk_scaling.devfreq_profile.polling_ms =
+		host->clk_scaling.polling_delay_ms;
+	host->clk_scaling.devfreq_profile.get_dev_status =
+		mmc_devfreq_get_dev_status;
+	host->clk_scaling.devfreq_profile.target = mmc_devfreq_set_target;
+	host->clk_scaling.devfreq_profile.initial_freq = host->ios.clock;
+
+	host->clk_scaling.ondemand_gov_data.upthreshold =
+		host->clk_scaling.upthreshold;
+	host->clk_scaling.ondemand_gov_data.downdifferential =
+		host->clk_scaling.upthreshold - host->clk_scaling.downthreshold;
+
+	err = mmc_devfreq_create_freq_table(host);
+	if (err) {
+		pr_err("%s: fail to create devfreq frequency table\n",
+			mmc_hostname(host));
+		return err;
+	}
+
+	dev_pm_opp_add(mmc_classdev(host),
+		host->clk_scaling.devfreq_profile.freq_table[0], 0);
+	dev_pm_opp_add(mmc_classdev(host),
+		host->clk_scaling.devfreq_profile.freq_table[1], 0);
+
+	pr_debug("%s: adding devfreq with: upthreshold=%u downthreshold=%u polling=%u\n",
+		mmc_hostname(host),
+		host->clk_scaling.ondemand_gov_data.upthreshold,
+		host->clk_scaling.ondemand_gov_data.downdifferential,
+		host->clk_scaling.devfreq_profile.polling_ms);
+
+	devfreq = devfreq_add_device(
+		mmc_classdev(host),
+		&host->clk_scaling.devfreq_profile,
+		"simple_ondemand",
+		&host->clk_scaling.ondemand_gov_data);
+
+	if (IS_ERR(devfreq)) {
+		pr_err("%s: unable to register with devfreq\n",
+			mmc_hostname(host));
+		dev_pm_opp_remove(mmc_classdev(host),
+			host->clk_scaling.devfreq_profile.freq_table[0]);
+		dev_pm_opp_remove(mmc_classdev(host),
+			host->clk_scaling.devfreq_profile.freq_table[1]);
+		return PTR_ERR(devfreq);
+	}
+
+	host->clk_scaling.devfreq = devfreq;
+	pr_debug("%s: clk scaling is enabled for device %s (%pK) with devfreq %pK (clock = %uHz)\n",
+		mmc_hostname(host),
+		dev_name(mmc_classdev(host)),
+		mmc_classdev(host),
+		host->clk_scaling.devfreq,
+		host->ios.clock);
+
+	host->clk_scaling.enable = true;
+
+	return err;
+}
+EXPORT_SYMBOL(mmc_init_clk_scaling);
+
+/**
+ * mmc_suspend_clk_scaling() - suspend clock scaling
+ * @host: pointer to mmc host structure
+ *
+ * This API will suspend devfreq feature for the specific host.
+ * The statistics collected by mmc will be cleared.
+ * This function is intended to be called by the pm callbacks
+ * (e.g. runtime_suspend, suspend) of the mmc device
+ */
+int mmc_suspend_clk_scaling(struct mmc_host *host)
+{
+	int err;
+
+	if (!host) {
+		WARN(1, "bad host parameter\n");
+		return -EINVAL;
+	}
+
+	if (!mmc_can_scale_clk(host) || !host->clk_scaling.enable ||
+			host->clk_scaling.is_suspended)
+		return 0;
+
+	if (!host->clk_scaling.devfreq) {
+		pr_err("%s: %s: no devfreq is assosiated with this device\n",
+			mmc_hostname(host), __func__);
+		return -EPERM;
+	}
+
+	atomic_inc(&host->clk_scaling.devfreq_abort);
+	wake_up(&host->wq);
+	err = devfreq_suspend_device(host->clk_scaling.devfreq);
+	if (err) {
+		pr_err("%s: %s: failed to suspend devfreq\n",
+			mmc_hostname(host), __func__);
+		return err;
+	}
+	host->clk_scaling.is_suspended = true;
+
+	host->clk_scaling.total_busy_time_us = 0;
+
+	pr_debug("%s: devfreq was removed\n", mmc_hostname(host));
+
+	return 0;
+}
+EXPORT_SYMBOL(mmc_suspend_clk_scaling);
+
+/**
+ * mmc_resume_clk_scaling() - resume clock scaling
+ * @host: pointer to mmc host structure
+ *
+ * This API will resume devfreq feature for the specific host.
+ * This API is intended to be called by the pm callbacks
+ * (e.g. runtime_suspend, suspend) of the mmc device
+ */
+int mmc_resume_clk_scaling(struct mmc_host *host)
+{
+	int err = 0;
+	u32 max_clk_idx = 0;
+	u32 devfreq_max_clk = 0;
+	u32 devfreq_min_clk = 0;
+
+	if (!host) {
+		WARN(1, "bad host parameter\n");
+		return -EINVAL;
+	}
+
+	if (!mmc_can_scale_clk(host))
+		return 0;
+
+	/*
+	 * If clock scaling is already exited when resume is called, like
+	 * during mmc shutdown, it is not an error and should not fail the
+	 * API calling this.
+	 */
+	if (!host->clk_scaling.devfreq) {
+		pr_warn("%s: %s: no devfreq is assosiated with this device\n",
+			mmc_hostname(host), __func__);
+		return 0;
+	}
+
+	atomic_set(&host->clk_scaling.devfreq_abort, 0);
+
+	max_clk_idx = host->clk_scaling.freq_table_sz - 1;
+	devfreq_max_clk = host->clk_scaling.freq_table[max_clk_idx];
+	devfreq_min_clk = host->clk_scaling.freq_table[0];
+
+	host->clk_scaling.curr_freq = devfreq_max_clk;
+	if (host->ios.clock < host->clk_scaling.freq_table[max_clk_idx])
+		host->clk_scaling.curr_freq = devfreq_min_clk;
+	host->clk_scaling.target_freq = host->clk_scaling.curr_freq;
+
+	err = devfreq_resume_device(host->clk_scaling.devfreq);
+	if (err) {
+		pr_err("%s: %s: failed to resume devfreq (%d)\n",
+			mmc_hostname(host), __func__, err);
+	} else {
+		host->clk_scaling.is_suspended = false;
+		pr_debug("%s: devfreq resumed\n", mmc_hostname(host));
+	}
+
+	return err;
+}
+EXPORT_SYMBOL(mmc_resume_clk_scaling);
+
+/**
+ * mmc_exit_devfreq_clk_scaling() - Disable clock scaling
+ * @host: pointer to mmc host structure
+ *
+ * Disable clock scaling permanently.
+ */
+int mmc_exit_clk_scaling(struct mmc_host *host)
+{
+	int err;
+
+	if (!host) {
+		pr_err("%s: bad host parameter\n", __func__);
+		WARN_ON(1);
+		return -EINVAL;
+	}
+
+	if (!mmc_can_scale_clk(host))
+		return 0;
+
+	if (!host->clk_scaling.devfreq) {
+		pr_err("%s: %s: no devfreq is assosiated with this device\n",
+			mmc_hostname(host), __func__);
+		return -EPERM;
+	}
+
+	err = mmc_suspend_clk_scaling(host);
+	if (err) {
+		pr_err("%s: %s: fail to suspend clock scaling (%d)\n",
+			mmc_hostname(host), __func__,  err);
+		return err;
+	}
+
+	err = devfreq_remove_device(host->clk_scaling.devfreq);
+	if (err) {
+		pr_err("%s: remove devfreq failed (%d)\n",
+			mmc_hostname(host), err);
+		return err;
+	}
+
+	dev_pm_opp_remove(mmc_classdev(host),
+		host->clk_scaling.devfreq_profile.freq_table[0]);
+	dev_pm_opp_remove(mmc_classdev(host),
+		host->clk_scaling.devfreq_profile.freq_table[1]);
+
+	kfree(host->clk_scaling.devfreq_profile.freq_table);
+
+	host->clk_scaling.devfreq = NULL;
+	atomic_set(&host->clk_scaling.devfreq_abort, 1);
+
+	kfree(host->clk_scaling.freq_table);
+	host->clk_scaling.freq_table = NULL;
+
+	pr_debug("%s: devfreq was removed\n", mmc_hostname(host));
+
+	return 0;
+}
+EXPORT_SYMBOL(mmc_exit_clk_scaling);
+
+
 static inline void mmc_complete_cmd(struct mmc_request *mrq)
 {
 	if (mrq->cap_cmd_during_tfr && !completion_done(&mrq->cmd_completion))
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 328c78d..2abf75a 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -14,6 +14,7 @@
 struct mmc_host;
 struct mmc_card;
 struct mmc_request;
+struct mmc_queue;
 
 #define MMC_CMD_RETRIES        3
 
@@ -29,6 +30,7 @@ struct mmc_bus_ops {
 	int (*shutdown)(struct mmc_host *);
 	int (*hw_reset)(struct mmc_host *);
 	int (*sw_reset)(struct mmc_host *);
+	int (*change_bus_speed)(struct mmc_host *host, unsigned long *freq);
 };
 
 void mmc_attach_bus(struct mmc_host *host, const struct mmc_bus_ops *ops);
@@ -57,6 +59,8 @@ int mmc_select_drive_strength(struct mmc_card *card, unsigned int max_dtr,
 void mmc_power_cycle(struct mmc_host *host, u32 ocr);
 void mmc_set_initial_state(struct mmc_host *host);
 u32 mmc_vddrange_to_ocrmask(int vdd_min, int vdd_max);
+int mmc_clk_update_freq(struct mmc_host *host,
+		unsigned long freq, enum mmc_load state);
 
 static inline void mmc_delay(unsigned int ms)
 {
@@ -87,6 +91,19 @@ static inline void mmc_delay(unsigned int ms)
 void mmc_add_card_debugfs(struct mmc_card *card);
 void mmc_remove_card_debugfs(struct mmc_card *card);
 
+extern bool mmc_can_scale_clk(struct mmc_host *host);
+extern int mmc_init_clk_scaling(struct mmc_host *host);
+extern int mmc_suspend_clk_scaling(struct mmc_host *host);
+extern int mmc_resume_clk_scaling(struct mmc_host *host);
+extern int mmc_exit_clk_scaling(struct mmc_host *host);
+extern void mmc_deferred_scaling(struct mmc_host *host);
+extern void mmc_cqe_clk_scaling_start_busy(struct mmc_queue *mq,
+	struct mmc_host *host, bool lock_needed);
+extern void mmc_cqe_clk_scaling_stop_busy(struct mmc_host *host,
+			bool lock_needed, bool is_cqe_dcmd);
+
+extern unsigned long mmc_get_max_frequency(struct mmc_host *host);
+
 int mmc_execute_tuning(struct mmc_card *card);
 int mmc_hs200_to_hs400(struct mmc_card *card);
 int mmc_hs400_to_hs200(struct mmc_card *card);
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index c880489..c9fccfc 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1539,6 +1539,198 @@ static int mmc_hs200_tuning(struct mmc_card *card)
 	return mmc_execute_tuning(card);
 }
 
+static int mmc_select_hs_ddr52(struct mmc_host *host)
+{
+	int err;
+
+	mmc_select_hs(host->card);
+	err = mmc_select_bus_width(host->card);
+	if (err < 0) {
+		pr_err("%s: %s: select_bus_width failed(%d)\n",
+			mmc_hostname(host), __func__, err);
+		return err;
+	}
+
+	err = mmc_select_hs_ddr(host->card);
+	mmc_set_clock(host, MMC_HIGH_52_MAX_DTR);
+
+	return err;
+}
+
+/*
+ * Scale down from HS400 to HS in order to allow frequency change.
+ * This is needed for cards that doesn't support changing frequency in HS400
+ */
+static int mmc_scale_low(struct mmc_host *host, unsigned long freq)
+{
+	int err = 0;
+
+	mmc_set_timing(host, MMC_TIMING_LEGACY);
+	mmc_set_clock(host, MMC_HIGH_26_MAX_DTR);
+
+	if (host->clk_scaling.lower_bus_speed_mode &
+	    MMC_SCALING_LOWER_DDR52_MODE) {
+		err = mmc_select_hs_ddr52(host);
+		if (err)
+			pr_err("%s: %s: failed to switch to DDR52: err: %d\n",
+			       mmc_hostname(host), __func__, err);
+		else
+			return err;
+	}
+
+	err = mmc_select_hs(host->card);
+	if (err) {
+		pr_err("%s: %s: scaling low: failed (%d)\n",
+		       mmc_hostname(host), __func__, err);
+		return err;
+	}
+
+	err = mmc_select_bus_width(host->card);
+	if (err < 0) {
+		pr_err("%s: %s: select_bus_width failed(%d)\n",
+			mmc_hostname(host), __func__, err);
+		return err;
+	}
+
+	mmc_set_clock(host, freq);
+
+	return 0;
+}
+
+/*
+ * Scale UP from HS to HS200/H400
+ */
+static int mmc_scale_high(struct mmc_host *host)
+{
+	int err = 0;
+
+	if (mmc_card_ddr52(host->card)) {
+		mmc_set_timing(host, MMC_TIMING_LEGACY);
+		mmc_set_clock(host, MMC_HIGH_26_MAX_DTR);
+	}
+
+	if (!host->card->ext_csd.strobe_support) {
+		if (!(host->card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS200)) {
+			pr_err("%s: %s: card does not support HS200\n",
+				mmc_hostname(host), __func__);
+			WARN_ON(1);
+			return -EPERM;
+		}
+
+		err = mmc_select_hs200(host->card);
+		if (err) {
+			pr_err("%s: %s: selecting HS200 failed (%d)\n",
+				mmc_hostname(host), __func__, err);
+			return err;
+		}
+
+		mmc_set_bus_speed(host->card);
+
+		err = mmc_hs200_tuning(host->card);
+		if (err) {
+			pr_err("%s: %s: hs200 tuning failed (%d)\n",
+				mmc_hostname(host), __func__, err);
+			return err;
+		}
+
+		if (!(host->card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400)) {
+			pr_debug("%s: card does not support HS400\n",
+				mmc_hostname(host));
+			return 0;
+		}
+	}
+
+	err = mmc_select_hs400(host->card);
+	if (err) {
+		pr_err("%s: %s: select hs400 failed (%d)\n",
+			mmc_hostname(host), __func__, err);
+		return err;
+	}
+
+	return 0;
+}
+
+static int mmc_set_clock_bus_speed(struct mmc_card *card, unsigned long freq)
+{
+	int err = 0;
+
+	if (freq == MMC_HS200_MAX_DTR)
+		err = mmc_scale_high(card->host);
+	else
+		err = mmc_scale_low(card->host, freq);
+
+	return err;
+}
+
+static inline unsigned long mmc_ddr_freq_accommodation(unsigned long freq)
+{
+	if (freq == MMC_HIGH_DDR_MAX_DTR)
+		return freq;
+
+	return freq/2;
+}
+
+/**
+ * mmc_change_bus_speed() - Change MMC card bus frequency at runtime
+ * @host: pointer to mmc host structure
+ * @freq: pointer to desired frequency to be set
+ *
+ * Change the MMC card bus frequency at runtime after the card is
+ * initialized. Callers are expected to make sure of the card's
+ * state (DATA/RCV/TRANSFER) before changing the frequency at runtime.
+ *
+ * If the frequency to change is greater than max. supported by card,
+ * *freq is changed to max. supported by card. If it is less than min.
+ * supported by host, *freq is changed to min. supported by host.
+ * Host is assumed to be calimed while calling this funciton.
+ */
+static int mmc_change_bus_speed(struct mmc_host *host, unsigned long *freq)
+{
+	int err = 0;
+	struct mmc_card *card;
+	unsigned long actual_freq;
+
+	card = host->card;
+
+	if (!card || !freq) {
+		err = -EINVAL;
+		goto out;
+	}
+	actual_freq = *freq;
+
+	WARN_ON(!host->claimed);
+
+	/*
+	 * For scaling up/down HS400 we'll need special handling,
+	 * for other timings we can simply do clock frequency change
+	 */
+	if (mmc_card_hs400(card) ||
+		(!mmc_card_hs200(host->card) && *freq == MMC_HS200_MAX_DTR)) {
+		err = mmc_set_clock_bus_speed(card, *freq);
+		if (err) {
+			pr_err("%s: %s: failed (%d)to set bus and clock speed (freq=%lu)\n",
+				mmc_hostname(host), __func__, err, *freq);
+			goto out;
+		}
+	} else if (mmc_card_hs200(host->card)) {
+		mmc_set_clock(host, *freq);
+		err = mmc_hs200_tuning(host->card);
+		if (err) {
+			pr_warn("%s: %s: tuning execution failed %d\n",
+				mmc_hostname(card->host),
+				__func__, err);
+			mmc_set_clock(host, host->clk_scaling.curr_freq);
+		}
+	} else {
+		if (mmc_card_ddr52(host->card))
+			actual_freq = mmc_ddr_freq_accommodation(*freq);
+		mmc_set_clock(host, actual_freq);
+	}
+
+out:
+	return err;
+}
+
 /*
  * Handle the detection and initialisation of a card.
  *
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index fe914ff..fc78c09 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -592,6 +592,60 @@ static int sd_set_current_limit(struct mmc_card *card, u8 *status)
 	return 0;
 }
 
+/**
+ * mmc_sd_change_bus_speed() - Change SD card bus frequency at runtime
+ * @host: pointer to mmc host structure
+ * @freq: pointer to desired frequency to be set
+ *
+ * Change the SD card bus frequency at runtime after the card is
+ * initialized. Callers are expected to make sure of the card's
+ * state (DATA/RCV/TRANSFER) beforing changing the frequency at runtime.
+ *
+ * If the frequency to change is greater than max. supported by card,
+ * *freq is changed to max. supported by card and if it is less than min.
+ * supported by host, *freq is changed to min. supported by host.
+ */
+static int mmc_sd_change_bus_speed(struct mmc_host *host, unsigned long *freq)
+{
+	int err = 0;
+	struct mmc_card *card;
+
+	/*
+	 * Assign card pointer after claiming host to avoid race
+	 * conditions that may arise during removal of the card.
+	 */
+	card = host->card;
+
+	/* sanity checks */
+	if (!card || !freq) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	mmc_set_clock(host, (unsigned int) (*freq));
+
+	if (!mmc_host_is_spi(card->host) && mmc_card_uhs(card)
+			&& card->host->ops->execute_tuning) {
+		/*
+		 * We try to probe host driver for tuning for any
+		 * frequency, it is host driver responsibility to
+		 * perform actual tuning only when required.
+		 */
+		err = card->host->ops->execute_tuning(card->host,
+				MMC_SEND_TUNING_BLOCK);
+		if (err) {
+			pr_warn("%s: %s: tuning execution failed %d. Restoring to previous clock %lu\n",
+				   mmc_hostname(card->host), __func__, err,
+				   host->clk_scaling.curr_freq);
+			mmc_set_clock(host, host->clk_scaling.curr_freq);
+		}
+	}
+
+out:
+	return err;
+}
+
+
 /*
  * UHS-I specific initialization procedure
  */
-- 
1.9.1
