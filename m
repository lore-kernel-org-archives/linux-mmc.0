From: Philip Rakity <prakity@marvell.com>
Subject: RE: [RFC] mmc: agressive clocking framework v8 [h/w approach]
Date: Wed, 10 Nov 2010 12:09:08 -0800
Message-ID: <3B8EAD52-02C3-4E0D-A5A4-33157991E2EF@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:38348 "HELO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755620Ab0KJUL1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 10 Nov 2010 15:11:27 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Linus Walleij <linus.Walleij@stericsson.com>


The following patch is on top of v8 to support hardware clock gating.  I do not have hardware to test
this code until next week.  

Comments welcome.  Will revise once it is tested.

Philip


diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 8bf542c..5339fa8 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -131,7 +131,10 @@ void mmc_request_done(struct mmc_host *host, struct mmc_request *mrq)
 		if (mrq->done)
 			mrq->done(mrq);
 
-		mmc_host_clk_gate(host);
+#ifdef CONFIG_MMC_CLKGATE
+		if ((host->caps & MMC_CAP_CLOCK_GATING_HW) == 0)
+			mmc_host_clk_gate(host);
+#endif
 	}
 }
 
@@ -192,7 +195,12 @@ mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 			mrq->stop->mrq = mrq;
 		}
 	}
-	mmc_host_clk_ungate(host);
+
+#ifdef CONFIG_MMC_CLKGATE
+	if ((host->caps & MMC_CAP_CLOCK_GATING_HW) == 0)
+		mmc_host_clk_ungate(host);
+#endif
+
 	host->ops->request(host, mrq);
 }
 
@@ -622,8 +630,10 @@ static inline void mmc_set_ios(struct mmc_host *host)
 	 * We've been given a new frequency while the clock is gated,
 	 * so make sure we regard this as ungating it.
 	 */
-	if (ios->clock > 0 && host->clk_gated)
-		host->clk_gated = false;
+	if ((host->caps & MMC_CAP_CLOCK_GATING_HW) == 0
+			&& ios->clock > 0
+			&& host->clk_gated)
+		host->clk_gated = MMC_CLOCK_GATED_OFF;
 #endif
 
 	host->ops->set_ios(host, ios);
@@ -657,11 +667,11 @@ void mmc_set_clock(struct mmc_host *host, unsigned int hz)
 /*
  * This gates the clock by setting it to 0 Hz.
  */
-void mmc_gate_clock(struct mmc_host *host)
+void mmc_gate_clock(struct mmc_host *host, int clk_gating)
 {
 	host->clk_old = host->ios.clock;
 	host->ios.clock = 0;
-	host->clk_gated = true;
+	host->clk_gated = clk_gating;
 	mmc_set_ios(host);
 }
 
@@ -682,7 +692,37 @@ void mmc_ungate_clock(struct mmc_host *host)
 		BUG_ON(host->ios.clock);
 		mmc_set_clock(host, host->clk_old);
 	}
-	host->clk_gated = false;
+	host->clk_gated = MMC_CLOCK_GATED_OFF;
+}
+
+/*
+ * This gates the clock by enabling driver h/w
+ */
+void mmc_hwgate_clock(struct mmc_host *host, int clk_gating)
+{
+	host->clk_old = host->ios.clock;
+	host->ios.clock = 0;
+	host->clk_gated = clk_gating;
+	mmc_set_ios(host);
+}
+
+/*
+ * This ungates the clock by turning off h/w gating
+ */
+void mmc_hwungate_clock(struct mmc_host *host)
+{
+	/*
+	 * We should previously have gated the clock, so the clock shall
+	 * be 0 here! The clock may however be 0 during initialization,
+	 * when some request operations are performed before setting
+	 * the frequency. When ungate is requested in that situation
+	 * we just ignore the call.
+	 */
+	if (host->clk_old) {
+		BUG_ON(host->ios.clock);
+		mmc_set_clock(host, host->clk_old);
+	}
+	host->clk_gated = MMC_CLOCK_GATED_OFF;
 }
 #endif
 
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 9972808..da3ba94 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -33,8 +33,10 @@ void mmc_init_erase(struct mmc_card *card);
 
 void mmc_set_chip_select(struct mmc_host *host, int mode);
 void mmc_set_clock(struct mmc_host *host, unsigned int hz);
-void mmc_gate_clock(struct mmc_host *host);
+void mmc_gate_clock(struct mmc_host *host, int clk_gating);
+void mmc_hwgate_clock(struct mmc_host *host, int clk_gating);
 void mmc_ungate_clock(struct mmc_host *host);
