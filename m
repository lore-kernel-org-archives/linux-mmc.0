From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH 1/2] mmc: add support for H/W clock gating of SD controller
Date: Sun, 13 Feb 2011 23:22:30 -0800
Message-ID: <80EF78B4-1449-457B-91EC-3823EC303F68@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:37009 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751367Ab1BNHXh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Feb 2011 02:23:37 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Mark Brown <markb@marvell.com>


This code extends software clock gating in the MMC layer by adding the ability
to indicate that the SD controller supports hardware clock gating.

Hardware clock gating is enabled by setting the MMC capability
MMC_CAP_HW_CLOCK_GATING in the SD driver.

eg: host->mmc->caps |= MMC_CAP_HW_CLOCK_GATING

The approach follows the suggestion of Nico Pitre.

SD/MMC/eMMC cards use dynamic clocks
SDIO uses continuous clocks to properly detect SDIO card interrupts

The code has been tested using marvell linux and linux-next for MMP2.
The Marvell pxa controllers support H/W clock gating.

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 drivers/mmc/core/core.c  |   51 +++++++++++++++++++++++++++++++++++++++------
 drivers/mmc/core/core.h  |   13 +++++++++++
 drivers/mmc/core/host.c  |   18 ++++++++++++++-
 drivers/mmc/core/host.h  |    1 +
 drivers/mmc/host/sdhci.c |   15 +++++++++++++
 drivers/mmc/host/sdhci.h |    1 +
 include/linux/mmc/host.h |    1 +
 7 files changed, 91 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 37e66d3..4306b32 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -683,10 +683,35 @@ void mmc_ungate_clock(struct mmc_host *host)
 	}
 }
 
+/*
+ * Let hardware automatically gate the clock when the card becomes idle
+ */
+void mmc_hwgate_clock(struct mmc_host *host)
+{
+	if (host->caps & MMC_CAP_HW_CLOCK_GATING) {
+		host->clk_gated = true;
+		mmc_set_ios(host);
+	}
+}
+
+/*
+ * This ungates the clock by turning off h/w gating
+ */
+void mmc_hwungate_clock(struct mmc_host *host)
+{
+	if (host->caps & MMC_CAP_HW_CLOCK_GATING) {
+		host->clk_gated = false;
+		mmc_set_ios(host);
+	}
+}
+
+
 void mmc_set_ungated(struct mmc_host *host)
 {
 	unsigned long flags;
 
+	if (host->caps & MMC_CAP_HW_CLOCK_GATING)
+		return;
 	/*
 	 * We've been given a new frequency while the clock is gated,
 	 * so make sure we regard this as ungating it.
@@ -1487,6 +1512,7 @@ EXPORT_SYMBOL(mmc_set_blocklen);
 
 static int mmc_rescan_try_freq(struct mmc_host *host, unsigned freq)
 {
+	int ret;
 	host->f_init = freq;
 
 #ifdef CONFIG_MMC_DEBUG
@@ -1502,19 +1528,30 @@ static int mmc_rescan_try_freq(struct mmc_host *host, unsigned freq)
 	 */
 	sdio_reset(host);
 	mmc_go_idle(host);
+	mmc_hwungate_clock(host);
 
 	mmc_send_if_cond(host, host->ocr_avail);
 
 	/* Order's important: probe SDIO, then SD, then MMC */
 	if (!mmc_attach_sdio(host))
-		return 0;
-	if (!mmc_attach_sd(host))
-		return 0;
-	if (!mmc_attach_mmc(host))
-		return 0;
+		ret = 0;
+	else if (!mmc_attach_sd(host))
+		ret = 0;
+	else if (!mmc_attach_mmc(host))
+		ret = 0;
+	else
+		ret = -EIO;
 
-	mmc_power_off(host);
-	return -EIO;
+	if (ret == 0) {
+#ifdef CONFIG_MMC_CLKGATE
+		if (mmc_host_may_gate_card(host->card))
+			mmc_hwgate_clock(host);
+		else
+			mmc_hwungate_clock(host);
+#endif
+	} else
+		mmc_power_off(host);
+	return ret;
 }
 
 void mmc_rescan(struct work_struct *work)
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 20b1c08..091f8e0 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -35,6 +35,19 @@ void mmc_set_chip_select(struct mmc_host *host, int mode);
 void mmc_set_clock(struct mmc_host *host, unsigned int hz);
 void mmc_gate_clock(struct mmc_host *host);
 void mmc_ungate_clock(struct mmc_host *host);
