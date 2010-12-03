From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH 1/3 ] mmc: add support for h/w clock gating of sd controller
Date: Fri, 3 Dec 2010 11:26:50 -0800
Message-ID: <3C50EC54-F380-4AE8-A417-4D3557FEB588@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:40504 "HELO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752996Ab0LCTbM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 3 Dec 2010 14:31:12 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Nicolas Pitre <nico@fluxnic.net>, Linus Walleij <linus.Walleij@stericsson.com>

This code extends software clock gating in the mmc layer
by adding the ability to indicate that controller support
hardware clock gating.

hardware clock gating is enabled by setting the mmc quirk
MMC_CAP_CLOCK_GATING_HW
in the sd driver.
eg: host->mmc->caps |= MMC_CAP_CLOCK_GATING_HW

The approach follows the suggestion of Nico Pitre.

sd/mmc/eMMC cards use dynmamic clocks
sdio uses continuous clocks

The code has been test using marvell linux for mmp2.  The marvell
controller support h/w clock gating.

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 drivers/mmc/core/core.c  |   18 +++++++++++++++---
 drivers/mmc/core/core.h  |   19 +++++++++++++++++++
 drivers/mmc/core/host.c  |   10 ++++++++--
 drivers/mmc/core/mmc.c   |    5 +++++
 drivers/mmc/core/sd.c    |    4 ++++
 drivers/mmc/core/sdio.c  |    5 +++++
 include/linux/mmc/host.h |    1 +
 7 files changed, 57 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 6286898..c8bba7d 100644
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
 
@@ -192,7 +195,10 @@ mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 			mrq->stop->mrq = mrq;
 		}
 	}
-	mmc_host_clk_ungate(host);
+#ifdef CONFIG_MMC_CLKGATE
+	if ((host->caps & MMC_CAP_CLOCK_GATING_HW) == 0)
+		mmc_host_clk_ungate(host);
+#endif
 	host->ops->request(host, mrq);
 }
 
@@ -1547,8 +1553,14 @@ void mmc_rescan(struct work_struct *work)
 		pr_info("%s: %s: trying to init card at %u Hz\n",
 			mmc_hostname(host), __func__, host->f_init);
 #endif
-		mmc_power_up(host);
+
+#ifdef CONFIG_MMC_CLKGATE
+		if (host->caps & MMC_CAP_CLOCK_GATING_HW)
+			mmc_hwungate_clock(host);
+#endif
 		sdio_reset(host);
+		mmc_power_up(host);
+
 		mmc_go_idle(host);
 
 		mmc_send_if_cond(host, host->ocr_avail);
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 026c975..184d56b 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -35,6 +35,25 @@ void mmc_set_chip_select(struct mmc_host *host, int mode);
 void mmc_set_clock(struct mmc_host *host, unsigned int hz);
 void mmc_gate_clock(struct mmc_host *host);
 void mmc_ungate_clock(struct mmc_host *host);
+
+#ifdef CONFIG_MMC_CLKGATE
+/*
+ * This gates the clock by enabling driver h/w gating
+ */
+static inline void mmc_hwgate_clock(struct mmc_host *host)
+{
+	host->clk_gated = true;
+}
+
+/*
+ * This ungates the clock by turning off h/w gating
+ */
+static inline void mmc_hwungate_clock(struct mmc_host *host)
+{
+	host->clk_gated = false;
+}
+#endif
+
 void mmc_set_ungated(struct mmc_host *host);
 void mmc_set_bus_mode(struct mmc_host *host, unsigned int mode);
 void mmc_set_bus_width(struct mmc_host *host, unsigned int width);
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 92e3370..ace748e 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -282,7 +282,10 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 	host->class_dev.class = &mmc_host_class;
 	device_initialize(&host->class_dev);
 
-	mmc_host_clk_init(host);
+#ifdef CONFIG_MMC_CLKGATE
+	if ((host->caps & MMC_CAP_CLOCK_GATING_HW) == 0)
+		mmc_host_clk_init(host);
+#endif
 
 	spin_lock_init(&host->lock);
 	init_waitqueue_head(&host->wq);
@@ -366,7 +369,10 @@ void mmc_remove_host(struct mmc_host *host)
 
 	led_trigger_unregister_simple(host->led);
 
-	mmc_host_clk_exit(host);
+#ifdef CONFIG_MMC_CLKGATE
+	if ((host->caps & MMC_CAP_CLOCK_GATING_HW) == 0)
+		mmc_host_clk_exit(host);
+#endif
 }
 
 EXPORT_SYMBOL(mmc_remove_host);
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 0eccd96..195e557 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -517,6 +517,11 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 
 	mmc_set_clock(host, max_dtr);
 
+#ifdef CONFIG_MMC_CLKGATE
+	if (host->caps & MMC_CAP_CLOCK_GATING_HW)
+		mmc_hwgate_clock(host);
+#endif
+
 	/*
 	 * Indicate DDR mode (if supported).
 	 */
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 49da4df..04e0d6f 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -618,6 +618,10 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 	else if (err)
 		goto free_card;
 
+#ifdef CONFIG_MMC_CLKGATE
+	if (host->caps & MMC_CAP_CLOCK_GATING_HW)
+		mmc_hwgate_clock(host);
+#endif
 	/*
 	 * Set bus speed.
 	 */
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index efef5f9..52fbbb7 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -488,6 +488,11 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 	else if (err)
 		goto remove;
 
+#ifdef CONFIG_MMC_CLKGATE
+	if (host->caps & MMC_CAP_CLOCK_GATING_HW)
+		mmc_hwungate_clock(host);
+#endif
+
 	/*
 	 * Change to the card's maximum speed.
 	 */
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 078cff7..30ce755 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -171,6 +171,7 @@ struct mmc_host {
 #define MMC_CAP_POWER_OFF_CARD	(1 << 13)	/* Can power off after boot */
 
 #define MMC_CAP_BUS_WIDTH_TEST	(1 << 14)	/* CMD14/CMD19 bus width ok */
+#define MMC_CAP_CLOCK_GATING_HW	(1 << 15)	/* h/w supports clock gating */
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
 
 #ifdef CONFIG_MMC_CLKGATE
-- 
1.6.0.4

