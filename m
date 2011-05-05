From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH 19/22] OMAP: hsmmc: implement clock switcher
Date: Thu,  5 May 2011 14:51:19 +0300
Message-ID: <1304596282-4095-20-git-send-email-adrian.hunter@nokia.com>
References: <1304596282-4095-1-git-send-email-adrian.hunter@nokia.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:63415 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753170Ab1EELwv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 5 May 2011 07:52:51 -0400
In-Reply-To: <1304596282-4095-1-git-send-email-adrian.hunter@nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Madhusudhan Chikkature <madhu.cr@ti.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Andy Shevchenko <ext-andriy.shevchenko@nokia.com>, Adrian Hunter <adrian.hunter@nokia.com>

From: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

There are 3 new platform data methods which should help us to do a clock
switching when notification is happened or request is started.

The purpose of the patch is to avoid high frequency of MMC controller on low
OPPs due to an HW bug in OMAP 3630.

The algorithm:
 - the PM governor switches the clock of L3 (and therefore L4) bus on demand
 - the MMC controller clock should follow the change

We have considered two OPPs for L3/L4 bus. Thus, we have corresponding flow:
 - OPP1 -> OPP2 (in case of abort - OPP1)
 - OPP2 -> OPP1 (in case of abort - OPP2)

During idle the MMC gates functional clock and we don't care about the
frequency. Most important to get proper solution when notification comes during
request. Then:
 - in case of OPP1 -> OPP2 we update frequency limit and it will be used for
   new coming requests (it assumes the current frequency of the controller is
   lower then new one)
 - otherwise we wait until no device has used higher frequency then upcoming
   one

Known issues and limitations:
 - originally a clock notifier was used for the core L4 iclk but for upstream
   Adrian changed to a cpufreq notifier where we assume OPP1 below 400MHz and
   OPP2 above 400MHz

Signed-off-by: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 arch/arm/mach-omap2/hsmmc.c           |  180 ++++++++++++++++++++++++++++++++-
 arch/arm/plat-omap/include/plat/mmc.h |    8 ++
 2 files changed, 187 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index 6b97fae..34cba89 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -10,10 +10,15 @@
  * published by the Free Software Foundation.
  */
 #include <linux/kernel.h>
+#include <linux/err.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/delay.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/mmc/card.h>
 #include <mach/hardware.h>
+#include <plat/clock.h>
 #include <plat/mmc.h>
 #include <plat/omap-pm.h>
 #include <plat/mux.h>
@@ -23,6 +28,8 @@
 #include "hsmmc.h"
 #include "control.h"
 
+#define HSMMC_MAX_FREQ	48000000
+
 #if defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
 
 static u16 control_pbias_offset;
@@ -203,6 +210,155 @@ static int nop_mmc_set_power(struct device *dev, int slot, int power_on,
 	return 0;
 }
 
