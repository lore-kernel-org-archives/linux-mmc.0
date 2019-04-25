From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH 1/2] mmc: sdhci_am654: Fix minor phy configurations
Date: Thu, 25 Apr 2019 21:27:26 +0530
Message-ID: <20190425155727.20010-2-faiz_abbas@ti.com>
References: <20190425155727.20010-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190425155727.20010-1-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com, faiz_abbas@ti.com
List-Id: linux-mmc@vger.kernel.org

Fix the following minor things:

1. Line wrapping with the regmap_*() functions is way more conservative
than required by the 80 character rule. Expand the function calls out to
use less number of lines.

2. Add an error message if the DLL fails to lock.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/mmc/host/sdhci_am654.c | 37 ++++++++++++++++------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index eea183e90f1b..866a9082705f 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -88,8 +88,7 @@ static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
 	int ret;
 
 	if (sdhci_am654->dll_on) {
-		regmap_update_bits(sdhci_am654->base, PHY_CTRL1,
-				   ENDLL_MASK, 0);
+		regmap_update_bits(sdhci_am654->base, PHY_CTRL1, ENDLL_MASK, 0);
 
 		sdhci_am654->dll_on = false;
 	}
@@ -101,8 +100,7 @@ static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
 		mask = OTAPDLYENA_MASK | OTAPDLYSEL_MASK;
 		val = (1 << OTAPDLYENA_SHIFT) |
 		      (sdhci_am654->otap_del_sel << OTAPDLYSEL_SHIFT);
-		regmap_update_bits(sdhci_am654->base, PHY_CTRL4,
-				   mask, val);
+		regmap_update_bits(sdhci_am654->base, PHY_CTRL4, mask, val);
 		switch (clock) {
 		case 200000000:
 			sel50 = 0;
@@ -120,8 +118,7 @@ static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
 		/* Configure PHY DLL frequency */
 		mask = SEL50_MASK | SEL100_MASK;
 		val = (sel50 << SEL50_SHIFT) | (sel100 << SEL100_SHIFT);
-		regmap_update_bits(sdhci_am654->base, PHY_CTRL5,
-				   mask, val);
+		regmap_update_bits(sdhci_am654->base, PHY_CTRL5, mask, val);
 		/* Configure DLL TRIM */
 		mask = DLL_TRIM_ICP_MASK;
 		val = sdhci_am654->trm_icp << DLL_TRIM_ICP_SHIFT;
@@ -129,19 +126,21 @@ static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
 		/* Configure DLL driver strength */
 		mask |= DR_TY_MASK;
 		val |= sdhci_am654->drv_strength << DR_TY_SHIFT;
-		regmap_update_bits(sdhci_am654->base, PHY_CTRL1,
-				   mask, val);
+		regmap_update_bits(sdhci_am654->base, PHY_CTRL1, mask, val);
 		/* Enable DLL */
-		regmap_update_bits(sdhci_am654->base, PHY_CTRL1,
-				   ENDLL_MASK, 0x1 << ENDLL_SHIFT);
+		regmap_update_bits(sdhci_am654->base, PHY_CTRL1, ENDLL_MASK,
+				   0x1 << ENDLL_SHIFT);
 		/*
 		 * Poll for DLL ready. Use a one second timeout.
 		 * Works in all experiments done so far
 		 */
-		ret = regmap_read_poll_timeout(sdhci_am654->base,
-					 PHY_STAT1, val,
-					 val & DLLRDY_MASK,
-					 1000, 1000000);
+		ret = regmap_read_poll_timeout(sdhci_am654->base, PHY_STAT1,
+					       val, val & DLLRDY_MASK, 1000,
+					       1000000);
+		if (ret) {
+			dev_err(mmc_dev(host->mmc), "DLL failed to relock\n");
+			return;
+		}
 
 		sdhci_am654->dll_on = true;
 	}
@@ -186,8 +185,7 @@ static int sdhci_am654_init(struct sdhci_host *host)
 
 	/* Reset OTAP to default value */
 	mask = OTAPDLYENA_MASK | OTAPDLYSEL_MASK;
-	regmap_update_bits(sdhci_am654->base, PHY_CTRL4,
-				   mask, 0x0);
+	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, mask, 0x0);
 
 	regmap_read(sdhci_am654->base, PHY_STAT1, &val);
 	if (~val & CALDONE_MASK) {
@@ -201,15 +199,14 @@ static int sdhci_am654_init(struct sdhci_host *host)
 	}
 
 	/* Enable pins by setting IO mux to 0 */
-	regmap_update_bits(sdhci_am654->base, PHY_CTRL1,
-			   IOMUX_ENABLE_MASK, 0);
+	regmap_update_bits(sdhci_am654->base, PHY_CTRL1, IOMUX_ENABLE_MASK, 0);
 
 	/* Set slot type based on SD or eMMC */
 	if (host->mmc->caps & MMC_CAP_NONREMOVABLE)
 		ctl_cfg_2 = SLOTTYPE_EMBEDDED;
 
-	regmap_update_bits(sdhci_am654->base, CTL_CFG_2,
-			   ctl_cfg_2, SLOTTYPE_MASK);
+	regmap_update_bits(sdhci_am654->base, CTL_CFG_2, ctl_cfg_2,
+			   SLOTTYPE_MASK);
 
 	return sdhci_add_host(host);
 }
-- 
2.19.2
