From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: [PATCH 2/3] mmc: sunxi: Support 8 bit eMMC DDR transfer modes
Date: Sat, 30 Jan 2016 01:21:47 +0800
Message-ID: <1454088108-2332-3-git-send-email-wens@csie.org>
References: <1454088108-2332-1-git-send-email-wens@csie.org>
Reply-To: wens-jdAy2FN1RRM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCMILY6JWQBBBTV7V22QKGQEYCK2TMQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1454088108-2332-1-git-send-email-wens-jdAy2FN1RRM@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Allwinner's MMC controller needs to run at double the card clock rate
for 8 bit DDR transfer modes. Interestingly, this is not needed for
4 bit DDR transfers.

Different clock delays are needed for 8 bit eMMC DDR, due to the
increased module clock rate. For the A80 though, the same values for
4 bit and 8 bit are shared. The new values for the other SoCs were from
A83T user manual's "new timing mode" default values, which describes
them in clock phase, rather than delay periods. These values were used
without any modification. They may not be correct, but they work.

Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
---
 drivers/mmc/host/sunxi-mmc.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index fe6c171fd135..bb4592696046 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -215,6 +215,7 @@
 #define SDXC_CLK_25M		1
 #define SDXC_CLK_50M		2
 #define SDXC_CLK_50M_DDR	3
+#define SDXC_CLK_50M_DDR_8BIT	4
 
 struct sunxi_mmc_clk_delay {
 	u32 output;
@@ -656,11 +657,17 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
 				  struct mmc_ios *ios)
 {
 	u32 rate, oclk_dly, rval, sclk_dly;
+	u32 clock = ios->clock;
 	int ret;
 
-	rate = clk_round_rate(host->clk_mmc, ios->clock);
+	/* 8 bit DDR requires a higher module clock */
+	if (ios->timing == MMC_TIMING_MMC_DDR52 &&
+	    ios->bus_width == MMC_BUS_WIDTH_8)
+		clock <<= 1;
+
+	rate = clk_round_rate(host->clk_mmc, clock);
 	dev_dbg(mmc_dev(host->mmc), "setting clk to %d, rounded %d\n",
-		ios->clock, rate);
+		clock, rate);
 
 	/* setting clock rate */
 	ret = clk_set_rate(host->clk_mmc, rate);
@@ -677,6 +684,12 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
 	/* clear internal divider */
 	rval = mmc_readl(host, REG_CLKCR);
 	rval &= ~0xff;
+	/* set internal divider for 8 bit eMMC DDR, so card clock is right */
+	if (ios->timing == MMC_TIMING_MMC_DDR52 &&
+	    ios->bus_width == MMC_BUS_WIDTH_8) {
+		rval |= 1;
+		rate >>= 1;
+	}
 	mmc_writel(host, REG_CLKCR, rval);
 
 	/* determine delays */
@@ -687,13 +700,16 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
 		oclk_dly = host->clk_delays[SDXC_CLK_25M].output;
 		sclk_dly = host->clk_delays[SDXC_CLK_25M].sample;
 	} else if (rate <= 52000000) {
-		if (ios->timing == MMC_TIMING_UHS_DDR50 ||
-		    ios->timing == MMC_TIMING_MMC_DDR52) {
-			oclk_dly = host->clk_delays[SDXC_CLK_50M_DDR].output;
-			sclk_dly = host->clk_delays[SDXC_CLK_50M_DDR].sample;
-		} else {
+		if (ios->timing != MMC_TIMING_UHS_DDR50 &&
+		    ios->timing != MMC_TIMING_MMC_DDR52) {
 			oclk_dly = host->clk_delays[SDXC_CLK_50M].output;
 			sclk_dly = host->clk_delays[SDXC_CLK_50M].sample;
+		} else if (ios->bus_width == MMC_BUS_WIDTH_8) {
+			oclk_dly = host->clk_delays[SDXC_CLK_50M_DDR_8BIT].output;
+			sclk_dly = host->clk_delays[SDXC_CLK_50M_DDR_8BIT].sample;
+		} else {
+			oclk_dly = host->clk_delays[SDXC_CLK_50M_DDR].output;
+			sclk_dly = host->clk_delays[SDXC_CLK_50M_DDR].sample;
 		}
 	} else {
 		return -EINVAL;
@@ -951,6 +967,8 @@ static const struct sunxi_mmc_clk_delay sunxi_mmc_clk_delays[] = {
 	[SDXC_CLK_25M]		= { .output = 180, .sample =  75 },
 	[SDXC_CLK_50M]		= { .output =  90, .sample = 120 },
 	[SDXC_CLK_50M_DDR]	= { .output =  60, .sample = 120 },
+	/* Value from A83T "new timing mode". Works but might not be right. */
+	[SDXC_CLK_50M_DDR_8BIT]	= { .output =  90, .sample = 180 },
 };
 
 static const struct sunxi_mmc_clk_delay sun9i_mmc_clk_delays[] = {
@@ -958,6 +976,7 @@ static const struct sunxi_mmc_clk_delay sun9i_mmc_clk_delays[] = {
 	[SDXC_CLK_25M]		= { .output = 180, .sample =  75 },
 	[SDXC_CLK_50M]		= { .output = 150, .sample = 120 },
 	[SDXC_CLK_50M_DDR]	= { .output =  90, .sample = 120 },
+	[SDXC_CLK_50M_DDR_8BIT]	= { .output =  90, .sample = 120 },
 };
 
 static int sunxi_mmc_resource_request(struct sunxi_mmc_host *host,
-- 
2.7.0
