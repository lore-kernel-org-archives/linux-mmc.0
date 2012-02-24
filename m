From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH] mmc: start removing enable / disable API
Date: Fri, 24 Feb 2012 12:49:21 +0200
Message-ID: <1330080561-7256-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:31638 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753041Ab2BXKtX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 24 Feb 2012 05:49:23 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Rajendra Nayak <rnayak@ti.com>, Venkatraman S <svenkatr@ti.com>, Kukjin Kim <kgene.kim@samsung.com>, Thomas Abraham <thomas.abraham@linaro.org>, Kyungmin Park <kyungmin.park@samsung.com>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@ti.com>

Most parts of the enable / disable API are no longer used and
can be removed.

Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Venkatraman S <svenkatr@ti.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Thomas Abraham <thomas.abraham@linaro.org>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 arch/arm/mach-exynos/mach-nuri.c           |    5 +-
 arch/arm/mach-exynos/mach-universal_c210.c |    9 +-
 drivers/mmc/core/core.c                    |  185 ++--------------------------
 drivers/mmc/core/host.c                    |    1 -
 drivers/mmc/core/host.h                    |    1 -
 drivers/mmc/host/davinci_mmc.c             |    4 -
 drivers/mmc/host/omap_hsmmc.c              |   15 +--
 include/linux/mmc/core.h                   |    1 -
 include/linux/mmc/host.h                   |   46 +-------
 9 files changed, 25 insertions(+), 242 deletions(-)

diff --git a/arch/arm/mach-exynos/mach-nuri.c b/arch/arm/mach-exynos/mach-nuri.c
index 644af11..de68248 100644
--- a/arch/arm/mach-exynos/mach-nuri.c
+++ b/arch/arm/mach-exynos/mach-nuri.c
@@ -109,7 +109,7 @@ static struct s3c_sdhci_platdata nuri_hsmmc0_data __initdata = {
 	.max_width		= 8,
 	.host_caps		= (MMC_CAP_8_BIT_DATA | MMC_CAP_4_BIT_DATA |
 				MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
-				MMC_CAP_DISABLE | MMC_CAP_ERASE),
+				MMC_CAP_ERASE),
 	.cd_type		= S3C_SDHCI_CD_PERMANENT,
 };
 
