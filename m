From: Kevin Liu <kliu5@marvell.com>
Subject: [PATCH v10 08/12] mmc: sdhci: remove set_uhs_signaling function
Date: Mon, 17 Dec 2012 19:22:04 +0800
Message-ID: <1355743328-17758-9-git-send-email-kliu5@marvell.com>
References: <1355743328-17758-1-git-send-email-kliu5@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog134.obsmtp.com ([74.125.149.83]:38854 "EHLO
	na3sys009aog134.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752275Ab2LQLW6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Dec 2012 06:22:58 -0500
In-Reply-To: <1355743328-17758-1-git-send-email-kliu5@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org, arindam.nath@amd.com, peppe.cavallaro@st.com, ulf.hansson@linaro.org, andriy.shevchenko@linux.intel.com, prakity@nvidia.com
Cc: zhangfei.gao@gmail.com, haojian.zhuang@gmail.com, cxie4@marvell.com, keyuan.liu@gmail.com, Kevin Liu <kliu5@marvell.com>

Because default way can cover all cases so no need to implement this.

Acked-by: Zhangfei Gao <zhangfei.gao@marvell.com>
Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/host/sdhci-pxav3.c |   39 ---------------------------------
 drivers/mmc/host/sdhci.c       |   46 ++++++++++++++++++---------------------
 drivers/mmc/host/sdhci.h       |    1 -
 3 files changed, 21 insertions(+), 65 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index fad0966..a308598 100644
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
index 4ef94a5..c0380a4 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1468,33 +1468,29 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 		if (ctrl_2 & SDHCI_CTRL_PRESET_VAL_ENABLE)
 			sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
 
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
 		clock = host->clock;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index d00e273..e0c9120 100644
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
1.7.0.4

