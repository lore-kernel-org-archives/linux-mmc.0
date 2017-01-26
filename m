From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v4 7/13] mmc: sunxi: Add more debug informations
Date: Thu, 26 Jan 2017 10:06:00 +0100
Message-ID: <97cb930c7287da4db2948f2da8e69484dc7cc2e9.1485421557.git-series.maxime.ripard@free-electrons.com>
References: <cover.8d42a39b7bd5143e709979dc42cc47862ebe3728.1485421557.git-series.maxime.ripard@free-electrons.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.8d42a39b7bd5143e709979dc42cc47862ebe3728.1485421557.git-series.maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
In-Reply-To: <cover.8d42a39b7bd5143e709979dc42cc47862ebe3728.1485421557.git-series.maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
References: <cover.8d42a39b7bd5143e709979dc42cc47862ebe3728.1485421557.git-series.maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Add a bit more debug messages that can be helpful when debugging the clock
setup.

Also fill the actual_clock field in struct mmc_host to report properly the
current frequency in debugfs.

Signed-off-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 drivers/mmc/host/sunxi-mmc.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index f0f6922bca8a..6ffcd2838272 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -661,6 +661,9 @@ static int sunxi_mmc_oclk_onoff(struct sunxi_mmc_host *host, u32 oclk_en)
 	unsigned long expire = jiffies + msecs_to_jiffies(750);
 	u32 rval;
 
+	dev_dbg(mmc_dev(host->mmc), "%sabling the clock\n",
+		oclk_en ? "en" : "dis");
+
 	rval = mmc_readl(host, REG_CLKCR);
 	rval &= ~(SDXC_CARD_CLOCK_ON | SDXC_LOW_POWER_ON | SDXC_MASK_DATA0);
 
@@ -737,6 +740,7 @@ static int sunxi_mmc_clk_set_phase(struct sunxi_mmc_host *host,
 			index = SDXC_CLK_50M_DDR;
 		}
 	} else {
+		dev_dbg(mmc_dev(host->mmc), "Invalid clock... returning\n");
 		return -EINVAL;
 	}
 
@@ -749,6 +753,7 @@ static int sunxi_mmc_clk_set_phase(struct sunxi_mmc_host *host,
 static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
 				  struct mmc_ios *ios)
 {
+	struct mmc_host *mmc = host->mmc;
 	long rate;
 	u32 rval, clock = ios->clock;
 	int ret;
@@ -757,6 +762,9 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
 	if (ret)
 		return ret;
 
+	/* Our clock is gated now */
+	mmc->actual_clock = 0;
+
 	if (!ios->clock)
 		return 0;
 
@@ -767,17 +775,17 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
 
 	rate = clk_round_rate(host->clk_mmc, clock);
 	if (rate < 0) {
-		dev_err(mmc_dev(host->mmc), "error rounding clk to %d: %ld\n",
+		dev_err(mmc_dev(mmc), "error rounding clk to %d: %ld\n",
 			clock, rate);
 		return rate;
 	}
-	dev_dbg(mmc_dev(host->mmc), "setting clk to %d, rounded %ld\n",
+	dev_dbg(mmc_dev(mmc), "setting clk to %d, rounded %ld\n",
 		clock, rate);
 
 	/* setting clock rate */
 	ret = clk_set_rate(host->clk_mmc, rate);
 	if (ret) {
-		dev_err(mmc_dev(host->mmc), "error setting clk to %ld: %d\n",
+		dev_err(mmc_dev(mmc), "error setting clk to %ld: %d\n",
 			rate, ret);
 		return ret;
 	}
@@ -812,7 +820,14 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
 	 * least on the A64).
 	 */
 
-	return sunxi_mmc_oclk_onoff(host, 1);
+	ret = sunxi_mmc_oclk_onoff(host, 1);
+	if (ret)
+		return ret;
+
+	/* And we just enabled our clock back */
+	mmc->actual_clock = rate;
+
+	return 0;
 }
 
 static void sunxi_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
-- 
git-series 0.8.11
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