+
+#ifdef CONFIG_MMC_CLKGATE
+void mmc_hwgate_clock(struct mmc_host *host);
+void mmc_hwungate_clock(struct mmc_host *host);
+#else
+static inline void mmc_hwgate_clock(struct mmc_host *host)
+{
+}
+
+static inline void mmc_hwungate_clock(struct mmc_host *host)
+{
+}
+#endif
 void mmc_set_ungated(struct mmc_host *host);
 void mmc_set_bus_mode(struct mmc_host *host, unsigned int mode);
 void mmc_set_bus_width(struct mmc_host *host, unsigned int width);
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 461e6a1..06396ca 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -130,6 +130,9 @@ void mmc_host_clk_ungate(struct mmc_host *host)
 {
 	unsigned long flags;
 
+	if (host->caps & MMC_CAP_HW_CLOCK_GATING)
+		return;
+
 	mutex_lock(&host->clk_gate_mutex);
 	spin_lock_irqsave(&host->clk_lock, flags);
 	if (host->clk_gated) {
@@ -147,7 +150,7 @@ void mmc_host_clk_ungate(struct mmc_host *host)
  *	mmc_host_may_gate_card - check if this card may be gated
  *	@card: card to check.
  */
-static bool mmc_host_may_gate_card(struct mmc_card *card)
+bool mmc_host_may_gate_card(struct mmc_card *card)
 {
 	/* If there is no card we may gate it */
 	if (!card)
@@ -175,6 +178,9 @@ void mmc_host_clk_gate(struct mmc_host *host)
 {
 	unsigned long flags;
 
+	if (host->caps & MMC_CAP_HW_CLOCK_GATING)
+		return;
+
 	spin_lock_irqsave(&host->clk_lock, flags);
 	host->clk_requests--;
 	if (mmc_host_may_gate_card(host->card) &&
@@ -195,7 +201,9 @@ unsigned int mmc_host_clk_rate(struct mmc_host *host)
 	unsigned long flags;
 
 	spin_lock_irqsave(&host->clk_lock, flags);
-	if (host->clk_gated)
+	if (host->caps & MMC_CAP_HW_CLOCK_GATING)
+		freq = host->ios.clock;
+	else if (host->clk_gated)
 		freq = host->clk_old;
 	else
 		freq = host->ios.clock;
@@ -209,6 +217,9 @@ unsigned int mmc_host_clk_rate(struct mmc_host *host)
  */
 static inline void mmc_host_clk_init(struct mmc_host *host)
 {
+	if (host->caps & MMC_CAP_HW_CLOCK_GATING)
+		return;
+
 	host->clk_requests = 0;
 	/* Hold MCI clock for 8 cycles by default */
 	host->clk_delay = 8;
@@ -224,6 +235,9 @@ static inline void mmc_host_clk_init(struct mmc_host *host)
  */
 static inline void mmc_host_clk_exit(struct mmc_host *host)
 {
+	if (host->caps & MMC_CAP_HW_CLOCK_GATING)
+		return;
+
 	/*
 	 * Wait for any outstanding gate and then make sure we're
 	 * ungated before exiting.
diff --git a/drivers/mmc/core/host.h b/drivers/mmc/core/host.h
index de199f9..db9d407 100644
--- a/drivers/mmc/core/host.h
+++ b/drivers/mmc/core/host.h
@@ -19,6 +19,7 @@ void mmc_unregister_host_class(void);
 void mmc_host_clk_ungate(struct mmc_host *host);
 void mmc_host_clk_gate(struct mmc_host *host);
 unsigned int mmc_host_clk_rate(struct mmc_host *host);
+bool mmc_host_may_gate_card(struct mmc_card *card);
 
 #else
 static inline void mmc_host_clk_ungate(struct mmc_host *host)
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index fb084c4..882ed2b 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1258,6 +1258,12 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	if (host->ops->platform_send_init_74_clocks)
 		host->ops->platform_send_init_74_clocks(host, ios->power_mode);
 
+ #ifdef CONFIG_MMC_CLKGATE
+	if ((mmc->caps & MMC_CAP_HW_CLOCK_GATING) &&
+		host->ops->platform_hw_clk_gate)
+		host->ops->platform_hw_clk_gate(host);
+#endif
+
 	/*
 	 * If your platform has 8-bit width support but is not a v3 controller,
 	 * or if it requires special setup code, you should implement that in
@@ -2003,6 +2009,15 @@ int sdhci_add_host(struct sdhci_host *host)
 	} else
 		mmc->f_max = host->max_clk;
 
+#ifdef CONFIG_MMC_CLKGATE
+	/*
+	 * Configure MMC_CAP_HW_CLOCK_GATING in platform code.
+	 * This is done to allow fine grain tuning of this parameter
+	 * as some host controllers may indicate h/w clock gating
+	 * works, but in fact does not.  Avoids need for a quirk.
+	 */
+#endif
+
 	mmc->caps |= MMC_CAP_SDIO_IRQ;
 
 	/*
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index d2fe13b..bbd6f6a 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -246,6 +246,7 @@ struct sdhci_ops {
 	unsigned int    (*set_signaling_voltage)(struct sdhci_host *host,
 				unsigned int ddr);
 	void	(*platform_specific_delay)(struct sdhci_host *host);
+	void	(*platform_hw_clk_gate)(struct sdhci_host *host);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 6edfb66..f5fc803 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -174,6 +174,7 @@ struct mmc_host {
 						/* DDR mode at 1.2V */
 #define MMC_CAP_POWER_OFF_CARD	(1 << 13)	/* Can power off after boot */
 #define MMC_CAP_BUS_WIDTH_TEST	(1 << 14)	/* CMD14/CMD19 bus width ok */
+#define MMC_CAP_HW_CLOCK_GATING	(1 << 15)	/* h/w supports clock gating */
 
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
 
-- 
1.7.0.4


