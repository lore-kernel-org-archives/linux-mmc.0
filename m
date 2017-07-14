From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: [PATCH 05/11] mmc: sunxi: Support controllers that can
 use both old and new timings
Date: Fri, 14 Jul 2017 14:42:56 +0800
Message-ID: <20170714064302.20383-6-wens@csie.org>
References: <20170714064302.20383-1-wens@csie.org>
Reply-To: wens-jdAy2FN1RRM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCMILY6JWQBBBAGQUHFQKGQEUQXGA5A-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20170714064302.20383-1-wens-jdAy2FN1RRM@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On the SoCs that introduced the new timing mode for MMC controllers,
both the old (where the clock delays are set in the CCU) and new
(where the clock delays are set in the MMC controller) timing modes
are available, and we have to support them both. However there are
two bits that control which mode is active. One is in the CCU, the
other is in the MMC controller. The settings on both sides must be
the same, or nothing will work.

The CCU's get/set_phase callbacks return -ENOTSUPP when the new
timing mode is active. This provides a way to know which mode is
active on that side, and we can set the bit on the MMC controller
side accordingly.

Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
---
 drivers/mmc/host/sunxi-mmc.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 0fb4e4c119e1..56e45c65b52d 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -22,6 +22,7 @@
 #include <linux/err.h>
 
 #include <linux/clk.h>
+#include <linux/clk/sunxi-ng.h>
 #include <linux/gpio.h>
 #include <linux/platform_device.h>
 #include <linux/spinlock.h>
@@ -259,7 +260,7 @@ struct sunxi_mmc_cfg {
 	/* Does DATA0 needs to be masked while the clock is updated */
 	bool mask_data0;
 
-	bool needs_new_timings;
+	bool has_new_timings;
 };
 
 struct sunxi_mmc_host {
@@ -293,6 +294,9 @@ struct sunxi_mmc_host {
 
 	/* vqmmc */
 	bool		vqmmc_enabled;
+
+	/* timings */
+	bool		use_new_timings;
 };
 
 static int sunxi_mmc_reset_host(struct sunxi_mmc_host *host)
@@ -714,7 +718,7 @@ static int sunxi_mmc_clk_set_phase(struct sunxi_mmc_host *host,
 {
 	int index;
 
-	if (!host->cfg->clk_delays)
+	if (host->use_new_timings)
 		return 0;
 
 	/* determine delays */
@@ -765,6 +769,15 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
 	    ios->bus_width == MMC_BUS_WIDTH_8)
 		clock <<= 1;
 
+	if (host->use_new_timings) {
+		ret = sunxi_ccu_set_mmc_timing_mode(host->clk_mmc, true);
+		if (ret) {
+			dev_err(mmc_dev(mmc),
+				"error setting new timing mode\n");
+			return ret;
+		}
+	}
+
 	rate = clk_round_rate(host->clk_mmc, clock);
 	if (rate < 0) {
 		dev_err(mmc_dev(mmc), "error rounding clk to %d: %ld\n",
@@ -793,7 +806,7 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
 	}
 	mmc_writel(host, REG_CLKCR, rval);
 
-	if (host->cfg->needs_new_timings) {
+	if (host->use_new_timings) {
 		/* Don't touch the delay bits */
 		rval = mmc_readl(host, REG_SD_NTSR);
 		rval |= SDXC_2X_TIMING_MODE;
@@ -1105,7 +1118,7 @@ static const struct sunxi_mmc_cfg sun50i_a64_cfg = {
 	.clk_delays = NULL,
 	.can_calibrate = true,
 	.mask_data0 = true,
-	.needs_new_timings = true,
+	.has_new_timings = true,
 };
 
 static const struct sunxi_mmc_cfg sun50i_a64_emmc_cfg = {
@@ -1262,6 +1275,19 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
 		goto error_free_host;
 	}
 
+	if (host->cfg->clk_delays && host->cfg->has_new_timings) {
+		/*
+		 * Supports both old and new timing modes.
+		 * Try setting the clk to new timing mode.
+		 */
+		ret = sunxi_ccu_set_mmc_timing_mode(host->clk_mmc, true);
+		if (!ret)
+			host->use_new_timings = true;
+	} else if (host->cfg->has_new_timings) {
+		/* Supports new timing mode only */
+		host->use_new_timings = true;
+	}
+
 	mmc->ops		= &sunxi_mmc_ops;
 	mmc->max_blk_count	= 8192;
 	mmc->max_blk_size	= 4096;
-- 
2.13.2
