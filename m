From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH 4/8] omap_hsmmc: set DVFS/PM constraints
Date: Wed, 13 Jan 2010 13:40:41 +0200
Message-ID: <20100113114041.7615.830.sendpatchset@ahunter-work.research.nokia.com>
References: <20100113114010.7615.84920.sendpatchset@ahunter-work.research.nokia.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:51172 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755610Ab0AMLk5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jan 2010 06:40:57 -0500
In-Reply-To: <20100113114010.7615.84920.sendpatchset@ahunter-work.research.nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-mmc Mailing List <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@nokia.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Madhusudhan Chikkature <madhu.cr@ti.com>

>From afab8b432b37ae1f42b281e58989c8d607ed7183 Mon Sep 17 00:00:00 2001
From: Denis Karpov <ext-denis.2.karpov@nokia.com>
Date: Wed, 8 Jul 2009 16:15:08 +0200
Subject: [PATCH] omap_hsmmc: set DVFS/PM constraints

Set constraint for MPU minimal frequency to maintain good
I/O performance.

The constraint is set in MMC host 'ENABLED' state and dropped
when MMC host enters 'DISABLED' state which currently happens
upon 100ms of inactivity.

Signed-off-by: Denis Karpov <ext-denis.2.karpov@nokia.com>
Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |   18 ++++++++++++++++++
 arch/arm/mach-omap2/hsmmc.c                  |    2 ++
 arch/arm/mach-omap2/hsmmc.h                  |    2 ++
 arch/arm/plat-omap/include/plat/mmc.h        |    3 +++
 drivers/mmc/host/omap_hsmmc.c                |   17 +++++++++++++++++
 5 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index ab07ca2..b6318b1 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -209,6 +209,22 @@ static struct twl4030_madc_platform_data rx51_madc_data = {
 	.irq_line		= 1,
 };
 
+#if defined(CONFIG_BRIDGE_DVFS)
+/*
+ * This handler can be used for setting other DVFS/PM constraints:
+ * intr latency, wakeup latency, DMA start latency, bus throughput
+ * according to API in mach/omap-pm.h.  Currently we only set constraints
+ * for MPU frequency.
+ */
+#define MMC_MIN_MPU_FREQUENCY	500000000	/* S500M at OPP3 */
+static void rx51_mmc_set_pm_constraints(struct device *dev, int on)
+{
+	omap_pm_set_min_mpu_freq(dev, (on ? MMC_MIN_MPU_FREQUENCY : 0));
+}
+#else
+#define rx51_mmc_set_pm_constraints NULL
+#endif
+
 static struct omap2_hsmmc_info mmc[] __initdata = {
 	{
 		.name		= "external",
@@ -218,6 +234,7 @@ static struct omap2_hsmmc_info mmc[] __initdata = {
 		.gpio_cd	= 160,
 		.gpio_wp	= -EINVAL,
 		.power_saving	= true,
+		.set_pm_constraints = rx51_mmc_set_pm_constraints,
 	},
 	{
 		.name		= "internal",
@@ -227,6 +244,7 @@ static struct omap2_hsmmc_info mmc[] __initdata = {
 		.gpio_wp	= -EINVAL,
 		.nonremovable	= true,
 		.power_saving	= true,
+		.set_pm_constraints = rx51_mmc_set_pm_constraints,
 	},
 	{}	/* Terminator */
 };
diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index 76a1f6c..1211d15 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -76,6 +76,8 @@ void __init omap2_hsmmc_init(struct omap2_hsmmc_info *controllers)
 
 		mmc->get_context_loss_count = hsmmc_get_context_loss;
 
+		mmc->set_pm_constraints = c->set_pm_constraints;
+
 		mmc->slots[0].switch_pin = c->gpio_cd;
 		mmc->slots[0].gpio_wp = c->gpio_wp;
 
diff --git a/arch/arm/mach-omap2/hsmmc.h b/arch/arm/mach-omap2/hsmmc.h
index e946b5f..ad437f3 100644
--- a/arch/arm/mach-omap2/hsmmc.h
+++ b/arch/arm/mach-omap2/hsmmc.h
@@ -19,6 +19,8 @@ struct omap2_hsmmc_info {
 	char	*name;		/* or NULL for default */
 	struct device *dev;	/* returned: pointer to mmc adapter */
 	int	ocr_mask;	/* temporary HACK */
+	/* Set/drop DVFS/PM constraints */
+	void (*set_pm_constraints)(struct device *dev, int on);
 };
 
 #if defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
diff --git a/arch/arm/plat-omap/include/plat/mmc.h b/arch/arm/plat-omap/include/plat/mmc.h
index 6af87b0..c3e0c34 100644
--- a/arch/arm/plat-omap/include/plat/mmc.h
+++ b/arch/arm/plat-omap/include/plat/mmc.h
@@ -69,6 +69,9 @@ struct omap_mmc_platform_data {
 	/* Return context loss count due to PM states changing */
 	int (*get_context_loss_count)(struct device *dev);
 
+	/* Set/drop DVFS/PM constraints */
+	void (*set_pm_constraints)(struct device *dev, int on);
+
 	u64 dma_mask;
 
 	struct omap_mmc_slot_data {
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 63d24df..e2f63a5 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1677,7 +1677,13 @@ enum {ENABLED = 0, DISABLED, CARDSLEEP, REGSLEEP, OFF};
 static int omap_hsmmc_enabled_to_disabled(struct omap_hsmmc_host *host)
 {
 	omap_hsmmc_context_save(host);
+
 	clk_disable(host->fclk);
+
+	/* Drop PM/DVFS constraints */
+	if (host->pdata->set_pm_constraints)
+		host->pdata->set_pm_constraints(host->dev, 0);
+
 	host->dpm_state = DISABLED;
 
 	dev_dbg(mmc_dev(host->mmc), "ENABLED -> DISABLED\n");
@@ -1768,6 +1774,10 @@ static int omap_hsmmc_disabled_to_enabled(struct omap_hsmmc_host *host)
 		return err;
 
 	omap_hsmmc_context_restore(host);
+
+	if (host->pdata->set_pm_constraints)
+		host->pdata->set_pm_constraints(host->dev, 1);
+
 	host->dpm_state = ENABLED;
 
 	dev_dbg(mmc_dev(host->mmc), "DISABLED -> ENABLED\n");
@@ -1792,6 +1802,9 @@ static int omap_hsmmc_sleep_to_enabled(struct omap_hsmmc_host *host)
 	dev_dbg(mmc_dev(host->mmc), "%s -> ENABLED\n",
 		host->dpm_state == CARDSLEEP ? "CARDSLEEP" : "REGSLEEP");
 
+	if (host->pdata->set_pm_constraints)
+		host->pdata->set_pm_constraints(host->dev, 1);
+
 	host->dpm_state = ENABLED;
 
 	mmc_release_host(host->mmc);
@@ -1808,6 +1821,9 @@ static int omap_hsmmc_off_to_enabled(struct omap_hsmmc_host *host)
 	omap_hsmmc_conf_bus_power(host);
 	mmc_power_restore_host(host->mmc);
 
+	if (host->pdata->set_pm_constraints)
+		host->pdata->set_pm_constraints(host->dev, 1);
+
 	host->dpm_state = ENABLED;
 
 	dev_dbg(mmc_dev(host->mmc), "OFF -> ENABLED\n");
@@ -1834,6 +1850,7 @@ static int omap_hsmmc_enable(struct mmc_host *mmc)
 		dev_dbg(mmc_dev(host->mmc), "UNKNOWN state\n");
 		return -EINVAL;
 	}
+
 }
 
 /*
-- 
1.6.0.4

