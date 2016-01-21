From: Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH RFC 06/15] mmc: sunxi: Support 8 bit eMMC DDR transfer modes
Date: Thu, 21 Jan 2016 13:26:33 +0800
Message-ID: <1453354002-28366-7-git-send-email-wens@csie.org>
References: <1453354002-28366-1-git-send-email-wens@csie.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:54938 "EHLO
	smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933046AbcAUFdl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Jan 2016 00:33:41 -0500
In-Reply-To: <1453354002-28366-1-git-send-email-wens@csie.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Hans de Goede <hdegoede@redhat.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com

Allwinner's MMC controller needs to run at double the card clock rate
for 8 bit DDR transfer modes. Interestingly, this is not needed for
4 bit DDR transfers.

Different clock delays are needed for 8 bit eMMC DDR, due to the
increased module clock rate. For the A80 though, the same values for
4 bit and 8 bit are shared. The new values for the other SoCs were from
A83T user manual's "new timing mode" default values, which describes
them in clock phase, rather than delay periods. These values were used
without any modification. They may not be correct, but they work.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/mmc/host/sunxi-mmc.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index b403a2433eec..d05928091b34 100644
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
 	} else if (rate <= 50000000) {
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
@@ -965,6 +981,8 @@ static const struct sunxi_mmc_clk_delay sunxi_mmc_clk_delays[] = {
 	[SDXC_CLK_25M]		= { .output = 180, .sample =  75 },
 	[SDXC_CLK_50M]		= { .output =  90, .sample = 120 },
 	[SDXC_CLK_50M_DDR]	= { .output =  60, .sample = 120 },
+	/* Value from A83T "new timing mode". Works but might not be right. */
+	[SDXC_CLK_50M_DDR_8BIT]	= { .output =  90, .sample = 180 },
 };
 
 static const struct sunxi_mmc_clk_delay sun9i_mmc_clk_delays[] = {
@@ -972,6 +990,7 @@ static const struct sunxi_mmc_clk_delay sun9i_mmc_clk_delays[] = {
 	[SDXC_CLK_25M]		= { .output = 180, .sample =  75 },
 	[SDXC_CLK_50M]		= { .output = 150, .sample = 120 },
 	[SDXC_CLK_50M_DDR]	= { .output =  90, .sample = 120 },
+	[SDXC_CLK_50M_DDR_8BIT]	= { .output =  90, .sample = 120 },
 };
 
 static int sunxi_mmc_resource_request(struct sunxi_mmc_host *host,
-- 
2.7.0.rc3