+#ifdef CONFIG_ARCH_OMAP3
+static struct hsmmc_max_freq_info {
+	struct device *dev;
+	int freq;
+	int high_speed;
+} hsmmc_max_freq_info[OMAP34XX_NR_MMC];
+
+static unsigned int hsmmc_max_freq = HSMMC_MAX_FREQ;
+static DEFINE_SPINLOCK(hsmmc_max_freq_lock);
+
+static DECLARE_WAIT_QUEUE_HEAD(hsmmc_max_freq_wq);
+
+static int hsmmc_high_speed(struct device *dev)
+{
+	void *drvdata = platform_get_drvdata(to_platform_device(dev));
+	struct mmc_host *mmc = container_of(drvdata, struct mmc_host, private);
+
+	return mmc->card ? mmc_card_highspeed(mmc->card) : 0;
+}
+
+static unsigned int hsmmc_get_max_freq_hs(struct device *dev, int high_speed)
+{
+	return high_speed ? hsmmc_max_freq : hsmmc_max_freq >> 1;
+}
+
+static unsigned int hsmmc_get_max_freq(struct device *dev)
+{
+	return hsmmc_get_max_freq_hs(dev, hsmmc_high_speed(dev));
+}
+
+static unsigned int hsmmc_active(struct device *dev, unsigned int target_freq)
+{
+	int high_speed = hsmmc_high_speed(dev);
+	int i;
+	unsigned int max_freq, freq;
+	unsigned long flags;
+
+	spin_lock_irqsave(&hsmmc_max_freq_lock, flags);
+	max_freq = hsmmc_get_max_freq_hs(dev, high_speed);
+	freq = min(target_freq, max_freq);
+	for (i = 0; i < ARRAY_SIZE(hsmmc_max_freq_info); i++) {
+		if (!hsmmc_max_freq_info[i].dev) {
+			hsmmc_max_freq_info[i].dev = dev;
+			hsmmc_max_freq_info[i].freq = freq;
+			hsmmc_max_freq_info[i].high_speed = high_speed;
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&hsmmc_max_freq_lock, flags);
+	return freq;
+}
+
+static void hsmmc_inactive(struct device *dev)
+{
+	int i;
+	unsigned long flags;
+
+	spin_lock_irqsave(&hsmmc_max_freq_lock, flags);
+	for (i = 0; i < ARRAY_SIZE(hsmmc_max_freq_info); i++) {
+		if (hsmmc_max_freq_info[i].dev == dev) {
+			hsmmc_max_freq_info[i].dev = NULL;
+			spin_unlock_irqrestore(&hsmmc_max_freq_lock, flags);
+			/*
+			 * Wake up the queue only in case we deactivated a
+			 * device.
+			 */
+			wake_up(&hsmmc_max_freq_wq);
+			return;
+		}
+	}
+	spin_unlock_irqrestore(&hsmmc_max_freq_lock, flags);
+}
+
+static bool hsmmc_max_freq_ok(void)
+{
+	int i;
+	bool ret = true;
+	unsigned long flags;
+
+	spin_lock_irqsave(&hsmmc_max_freq_lock, flags);
+	for (i = 0; i < ARRAY_SIZE(hsmmc_max_freq_info); i++) {
+		if (hsmmc_max_freq_info[i].dev) {
+			unsigned int max_freq;
+
+			if (hsmmc_max_freq_info[i].high_speed)
+				max_freq = HSMMC_MAX_FREQ >> 1;
+			else
+				max_freq = HSMMC_MAX_FREQ >> 2;
+
+			if (hsmmc_max_freq_info[i].freq > max_freq) {
+				ret = false;
+				break;
+			}
+		}
+	}
+	spin_unlock_irqrestore(&hsmmc_max_freq_lock, flags);
+	return ret;
+}
+
+static int hsmmc_clk_notifier(struct notifier_block *nb, unsigned long event,
+			      void *data)
+{
+	struct cpufreq_freqs *freqs = data;
+	unsigned int threshold = 400000; /* between opp1 and opp2 */
+
+	switch (event) {
+	case CPUFREQ_PRECHANGE:
+		if (freqs->new < threshold && freqs->old > threshold) {
+			/* opp2 -> opp1 */
+			hsmmc_max_freq = HSMMC_MAX_FREQ >> 1;
+
+			/* Timeout is 1 sec */
+			if (!wait_event_timeout(hsmmc_max_freq_wq,
+						hsmmc_max_freq_ok(),
+						msecs_to_jiffies(1000)))
+				pr_err("MMC violates maximum frequency "
+				       "constraint\n");
+		}
+		break;
+	case CPUFREQ_POSTCHANGE:
+		if (freqs->old < threshold && freqs->new > threshold) {
+			/* opp1 -> opp2 */
+			hsmmc_max_freq = HSMMC_MAX_FREQ;
+		}
+		break;
+	default:
+		break;
+	}
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block hsmmc_notifier_block = {
+	.notifier_call	= hsmmc_clk_notifier,
+	.priority	= INT_MAX,
+};
+
+static int __init hsmmc_init_notifier(void)
+{
+	return cpufreq_register_notifier(&hsmmc_notifier_block,
+					 CPUFREQ_TRANSITION_NOTIFIER);
+}
+#else
+static inline int hsmmc_init_notifier(void)
+{
+	return 0;
+}
+#endif
+
 static inline void omap_hsmmc_mux(struct omap_mmc_platform_data *mmc_controller,
 			int controller_nr)
 {
@@ -401,6 +557,17 @@ static int __init omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c,
 		kfree(hc_name);
 		return -ENODEV;
 	}
+
+	/*
+	 * The 3630's host controller cannot guarantee setup times at all
+	 * frequencies, so notification and control of frequency changes
+	 * is necessary.
+	 */
+	if (cpu_is_omap3630()) {
+		mmc->get_max_freq = hsmmc_get_max_freq;
+		mmc->active = hsmmc_active;
+		mmc->inactive = hsmmc_inactive;
+	}
 	return 0;
 }
 
@@ -507,9 +674,20 @@ void __init omap2_hsmmc_init(struct omap2_hsmmc_info *controllers)
 		omap4_ctrl_pad_writel(reg, control_mmc1);
 	}
 
+	/*
+	 * The 3630's host controller cannot guarantee setup times at all
+	 * frequencies, so notification and control of frequency changes
+	 * is necessary.
+	 */
+	if (cpu_is_omap3630()) {
+		if (hsmmc_init_notifier()) {
+			pr_err("Can't setup clock notifier for mmc driver!\n");
+			return;
+		}
+	}
+
 	for (; controllers->mmc; controllers++)
 		omap_init_hsmmc(controllers, controllers->mmc);
-
 }
 
 #endif
diff --git a/arch/arm/plat-omap/include/plat/mmc.h b/arch/arm/plat-omap/include/plat/mmc.h
index f38fef9..e3c9b20 100644
--- a/arch/arm/plat-omap/include/plat/mmc.h
+++ b/arch/arm/plat-omap/include/plat/mmc.h
@@ -27,6 +27,8 @@
 #define OMAP2420_MMC_SIZE	OMAP1_MMC_SIZE
 #define OMAP2_MMC1_BASE		0x4809c000
 
+#define OMAP34XX_NR_MMC		3
+
 #define OMAP4_MMC_REG_OFFSET	0x100
 
 #define OMAP_MMC_MAX_SLOTS	2
@@ -63,6 +65,12 @@ struct omap_mmc_platform_data {
 	/* Return context loss count due to PM states changing */
 	int (*get_context_loss_count)(struct device *dev);
 
+	/* Return max controller frequency for current OPP */
+	unsigned int (*get_max_freq)(struct device *dev);
+
+	unsigned int (*active)(struct device *dev, unsigned int target_freq);
+	void (*inactive)(struct device *dev);
+
 	u64 dma_mask;
 
 	/* Integrating attributes from the omap_hwmod layer */
-- 
1.7.0.4

