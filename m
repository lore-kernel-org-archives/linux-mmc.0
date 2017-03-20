From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 09/25] mmc: sdhci: Do not use spin lock in set_ios paths
Date: Mon, 20 Mar 2017 19:50:37 +0200
Message-ID: <1490032253-6030-10-git-send-email-adrian.hunter@intel.com>
References: <1490032253-6030-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:65242 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754922AbdCTR6M (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 20 Mar 2017 13:58:12 -0400
In-Reply-To: <1490032253-6030-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Al Cooper <alcooperx@gmail.com>, Jaedon Shin <jaedon.shin@gmail.com>, Haibo Chen <haibo.chen@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>, Shawn Lin <shawn.lin@rock-chips.com>, Douglas Anderson <dianders@chromium.org>, Zach Brown <zach.brown@ni.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, Jisheng Zhang <jszhang@marvell.com>, Yangbo Lu <yangbo.lu@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, Weijun Yang <Weijun.Yang@csr.com>, Barry Song <Baohua.Song@csr.com>, Peter Griffin <peter.griffin@linaro.org>, Lee Jones <lee.jones@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Harjani Ritesh <riteshh@codeaurora.org>

The spin lock is not necessary in set_ios. Anything that is racing with
changes to the I/O state is already broken. The mmc core already provides
synchronization via "claiming" the host. So remove spin_lock and friends
from sdhci_set_ios and related callbacks.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-msm.c       | 8 --------
 drivers/mmc/host/sdhci-of-arasan.c | 6 ------
 drivers/mmc/host/sdhci-of-at91.c   | 2 --
 drivers/mmc/host/sdhci-pci-core.c  | 4 ----
 drivers/mmc/host/sdhci-pxav3.c     | 5 +----
 drivers/mmc/host/sdhci-s3c.c       | 4 ----
 drivers/mmc/host/sdhci.c           | 9 ---------
 7 files changed, 1 insertion(+), 37 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 10cdc84d5113..9d601dc0d646 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -991,12 +991,8 @@ static void sdhci_msm_set_uhs_signaling(struct sdhci_host *host,
 		mmc_hostname(host->mmc), host->clock, uhs, ctrl_2);
 	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
 
-	spin_unlock_irq(&host->lock);
-
 	if (mmc->ios.timing == MMC_TIMING_MMC_HS400)
 		sdhci_msm_hs400(host, &mmc->ios);
-
-	spin_lock_irq(&host->lock);
 }
 
 static void sdhci_msm_voltage_switch(struct sdhci_host *host)
@@ -1089,13 +1085,9 @@ static void sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
 		goto out;
 	}
 
-	spin_unlock_irq(&host->lock);
-
 	sdhci_msm_hc_select_mode(host);
 
 	msm_set_clock_rate_for_bus_mode(host, clock);
-
-	spin_lock_irq(&host->lock);
 out:
 	__sdhci_msm_set_clock(host, clock);
 }
diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 28feb5367c14..61accf0d4739 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -194,9 +194,7 @@ static void sdhci_arasan_set_clock(struct sdhci_host *host, unsigned int clock)
 			 * through low speeds without power cycling.
 			 */
 			sdhci_set_clock(host, host->max_clk);
-			spin_unlock_irq(&host->lock);
 			phy_power_on(sdhci_arasan->phy);
