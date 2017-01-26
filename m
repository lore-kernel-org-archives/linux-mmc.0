From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v4 2/13] mmc: sunxi: Gate the clock when rate is 0
Date: Thu, 26 Jan 2017 10:05:55 +0100
Message-ID: <fa9886d81af2415a6b83e9ff68bb5ebd430d4425.1485421557.git-series.maxime.ripard@free-electrons.com>
References: <cover.8d42a39b7bd5143e709979dc42cc47862ebe3728.1485421557.git-series.maxime.ripard@free-electrons.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.8d42a39b7bd5143e709979dc42cc47862ebe3728.1485421557.git-series.maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
In-Reply-To: <cover.8d42a39b7bd5143e709979dc42cc47862ebe3728.1485421557.git-series.maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
References: <cover.8d42a39b7bd5143e709979dc42cc47862ebe3728.1485421557.git-series.maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

The MMC core assumes that the code will gate the clock when the bus
frequency is set to 0, which we've been ignoring so far.

Handle that.

Signed-off-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 drivers/mmc/host/sunxi-mmc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index ab4324e6eb74..019f95e8e7c5 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -765,6 +765,9 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
 	if (ret)
 		return ret;
 
+	if (!ios->clock)
+		return 0;
+
 	/* 8 bit DDR requires a higher module clock */
 	if (ios->timing == MMC_TIMING_MMC_DDR52 &&
 	    ios->bus_width == MMC_BUS_WIDTH_8)
@@ -882,7 +885,7 @@ static void sunxi_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	mmc_writel(host, REG_GCTRL, rval);
 
 	/* set up clock */
-	if (ios->clock && ios->power_mode) {
+	if (ios->power_mode) {
 		host->ferror = sunxi_mmc_clk_set_rate(host, ios);
 		/* Android code had a usleep_range(50000, 55000); here */
 	}
-- 
git-series 0.8.11
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
