From: Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH 1/3] mmc: sunxi: Support MMC_DDR52 timing modes
Date: Sat, 30 Jan 2016 01:21:46 +0800
Message-ID: <1454088108-2332-2-git-send-email-wens@csie.org>
References: <1454088108-2332-1-git-send-email-wens@csie.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:60564 "EHLO
	smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752621AbcA2RWX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Jan 2016 12:22:23 -0500
In-Reply-To: <1454088108-2332-1-git-send-email-wens@csie.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Hans de Goede <hdegoede@redhat.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com

DDR transfer modes include UHS-1 DDR50 and MMC HS-DDR (or MMC_DDR52).
Consider MMC_DDR52 when setting clock delays.

Since MMC high speed mode goes up to 52 MHz instead of 50 MHz for SD,
and this number is visible in the capability macro, increase the
clock rate upper limit to 52 MHz.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/mmc/host/sunxi-mmc.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 765dfb9f77ec..fe6c171fd135 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -686,8 +686,9 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
 	} else if (rate <= 25000000) {
 		oclk_dly = host->clk_delays[SDXC_CLK_25M].output;
 		sclk_dly = host->clk_delays[SDXC_CLK_25M].sample;
-	} else if (rate <= 50000000) {
-		if (ios->timing == MMC_TIMING_UHS_DDR50) {
+	} else if (rate <= 52000000) {
+		if (ios->timing == MMC_TIMING_UHS_DDR50 ||
+		    ios->timing == MMC_TIMING_MMC_DDR52) {
 			oclk_dly = host->clk_delays[SDXC_CLK_50M_DDR].output;
 			sclk_dly = host->clk_delays[SDXC_CLK_50M_DDR].sample;
 		} else {
@@ -762,7 +763,8 @@ static void sunxi_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	/* set ddr mode */
 	rval = mmc_readl(host, REG_GCTRL);
-	if (ios->timing == MMC_TIMING_UHS_DDR50)
+	if (ios->timing == MMC_TIMING_UHS_DDR50 ||
+	    ios->timing == MMC_TIMING_MMC_DDR52)
 		rval |= SDXC_DDR_MODE;
 	else
 		rval &= ~SDXC_DDR_MODE;
@@ -1106,9 +1108,9 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
 	mmc->max_segs		= PAGE_SIZE / sizeof(struct sunxi_idma_des);
 	mmc->max_seg_size	= (1 << host->idma_des_size_bits);
 	mmc->max_req_size	= mmc->max_seg_size * mmc->max_segs;
-	/* 400kHz ~ 50MHz */
+	/* 400kHz ~ 52MHz */
 	mmc->f_min		=   400000;
-	mmc->f_max		= 50000000;
+	mmc->f_max		= 52000000;
 	mmc->caps	       |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
 				  MMC_CAP_ERASE | MMC_CAP_SDIO_IRQ;
 
-- 
2.7.0

