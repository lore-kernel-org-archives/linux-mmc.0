From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH V3 1/3 ] mmc: add support for H/W clock gating of SD
 controller
Date: Tue, 7 Dec 2010 14:46:25 -0800
Message-ID: <5017B261-76AC-428D-BAC2-8E1BBEB09A49@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:50814 "HELO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751271Ab0LGWtT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 7 Dec 2010 17:49:19 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Nicolas Pitre <nico@fluxnic.net>, Mark Brown <markb@marvell.com>, Chris Ball <cjb@laptop.org>


Revised based on Nico comments.

8 bit width support dependency removed.  Code applies directly to mmc-next
Patches 2/3 and 3/3 unchanged

>From fd6b01ae41eaf3d26755bb263f7af59a029c5d83 Mon Sep 17 00:00:00 2001
From: Philip Rakity <prakity@marvell.com>
Date: Tue, 7 Dec 2010 08:58:56 -0800
Subject: [PATCH] mmc: add support for H/W clock gating of SD controller

This code extends software clock gating in the MMC layer by adding the ability
to indicate that the SD controller supports hardware clock gating.

Hardware clock gating is enabled by setting the MMC capability
MMC_CAP_HW_CLOCK_GATING in the SD driver.

eg: host->mmc->caps |= MMC_CAP_HW_CLOCK_GATING

The approach follows the suggestion of Nico Pitre.

SD/MMC/eMMC cards use dynamic clocks
SDIO uses continuous clocks to properly detect SDIO card interrupts

The code has been tested using marvell linux for MMP2.  The Marvell
controller support H/W clock gating.

Signed-off-by: Philip Rakity <prakity@marvell.com>
Signed-off-by: Mark F. Brown <markb@marvell.com>
---
 drivers/mmc/core/core.c  |   32 ++++++++++++++++++++++++++++++++
 drivers/mmc/core/core.h  |   13 +++++++++++++
 drivers/mmc/core/host.c  |   12 ++++++++++++
 include/linux/mmc/host.h |    1 +
 4 files changed, 58 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 6286898..de867d1 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -682,6 +682,28 @@ void mmc_ungate_clock(struct mmc_host *host)
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
 void mmc_set_ungated(struct mmc_host *host)
 {
 	unsigned long flags;
@@ -1548,6 +1570,8 @@ void mmc_rescan(struct work_struct *work)
 			mmc_hostname(host), __func__, host->f_init);
 #endif
 		mmc_power_up(host);
+
+		mmc_hwungate_clock(host);
 		sdio_reset(host);
 		mmc_go_idle(host);
 
@@ -1569,6 +1593,10 @@ void mmc_rescan(struct work_struct *work)
 
 				if (mmc_attach_sd(host, ocr))
 					mmc_power_off(host);
+
+				/* hw clock gating is off when we get here */
+				/* do not enable clock gating for sdio cards */
+				/* sdio cards can miss interrupts */
 			}
 			goto out;
 		}
@@ -1580,6 +1608,8 @@ void mmc_rescan(struct work_struct *work)
 		if (!err) {
 			if (mmc_attach_sd(host, ocr))
 				mmc_power_off(host);
+			else
+				mmc_hwgate_clock(host);
 			goto out;
 		}
 
@@ -1590,6 +1620,8 @@ void mmc_rescan(struct work_struct *work)
 		if (!err) {
 			if (mmc_attach_mmc(host, ocr))
 				mmc_power_off(host);
+			else
+				mmc_hwgate_clock(host);
 			goto out;
 		}
 
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 026c975..3810e28 100644
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
index 92e3370..f4b4c2f 100644
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
@@ -178,6 +181,9 @@ void mmc_host_clk_gate(struct mmc_host *host)
 {
 	unsigned long flags;
 
+	if (host->caps & MMC_CAP_HW_CLOCK_GATING)
+		return;
+
 	spin_lock_irqsave(&host->clk_lock, flags);
 	host->clk_requests--;
 	if (mmc_host_may_gate_card(host->card) &&
@@ -212,6 +218,9 @@ unsigned int mmc_host_clk_rate(struct mmc_host *host)
  */
 static inline void mmc_host_clk_init(struct mmc_host *host)
 {
+	if (host->caps & MMC_CAP_HW_CLOCK_GATING)
+		return;
+
 	host->clk_requests = 0;
 	/* Hold MCI clock for 8 cycles by default */
 	host->clk_delay = 8;
@@ -231,6 +240,9 @@ static inline void mmc_host_clk_exit(struct mmc_host *host)
 	 * Wait for any outstanding gate and then make sure we're
 	 * ungated before exiting.
 	 */
+	if (host->caps & MMC_CAP_HW_CLOCK_GATING)
+		return;
+
 	if (cancel_work_sync(&host->clk_gate_work))
 		mmc_host_clk_gate_delayed(host);
 	if (host->clk_gated)
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 381c77f..b9b3a2b 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -169,6 +169,7 @@ struct mmc_host {
 #define MMC_CAP_1_2V_DDR	(1 << 12)	/* can support */
 						/* DDR mode at 1.2V */
 #define MMC_CAP_POWER_OFF_CARD	(1 << 13)	/* Can power off after boot */
+#define MMC_CAP_HW_CLOCK_GATING	(1 << 14)	/* h/w supports clock gating */
 
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
 
-- 
1.6.0.4

