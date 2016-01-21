From: Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH RFC 05/15] mmc: sunxi: Support MMC_DDR52 timing modes
Date: Thu, 21 Jan 2016 13:26:32 +0800
Message-ID: <1453354002-28366-6-git-send-email-wens@csie.org>
References: <1453354002-28366-1-git-send-email-wens@csie.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453354002-28366-1-git-send-email-wens@csie.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Hans de Goede <hdegoede@redhat.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
List-Id: linux-mmc@vger.kernel.org

DDR transfer modes include UHS-1 DDR50 and MMC HS-DDR (or MMC_DDR52).
Consider MMC_DDR52 when setting clock delays.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/mmc/host/sunxi-mmc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 4bec87458317..b403a2433eec 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -687,7 +687,8 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
 		oclk_dly = host->clk_delays[SDXC_CLK_25M].output;
 		sclk_dly = host->clk_delays[SDXC_CLK_25M].sample;
 	} else if (rate <= 50000000) {
-		if (ios->timing == MMC_TIMING_UHS_DDR50) {
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
-- 
2.7.0.rc3