+void mmc_hwungate_clock(struct mmc_host *host);
 void mmc_set_bus_mode(struct mmc_host *host, unsigned int mode);
 void mmc_set_bus_width(struct mmc_host *host, unsigned int width);
 void mmc_set_bus_width_ddr(struct mmc_host *host, unsigned int width,
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index aacd9c5..4a73d4d 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -101,7 +101,7 @@ static void mmc_host_clk_gate_delayed(struct mmc_host *host)
 	if (!host->clk_requests) {
 		spin_unlock_irqrestore(&host->clk_lock, flags);
 		/* This will set host->ios.clock to 0 */
-		mmc_gate_clock(host);
+		mmc_gate_clock(host, MMC_CLOCK_GATED_SW_ON);
 		spin_lock_irqsave(&host->clk_lock, flags);
 		pr_debug("%s: gated MCI clock\n", mmc_hostname(host));
 	}
@@ -217,7 +217,7 @@ static inline void mmc_host_clk_init(struct mmc_host *host)
 	host->clk_requests = 0;
 	/* Hold MCI clock for 8 cycles by default */
 	host->clk_delay = 8;
-	host->clk_gated = false;
+	host->clk_gated = MMC_CLOCK_GATED_OFF;
 	host->clk_pending_gate = false;
 	INIT_WORK(&host->clk_disable_work, mmc_host_clk_gate_work);
 	spin_lock_init(&host->clk_lock);
@@ -284,7 +284,10 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 	host->class_dev.class = &mmc_host_class;
 	device_initialize(&host->class_dev);
 
-	mmc_host_clk_init(host);
+#ifdef CONFIG_MMC_CLKGATE
+	if ((host->caps & MMC_CAP_CLOCK_GATING_HW) == 0)
+		mmc_host_clk_init(host);
+#endif
 
 	spin_lock_init(&host->lock);
 	init_waitqueue_head(&host->wq);
@@ -368,7 +371,10 @@ void mmc_remove_host(struct mmc_host *host)
 
 	led_trigger_unregister_simple(host->led);
 
-	mmc_host_clk_exit(host);
+#ifdef CONFIG_MMC_CLKGATE
+	if ((host->caps & MMC_CAP_CLOCK_GATING_HW) == 0)
+		mmc_host_clk_exit(host);
+#endif
 }
 
 EXPORT_SYMBOL(mmc_remove_host);
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 77f93c3..2191553 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -516,6 +516,10 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	}
 
 	mmc_set_clock(host, max_dtr);
+#ifdef CONFIG_MMC_CLKGATE
+	if (host->caps & MMC_CAP_CLOCK_GATING_HW)
+		mmc_hwgate_clock(host, MMC_CLOCK_GATED_HW_ON);
+#endif
 
 	/*
 	 * Indicate DDR mode (if supported).
@@ -592,6 +596,10 @@ static void mmc_remove(struct mmc_host *host)
 	BUG_ON(!host);
 	BUG_ON(!host->card);
 
+#ifdef CONFIG_MMC_CLKGATE
+	if (host->caps & MMC_CAP_CLOCK_GATING_HW)
+		mmc_hwungate_clock(host);
+#endif
 	mmc_remove_card(host->card);
 	host->card = NULL;
 }
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 49da4df..fa4254a 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -622,6 +622,10 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 	 * Set bus speed.
 	 */
 	mmc_set_clock(host, mmc_sd_get_max_clock(card));
+#ifdef CONFIG_MMC_CLKGATE
+	if (host->caps & MMC_CAP_CLOCK_GATING_HW)
+		mmc_hwgate_clock(host, MMC_CLOCK_GATED_HW_ON);
+#endif
 
 	/*
 	 * Switch to wider bus (if supported).
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index c3ad105..d305ac0 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -425,6 +425,10 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 		 * It's host's responsibility to fill cccr and cis
 		 * structures in init_card().
 		 */
+#ifdef CONFIG_MMC_CLKGATE
+		if (host->caps & MMC_CAP_CLOCK_GATING_HW)
+			mmc_hwgate_clock(host, MMC_CLOCK_GATED_OFF);
+#endif
 		mmc_set_clock(host, card->cis.max_dtr);
 
 		if (card->cccr.high_speed) {
@@ -491,6 +495,10 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 	/*
 	 * Change to the card's maximum speed.
 	 */
+#ifdef CONFIG_MMC_CLKGATE
+	if (host->caps & MMC_CAP_CLOCK_GATING_HW)
+		mmc_hwgate_clock(host, MMC_CLOCK_GATED_OFF);
+#endif
 	mmc_set_clock(host, mmc_sdio_get_max_clock(card));
 
 	/*
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 154cbf8..00a4720 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1185,6 +1185,9 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	if (host->ops->platform_send_init_74_clocks)
 		host->ops->platform_send_init_74_clocks(host, ios->power_mode);
 
+	if ((mmc->caps & MMC_CAP_CLOCK_GATING_HW) && host->ops->hw_clk_gate)
+		host->ops->hw_clk_gate(host);
+
 	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
 
 	if (ios->bus_width == MMC_BUS_WIDTH_8)
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index d52a716..47d081d 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -218,6 +218,7 @@ struct sdhci_ops {
 	void (*platform_send_init_74_clocks)(struct sdhci_host *host,
 					     u8 power_mode);
 	unsigned int    (*get_ro)(struct sdhci_host *host);
+	void		(*hw_clk_gate)(struct sdhci_host *host);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index f108cee..1878cfb 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -168,13 +168,18 @@ struct mmc_host {
 						/* DDR mode at 1.8V */
 #define MMC_CAP_1_2V_DDR	(1 << 12)	/* can support */
 						/* DDR mode at 1.2V */
+#define MMC_CAP_CLOCK_GATING_HW	(1 << 13)	/* h/w supports clock gating */
 
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
 
 #ifdef CONFIG_MMC_CLKGATE
 	int			clk_requests;	/* internal reference counter */
 	unsigned int		clk_delay;	/* number of MCI clk hold cycles */
-	bool			clk_gated;	/* clock gated */
+
+#define MMC_CLOCK_GATED_OFF		0
+#define MMC_CLOCK_GATED_SW_ON	1
+#define MMC_CLOCK_GATED_HW_ON	2
+	int			clk_gated;	/* clock gated */
 	bool			clk_pending_gate; /* pending clock gating */
 	struct work_struct	clk_disable_work; /* delayed clock disable */
 	unsigned int		clk_old;	/* old clock value cache */

