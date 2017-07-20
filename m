From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: [PATCH v2 05/10] mmc: sunxi: Support MMC DDR52 transfer
 mode with new timing mode
Date: Thu, 20 Jul 2017 11:44:47 +0800
Message-ID: <20170720034452.15920-6-wens@csie.org>
References: <20170720034452.15920-1-wens@csie.org>
Reply-To: wens-jdAy2FN1RRM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCMILY6JWQBBBOOOYDFQKGQEJQQDP3I-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20170720034452.15920-1-wens-jdAy2FN1RRM@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

The MMC controller can support DDR52 transfers under the new timing
mode. According to the BSP kernel, the module clock has to be double
the card clock, regardless of the bus width. The default timings in
the hardware can be used.

This also reworks the code setting the internal divider, getting rid
of a extra conditional.

Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
---
 drivers/mmc/host/sunxi-mmc.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index c8a60e43dc43..11587a69a1fd 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -755,7 +755,7 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
 {
 	struct mmc_host *mmc = host->mmc;
 	long rate;
-	u32 rval, clock = ios->clock;
+	u32 rval, clock = ios->clock, div = 1;
 	int ret;
 
 	ret = sunxi_mmc_oclk_onoff(host, 0);
@@ -768,10 +768,21 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
 	if (!ios->clock)
 		return 0;
 
-	/* 8 bit DDR requires a higher module clock */
+	/*
+	 * Under the old timing mode, 8 bit DDR requires the module
+	 * clock to be double the card clock. Under the new timing
+	 * mode, all DDR modes require a doubled module clock.
+	 *
+	 * We currently only support the standard MMC DDR52 mode.
+	 * This block should be updated once support for other DDR
+	 * modes is added.
+	 */
 	if (ios->timing == MMC_TIMING_MMC_DDR52 &&
-	    ios->bus_width == MMC_BUS_WIDTH_8)
+	    (host->use_new_timings ||
+	     ios->bus_width == MMC_BUS_WIDTH_8)) {
+		div = 2;
 		clock <<= 1;
+	}
 
 	if (host->use_new_timings) {
 		ret = sunxi_ccu_set_mmc_timing_mode(host->clk_mmc, true);
@@ -799,15 +810,10 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
 		return ret;
 	}
 
-	/* clear internal divider */
+	/* set internal divider */
 	rval = mmc_readl(host, REG_CLKCR);
 	rval &= ~0xff;
-	/* set internal divider for 8 bit eMMC DDR, so card clock is right */
-	if (ios->timing == MMC_TIMING_MMC_DDR52 &&
-	    ios->bus_width == MMC_BUS_WIDTH_8) {
-		rval |= 1;
-		rate >>= 1;
-	}
+	rval |= div - 1;
 	mmc_writel(host, REG_CLKCR, rval);
 
 	if (host->use_new_timings) {
@@ -838,7 +844,7 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
 		return ret;
 
 	/* And we just enabled our clock back */
-	mmc->actual_clock = rate;
+	mmc->actual_clock = rate / div;
 
 	return 0;
 }
@@ -1315,7 +1321,7 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
 	mmc->caps	       |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
 				  MMC_CAP_ERASE | MMC_CAP_SDIO_IRQ;
 
-	if (host->cfg->clk_delays)
+	if (host->cfg->clk_delays || host->use_new_timings)
 		mmc->caps      |= MMC_CAP_1_8V_DDR;
 
 	ret = mmc_of_parse(mmc);
-- 
2.13.2
