From: Kevin Liu <kliu5@marvell.com>
Subject: [PATCH 5/5] mmc: sdhci: remove set_uhs_signaling function
Date: Tue, 29 Jan 2013 16:21:09 +0800
Message-ID: <1359447669-20089-6-git-send-email-kliu5@marvell.com>
References: <1359447669-20089-1-git-send-email-kliu5@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog134.obsmtp.com ([74.125.149.83]:60967 "EHLO
	na3sys009aog134.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754447Ab3A2IUd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Jan 2013 03:20:33 -0500
In-Reply-To: <1359447669-20089-1-git-send-email-kliu5@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Jaehoon Chung <jh80.chung@samsung.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Nicolas Pitre <nico@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Philip Rakity <prakity@nvidia.com>, Aaron Lu <aaron.lu@intel.com>, Shawn Guo <shawn.guo@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Daniel Drake <dsd@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Jerry Huang <Chang-Ming.Huang@freescale.com>, Alexander Stein <alexander.stein@systec-electronic.com>, Girish K S <girish.shivananjappa@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Viresh Kumar <viresh.kumar@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Thomas Abraham <thomas.abraham@linaro.org>, Chander Kashyap <chander.kashyap@linaro.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao Xie <cxie4@marvell.com>, Kevin Liu <keyuan.liu@gmail.com>, Kevin Liu <kl>

set_uhs_signaling was introduced in sdhci-pxav3.c to enable 1.8v signaling.
The function can be removed after sdhci.c has covered this.

Acked-by: Zhangfei Gao <zhangfei.gao@marvell.com>
Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/host/sdhci-pxav3.c |   39 ----------------------------------
 drivers/mmc/host/sdhci.c       |   46 ++++++++++++++++++----------------------
 drivers/mmc/host/sdhci.h       |    1 -
 3 files changed, 21 insertions(+), 65 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index 3d20c10..03c7d1f 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -125,44 +125,6 @@ static void pxav3_gen_init_74_clocks(struct sdhci_host *host, u8 power_mode)
 	pxa->power_mode = power_mode;
 }
 
-static int pxav3_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
-{
-	u16 ctrl_2;
-
-	/*
-	 * Set V18_EN -- UHS modes do not work without this.
-	 * does not change signaling voltage
-	 */
-	ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
-
-	/* Select Bus Speed Mode for host */
-	ctrl_2 &= ~SDHCI_CTRL_UHS_MASK;
-	switch (uhs) {
-	case MMC_TIMING_UHS_SDR12:
-		ctrl_2 |= SDHCI_CTRL_UHS_SDR12;
-		break;
-	case MMC_TIMING_UHS_SDR25:
-		ctrl_2 |= SDHCI_CTRL_UHS_SDR25;
-		break;
-	case MMC_TIMING_UHS_SDR50:
-		ctrl_2 |= SDHCI_CTRL_UHS_SDR50 | SDHCI_CTRL_VDD_180;
-		break;
-	case MMC_TIMING_UHS_SDR104:
-		ctrl_2 |= SDHCI_CTRL_UHS_SDR104 | SDHCI_CTRL_VDD_180;
-		break;
-	case MMC_TIMING_UHS_DDR50:
-		ctrl_2 |= SDHCI_CTRL_UHS_DDR50 | SDHCI_CTRL_VDD_180;
-		break;
-	}
-
-	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
-	dev_dbg(mmc_dev(host->mmc),
-		"%s uhs = %d, ctrl_2 = %04X\n",
-		__func__, uhs, ctrl_2);
-
-	return 0;
-}
-
 static u32 pxav3_get_max_clock(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -172,7 +134,6 @@ static u32 pxav3_get_max_clock(struct sdhci_host *host)
 
 static struct sdhci_ops pxav3_sdhci_ops = {
 	.platform_reset_exit = pxav3_set_private_registers,
-	.set_uhs_signaling = pxav3_set_uhs_signaling,
 	.platform_send_init_74_clocks = pxav3_gen_init_74_clocks,
 	.get_max_clock = pxav3_get_max_clock,
 };
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index d4bd1c3..d877d02 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1488,33 +1488,29 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 		clk &= ~SDHCI_CLOCK_CARD_EN;
 		sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
 
-		if (host->ops->set_uhs_signaling)
-			host->ops->set_uhs_signaling(host, ios->timing);
-		else {
-			ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
-			/* Select Bus Speed Mode for host */
-			ctrl_2 &= ~SDHCI_CTRL_UHS_MASK;
-			if (ios->timing == MMC_TIMING_MMC_HS200)
-				ctrl_2 |= SDHCI_CTRL_HS_SDR200;
-			else if (ios->timing == MMC_TIMING_UHS_SDR12)
-				ctrl_2 |= SDHCI_CTRL_UHS_SDR12;
-			else if (ios->timing == MMC_TIMING_UHS_SDR25)
-				ctrl_2 |= SDHCI_CTRL_UHS_SDR25;
-			else if (ios->timing == MMC_TIMING_UHS_SDR50)
-				ctrl_2 |= SDHCI_CTRL_UHS_SDR50;
-			else if (ios->timing == MMC_TIMING_UHS_SDR104)
-				ctrl_2 |= SDHCI_CTRL_UHS_SDR104;
-			else if (ios->timing == MMC_TIMING_UHS_DDR50) {
-				struct mmc_card	*card;
-
-				ctrl_2 |= SDHCI_CTRL_UHS_DDR50;
-				card = container_of(&(host->mmc),
+		ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+		/* Select Bus Speed Mode for host */
+		ctrl_2 &= ~SDHCI_CTRL_UHS_MASK;
+		if (ios->timing == MMC_TIMING_MMC_HS200)
+			ctrl_2 |= SDHCI_CTRL_HS_SDR200;
+		else if (ios->timing == MMC_TIMING_UHS_SDR12)
+			ctrl_2 |= SDHCI_CTRL_UHS_SDR12;
+		else if (ios->timing == MMC_TIMING_UHS_SDR25)
+			ctrl_2 |= SDHCI_CTRL_UHS_SDR25;
+		else if (ios->timing == MMC_TIMING_UHS_SDR50)
+			ctrl_2 |= SDHCI_CTRL_UHS_SDR50;
+		else if (ios->timing == MMC_TIMING_UHS_SDR104)
+			ctrl_2 |= SDHCI_CTRL_UHS_SDR104;
+		else if (ios->timing == MMC_TIMING_UHS_DDR50) {
+			struct mmc_card	*card;
+
+			ctrl_2 |= SDHCI_CTRL_UHS_DDR50;
+			card = container_of(&(host->mmc),
 					struct mmc_card, host);
-				if (mmc_card_mmc(card))
-					ctrl_2 |= SDHCI_CTRL_VDD_180;
-			}
-			sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
+			if (mmc_card_mmc(card))
+				ctrl_2 |= SDHCI_CTRL_VDD_180;
 		}
+		sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
 
 		/* Re-enable SD Clock */
 		sdhci_update_clock(host);
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 4a65dbe..b4a8a08 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -276,7 +276,6 @@ struct sdhci_ops {
 	unsigned int    (*get_ro)(struct sdhci_host *host);
 	void	(*platform_reset_enter)(struct sdhci_host *host, u8 mask);
 	void	(*platform_reset_exit)(struct sdhci_host *host, u8 mask);
-	int	(*set_uhs_signaling)(struct sdhci_host *host, unsigned int uhs);
 	void	(*hw_reset)(struct sdhci_host *host);
 	void	(*platform_suspend)(struct sdhci_host *host);
 	void	(*platform_resume)(struct sdhci_host *host);
-- 
1.7.9.5