@@ -147,8 +147,7 @@ static struct platform_device emmc_fixed_voltage = {
 static struct s3c_sdhci_platdata nuri_hsmmc2_data __initdata = {
 	.max_width		= 4,
 	.host_caps		= MMC_CAP_4_BIT_DATA |
-				MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
-				MMC_CAP_DISABLE,
+				MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED,
 	.ext_cd_gpio		= EXYNOS4_GPX3(3),	/* XEINT_27 */
 	.ext_cd_gpio_invert	= 1,
 	.cd_type		= S3C_SDHCI_CD_GPIO,
diff --git a/arch/arm/mach-exynos/mach-universal_c210.c b/arch/arm/mach-exynos/mach-universal_c210.c
index 9b3fbae..57cfe61 100644
--- a/arch/arm/mach-exynos/mach-universal_c210.c
+++ b/arch/arm/mach-exynos/mach-universal_c210.c
@@ -734,8 +734,7 @@ static struct platform_device universal_gpio_keys = {
 static struct s3c_sdhci_platdata universal_hsmmc0_data __initdata = {
 	.max_width		= 8,
 	.host_caps		= (MMC_CAP_8_BIT_DATA | MMC_CAP_4_BIT_DATA |
-				MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
-				MMC_CAP_DISABLE),
+				MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED),
 	.cd_type		= S3C_SDHCI_CD_PERMANENT,
 };
 
@@ -772,8 +771,7 @@ static struct platform_device mmc0_fixed_voltage = {
 static struct s3c_sdhci_platdata universal_hsmmc2_data __initdata = {
 	.max_width		= 4,
 	.host_caps		= MMC_CAP_4_BIT_DATA |
-				MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
-				MMC_CAP_DISABLE,
+				MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED,
 	.ext_cd_gpio		= EXYNOS4_GPX3(4),      /* XEINT_28 */
 	.ext_cd_gpio_invert	= 1,
 	.cd_type		= S3C_SDHCI_CD_GPIO,
@@ -783,8 +781,7 @@ static struct s3c_sdhci_platdata universal_hsmmc2_data __initdata = {
 static struct s3c_sdhci_platdata universal_hsmmc3_data __initdata = {
 	.max_width		= 4,
 	.host_caps		= MMC_CAP_4_BIT_DATA |
-				MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
-				MMC_CAP_DISABLE,
+				MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED,
 	.cd_type		= S3C_SDHCI_CD_EXTERNAL,
 };
 
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 0b317f0..7f8a9c0 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -605,105 +605,6 @@ unsigned int mmc_align_data_size(struct mmc_card *card, unsigned int sz)
 EXPORT_SYMBOL(mmc_align_data_size);
 
 /**
- *	mmc_host_enable - enable a host.
- *	@host: mmc host to enable
- *
- *	Hosts that support power saving can use the 'enable' and 'disable'
- *	methods to exit and enter power saving states. For more information
- *	see comments for struct mmc_host_ops.
- */
-int mmc_host_enable(struct mmc_host *host)
-{
-	if (!(host->caps & MMC_CAP_DISABLE))
-		return 0;
-
-	if (host->en_dis_recurs)
-		return 0;
-
-	if (host->nesting_cnt++)
-		return 0;
-
-	cancel_delayed_work_sync(&host->disable);
-
-	if (host->enabled)
-		return 0;
-
-	if (host->ops->enable) {
-		int err;
-
-		host->en_dis_recurs = 1;
-		mmc_host_clk_hold(host);
-		err = host->ops->enable(host);
-		mmc_host_clk_release(host);
-		host->en_dis_recurs = 0;
-
-		if (err) {
-			pr_debug("%s: enable error %d\n",
-				 mmc_hostname(host), err);
-			return err;
-		}
-	}
-	host->enabled = 1;
-	return 0;
-}
-EXPORT_SYMBOL(mmc_host_enable);
-
-static int mmc_host_do_disable(struct mmc_host *host, int lazy)
-{
-	if (host->ops->disable) {
-		int err;
-
-		host->en_dis_recurs = 1;
-		mmc_host_clk_hold(host);
-		err = host->ops->disable(host, lazy);
-		mmc_host_clk_release(host);
-		host->en_dis_recurs = 0;
-
-		if (err < 0) {
-			pr_debug("%s: disable error %d\n",
-				 mmc_hostname(host), err);
-			return err;
-		}
-		if (err > 0) {
-			unsigned long delay = msecs_to_jiffies(err);
-
-			mmc_schedule_delayed_work(&host->disable, delay);
-		}
-	}
-	host->enabled = 0;
-	return 0;
-}
-
-/**
- *	mmc_host_disable - disable a host.
- *	@host: mmc host to disable
- *
- *	Hosts that support power saving can use the 'enable' and 'disable'
- *	methods to exit and enter power saving states. For more information
- *	see comments for struct mmc_host_ops.
- */
-int mmc_host_disable(struct mmc_host *host)
-{
-	int err;
-
-	if (!(host->caps & MMC_CAP_DISABLE))
-		return 0;
-
-	if (host->en_dis_recurs)
-		return 0;
-
-	if (--host->nesting_cnt)
-		return 0;
-
-	if (!host->enabled)
-		return 0;
-
-	err = mmc_host_do_disable(host, 0);
-	return err;
-}
-EXPORT_SYMBOL(mmc_host_disable);
-
-/**
  *	__mmc_claim_host - exclusively claim a host
  *	@host: mmc host to claim
  *	@abort: whether or not the operation should be aborted
@@ -741,8 +642,8 @@ int __mmc_claim_host(struct mmc_host *host, atomic_t *abort)
 		wake_up(&host->wq);
 	spin_unlock_irqrestore(&host->lock, flags);
 	remove_wait_queue(&host->wq, &wait);
-	if (!stop)
-		mmc_host_enable(host);
+	if (host->ops->enable && !stop && host->claim_cnt == 1)
+		host->ops->enable(host);
 	return stop;
 }
 
@@ -772,16 +673,21 @@ int mmc_try_claim_host(struct mmc_host *host)
 EXPORT_SYMBOL(mmc_try_claim_host);
 
 /**
- *	mmc_do_release_host - release a claimed host
+ *	mmc_release_host - release a host
  *	@host: mmc host to release
  *
- *	If you successfully claimed a host, this function will
- *	release it again.
+ *	Release a MMC host, allowing others to claim the host
+ *	for their operations.
  */
-void mmc_do_release_host(struct mmc_host *host)
+void mmc_release_host(struct mmc_host *host)
 {
 	unsigned long flags;
 
+	WARN_ON(!host->claimed);
+
+	if (host->ops->disable && host->claim_cnt == 1)
+		host->ops->disable(host);
+
 	spin_lock_irqsave(&host->lock, flags);
 	if (--host->claim_cnt) {
 		/* Release for nested claim */
@@ -793,67 +699,6 @@ void mmc_do_release_host(struct mmc_host *host)
 		wake_up(&host->wq);
 	}
 }
-EXPORT_SYMBOL(mmc_do_release_host);
-
-void mmc_host_deeper_disable(struct work_struct *work)
-{
-	struct mmc_host *host =
-		container_of(work, struct mmc_host, disable.work);
-
-	/* If the host is claimed then we do not want to disable it anymore */
-	if (!mmc_try_claim_host(host))
-		return;
-	mmc_host_do_disable(host, 1);
-	mmc_do_release_host(host);
-}
-
-/**
- *	mmc_host_lazy_disable - lazily disable a host.
- *	@host: mmc host to disable
- *
- *	Hosts that support power saving can use the 'enable' and 'disable'
- *	methods to exit and enter power saving states. For more information
- *	see comments for struct mmc_host_ops.
- */
-int mmc_host_lazy_disable(struct mmc_host *host)
-{
-	if (!(host->caps & MMC_CAP_DISABLE))
-		return 0;
-
-	if (host->en_dis_recurs)
-		return 0;
-
-	if (--host->nesting_cnt)
-		return 0;
-
-	if (!host->enabled)
-		return 0;
-
-	if (host->disable_delay) {
-		mmc_schedule_delayed_work(&host->disable,
-				msecs_to_jiffies(host->disable_delay));
-		return 0;
-	} else
-		return mmc_host_do_disable(host, 1);
-}
-EXPORT_SYMBOL(mmc_host_lazy_disable);
-
-/**
- *	mmc_release_host - release a host
- *	@host: mmc host to release
- *
- *	Release a MMC host, allowing others to claim the host
- *	for their operations.
- */
-void mmc_release_host(struct mmc_host *host)
-{
-	WARN_ON(!host->claimed);
-
-	mmc_host_lazy_disable(host);
-
-	mmc_do_release_host(host);
-}
-
 EXPORT_SYMBOL(mmc_release_host);
 
 /*
@@ -2206,8 +2051,6 @@ void mmc_stop_host(struct mmc_host *host)
 	spin_unlock_irqrestore(&host->lock, flags);
 #endif
 
-	if (host->caps & MMC_CAP_DISABLE)
-		cancel_delayed_work(&host->disable);
 	cancel_delayed_work_sync(&host->detect);
 	mmc_flush_scheduled_work();
 
@@ -2402,13 +2245,11 @@ int mmc_suspend_host(struct mmc_host *host)
 {
 	int err = 0;
 
-	if (host->caps & MMC_CAP_DISABLE)
-		cancel_delayed_work(&host->disable);
 	cancel_delayed_work(&host->detect);
 	mmc_flush_scheduled_work();
 	if (mmc_try_claim_host(host)) {
 		err = mmc_cache_ctrl(host, 0);
-		mmc_do_release_host(host);
+		mmc_release_host(host);
 	} else {
 		err = -EBUSY;
 	}
@@ -2429,7 +2270,7 @@ int mmc_suspend_host(struct mmc_host *host)
 			if (host->bus_ops->suspend) {
 				err = host->bus_ops->suspend(host);
 			}
-			mmc_do_release_host(host);
+			mmc_release_host(host);
 
 			if (err == -ENOSYS || !host->bus_ops->resume) {
 				/*
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index c3704e2..91c84c7 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -330,7 +330,6 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 	spin_lock_init(&host->lock);
 	init_waitqueue_head(&host->wq);
 	INIT_DELAYED_WORK(&host->detect, mmc_rescan);
-	INIT_DELAYED_WORK_DEFERRABLE(&host->disable, mmc_host_deeper_disable);
 #ifdef CONFIG_PM
 	host->pm_notify.notifier_call = mmc_pm_notify;
 #endif
diff --git a/drivers/mmc/core/host.h b/drivers/mmc/core/host.h
index 08a7852..f2ab9e5 100644
--- a/drivers/mmc/core/host.h
+++ b/drivers/mmc/core/host.h
@@ -14,7 +14,6 @@
 
 int mmc_register_host_class(void);
 void mmc_unregister_host_class(void);
-void mmc_host_deeper_disable(struct work_struct *work);
 
 #endif
 
diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index 64a8325..8de9c9b 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -1418,17 +1418,14 @@ static int davinci_mmcsd_suspend(struct device *dev)
 	struct mmc_davinci_host *host = platform_get_drvdata(pdev);
 	int ret;
 
-	mmc_host_enable(host->mmc);
 	ret = mmc_suspend_host(host->mmc);
 	if (!ret) {
 		writel(0, host->base + DAVINCI_MMCIM);
 		mmc_davinci_reset_ctrl(host, 1);
-		mmc_host_disable(host->mmc);
 		clk_disable(host->clk);
 		host->suspended = 1;
 	} else {
 		host->suspended = 0;
-		mmc_host_disable(host->mmc);
 	}
 
 	return ret;
@@ -1444,7 +1441,6 @@ static int davinci_mmcsd_resume(struct device *dev)
 		return 0;
 
 	clk_enable(host->clk);
-	mmc_host_enable(host->mmc);
 
 	mmc_davinci_reset_ctrl(host, 0);
 	ret = mmc_resume_host(host->mmc);
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 36e7f5b..fdb24cf 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -179,7 +179,6 @@ struct omap_hsmmc_host {
 	int			got_dbclk;
 	int			response_busy;
 	int			context_loss;
-	int			dpm_state;
 	int			vdd;
 	int			protect_card;
 	int			reqs_blocked;
@@ -1748,7 +1747,7 @@ static int omap_hsmmc_enable_fclk(struct mmc_host *mmc)
 	return 0;
 }
 
-static int omap_hsmmc_disable_fclk(struct mmc_host *mmc, int lazy)
+static int omap_hsmmc_disable_fclk(struct mmc_host *mmc)
 {
 	struct omap_hsmmc_host *host = mmc_priv(mmc);
 
@@ -1782,15 +1781,8 @@ static int omap_hsmmc_regs_show(struct seq_file *s, void *data)
 	if (host->pdata->get_context_loss_count)
 		context_loss = host->pdata->get_context_loss_count(host->dev);
 
-	seq_printf(s, "mmc%d:\n"
-			" enabled:\t%d\n"
-			" dpm_state:\t%d\n"
-			" nesting_cnt:\t%d\n"
-			" ctx_loss:\t%d:%d\n"
-			"\nregs:\n",
-			mmc->index, mmc->enabled ? 1 : 0,
-			host->dpm_state, mmc->nesting_cnt,
-			host->context_loss, context_loss);
+	seq_printf(s, "mmc%d:\n ctx_loss:\t%d:%d\n\nregs:\n",
+			mmc->index, host->context_loss, context_loss);
 
 	if (host->suspended) {
 		seq_printf(s, "host suspended, can't read registers\n");
@@ -1930,7 +1922,6 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
 
 	omap_hsmmc_context_save(host);
 
-	mmc->caps |= MMC_CAP_DISABLE;
 	if (host->pdata->controller_flags & OMAP_HSMMC_BROKEN_MULTIBLOCK_READ) {
 		dev_info(&pdev->dev, "multiblock reads disabled due to 35xx erratum 2.1.1.128; MMC read performance may suffer\n");
 		mmc->caps2 |= MMC_CAP2_NO_MULTI_READ;
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 87a976c..2bfa589 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -175,7 +175,6 @@ extern unsigned int mmc_align_data_size(struct mmc_card *, unsigned int);
 
 extern int __mmc_claim_host(struct mmc_host *host, atomic_t *abort);
 extern void mmc_release_host(struct mmc_host *host);
-extern void mmc_do_release_host(struct mmc_host *host);
 extern int mmc_try_claim_host(struct mmc_host *host);
 
 extern int mmc_flush_cache(struct mmc_card *);
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index ee2b036..70ba905d 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -80,34 +80,11 @@ struct mmc_ios {
 
 struct mmc_host_ops {
 	/*
-	 * Hosts that support power saving can use the 'enable' and 'disable'
-	 * methods to exit and enter power saving states. 'enable' is called
-	 * when the host is claimed and 'disable' is called (or scheduled with
-	 * a delay) when the host is released. The 'disable' is scheduled if
-	 * the disable delay set by 'mmc_set_disable_delay()' is non-zero,
-	 * otherwise 'disable' is called immediately. 'disable' may be
-	 * scheduled repeatedly, to permit ever greater power saving at the
-	 * expense of ever greater latency to re-enable. Rescheduling is
-	 * determined by the return value of the 'disable' method. A positive
-	 * value gives the delay in milliseconds.
-	 *
-	 * In the case where a host function (like set_ios) may be called
-	 * with or without the host claimed, enabling and disabling can be
-	 * done directly and will nest correctly. Call 'mmc_host_enable()' and
-	 * 'mmc_host_lazy_disable()' for this purpose, but note that these
-	 * functions must be paired.
-	 *
-	 * Alternatively, 'mmc_host_enable()' may be paired with
-	 * 'mmc_host_disable()' which calls 'disable' immediately.  In this
-	 * case the 'disable' method will be called with 'lazy' set to 0.
-	 * This is mainly useful for error paths.
-	 *
-	 * Because lazy disable may be called from a work queue, the 'disable'
-	 * method must claim the host when 'lazy' != 0, which will work
-	 * correctly because recursion is detected and handled.
+	 * 'enable' is called when the host is claimed and 'disable' is called
+	 * when the host is released. 'enable' and 'disable' are deprecated.
 	 */
 	int (*enable)(struct mmc_host *host);
-	int (*disable)(struct mmc_host *host, int lazy);
+	int (*disable)(struct mmc_host *host);
 	/*
 	 * It is optional for the host to implement pre_req and post_req in
 	 * order to support double buffering of requests (prepare one
@@ -218,7 +195,7 @@ struct mmc_host {
 #define MMC_CAP_SPI		(1 << 4)	/* Talks only SPI protocols */
 #define MMC_CAP_NEEDS_POLL	(1 << 5)	/* Needs polling for card-detection */
 #define MMC_CAP_8_BIT_DATA	(1 << 6)	/* Can the host do 8 bit transfers */
-#define MMC_CAP_DISABLE		(1 << 7)	/* Can the host be disabled */
+
 #define MMC_CAP_NONREMOVABLE	(1 << 8)	/* Nonremovable e.g. eMMC */
 #define MMC_CAP_WAIT_WHILE_BUSY	(1 << 9)	/* Waits while card is busy */
 #define MMC_CAP_ERASE		(1 << 10)	/* Allow erase/trim commands */
@@ -300,13 +277,7 @@ struct mmc_host {
 	unsigned int		removed:1;	/* host is being removed */
 #endif
 
-	/* Only used with MMC_CAP_DISABLE */
-	int			enabled;	/* host is enabled */
 	int			rescan_disable;	/* disable card detection */
-	int			nesting_cnt;	/* "enable" nesting count */
-	int			en_dis_recurs;	/* detect recursion */
-	unsigned int		disable_delay;	/* disable delay in msecs */
-	struct delayed_work	disable;	/* disabling work */
 
 	struct mmc_card		*card;		/* device attached to this host */
 
@@ -406,17 +377,8 @@ int mmc_card_awake(struct mmc_host *host);
 int mmc_card_sleep(struct mmc_host *host);
 int mmc_card_can_sleep(struct mmc_host *host);
 
-int mmc_host_enable(struct mmc_host *host);
-int mmc_host_disable(struct mmc_host *host);
-int mmc_host_lazy_disable(struct mmc_host *host);
 int mmc_pm_notify(struct notifier_block *notify_block, unsigned long, void *);
 
-static inline void mmc_set_disable_delay(struct mmc_host *host,
-					 unsigned int disable_delay)
-{
-	host->disable_delay = disable_delay;
-}
-
 /* Module parameter */
 extern bool mmc_assume_removable;
 
-- 
1.7.6.4