-			spin_lock_irq(&host->lock);
 			sdhci_arasan->is_phy_on = true;
 
 			/*
@@ -215,18 +213,14 @@ static void sdhci_arasan_set_clock(struct sdhci_host *host, unsigned int clock)
 	}
 
 	if (ctrl_phy && sdhci_arasan->is_phy_on) {
-		spin_unlock_irq(&host->lock);
 		phy_power_off(sdhci_arasan->phy);
-		spin_lock_irq(&host->lock);
 		sdhci_arasan->is_phy_on = false;
 	}
 
 	sdhci_set_clock(host, clock);
 
 	if (ctrl_phy) {
-		spin_unlock_irq(&host->lock);
 		phy_power_on(sdhci_arasan->phy);
-		spin_lock_irq(&host->lock);
 		sdhci_arasan->is_phy_on = true;
 	}
 }
diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
index ce4ae21d5947..814571fec0e2 100644
--- a/drivers/mmc/host/sdhci-of-at91.c
+++ b/drivers/mmc/host/sdhci-of-at91.c
@@ -96,9 +96,7 @@ static void sdhci_at91_set_power(struct sdhci_host *host, unsigned char mode,
 	if (!IS_ERR(host->mmc->supply.vmmc)) {
 		struct mmc_host *mmc = host->mmc;
 
-		spin_unlock_irq(&host->lock);
 		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
-		spin_lock_irq(&host->lock);
 	}
 	sdhci_set_power_noreg(host, mode, vdd);
 }
diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 5c620206138e..98ed90cbd9b4 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -484,8 +484,6 @@ static void sdhci_intel_set_power(struct sdhci_host *host, unsigned char mode,
 	if (mode == MMC_POWER_OFF)
 		return;
 
-	spin_unlock_irq(&host->lock);
-
 	/*
 	 * Bus power might not enable after D3 -> D0 transition due to the
 	 * present state not yet having propagated. Retry for up to 2ms.
@@ -498,8 +496,6 @@ static void sdhci_intel_set_power(struct sdhci_host *host, unsigned char mode,
 		reg |= SDHCI_POWER_ON;
 		sdhci_writeb(host, reg, SDHCI_POWER_CONTROL);
 	}
-
-	spin_lock_irq(&host->lock);
 }
 
 static const struct sdhci_ops sdhci_intel_byt_ops = {
diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index 22ed90433d29..f953f35c2624 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -323,11 +323,8 @@ static void pxav3_set_power(struct sdhci_host *host, unsigned char mode,
 	if (host->pwr == 0)
 		vdd = 0;
 
-	if (!IS_ERR(mmc->supply.vmmc)) {
-		spin_unlock_irq(&host->lock);
+	if (!IS_ERR(mmc->supply.vmmc))
 		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
-		spin_lock_irq(&host->lock);
-	}
 }
 
 static const struct sdhci_ops pxav3_sdhci_ops = {
diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index d02284da2ec6..7c065a70f92b 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -190,9 +190,7 @@ static unsigned int sdhci_s3c_consider_clock(struct sdhci_s3c *ourhost,
 	 * speed possible with selected clock source and skip the division.
 	 */
 	if (ourhost->no_divider) {
-		spin_unlock_irq(&ourhost->host->lock);
 		rate = clk_round_rate(clksrc, wanted);
-		spin_lock_irq(&ourhost->host->lock);
 		return wanted - rate;
 	}
 
@@ -389,9 +387,7 @@ static void sdhci_cmu_set_clock(struct sdhci_host *host, unsigned int clock)
 	clk &= ~SDHCI_CLOCK_CARD_EN;
 	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
 
-	spin_unlock_irq(&host->lock);
 	ret = clk_set_rate(ourhost->clk_bus[ourhost->cur_clk], clock);
-	spin_lock_irq(&host->lock);
 	if (ret != 0) {
 		dev_err(dev, "%s: failed to set clock rate %uHz\n",
 			mmc_hostname(host->mmc), clock);
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index cb235cb74948..f7dfb40826c7 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1361,9 +1361,7 @@ void sdhci_enable_clk(struct sdhci_host *host, u16 clk)
 			sdhci_dumpregs(host);
 			return;
 		}
-		spin_unlock_irq(&host->lock);
 		udelay(10);
-		spin_lock_irq(&host->lock);
 	}
 
 	clk |= SDHCI_CLOCK_CARD_EN;
@@ -1392,9 +1390,7 @@ static void sdhci_set_power_reg(struct sdhci_host *host, unsigned char mode,
 {
 	struct mmc_host *mmc = host->mmc;
 
-	spin_unlock_irq(&host->lock);
 	mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
-	spin_lock_irq(&host->lock);
 
 	if (mode != MMC_POWER_OFF)
 		sdhci_writeb(host, SDHCI_POWER_ON, SDHCI_POWER_CONTROL);
@@ -1574,16 +1570,12 @@ void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
 static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
-	unsigned long flags;
 	u8 ctrl;
 
 	if (ios->power_mode == MMC_POWER_UNDEFINED)
 		return;
 
-	spin_lock_irqsave(&host->lock, flags);
-
 	if (host->flags & SDHCI_DEVICE_DEAD) {
-		spin_unlock_irqrestore(&host->lock, flags);
 		if (!IS_ERR(mmc->supply.vmmc) &&
 		    ios->power_mode == MMC_POWER_OFF)
 			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
@@ -1729,7 +1721,6 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		sdhci_do_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
 
 	mmiowb();
-	spin_unlock_irqrestore(&host->lock, flags);
 }
 
 static int sdhci_get_cd(struct mmc_host *mmc)
-- 
1.9.1

