From: Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 09/11] phy: rockchip-emmc: Set phyctrl_frqsel based on card clock
Date: Tue,  7 Jun 2016 15:44:42 -0700
Message-ID: <1465339484-969-10-git-send-email-dianders@chromium.org>
References: <1465339484-969-1-git-send-email-dianders@chromium.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:33502 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423508AbcFGWpS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Jun 2016 18:45:18 -0400
Received: by mail-pf0-f175.google.com with SMTP id y124so22388168pfy.0
        for <linux-mmc@vger.kernel.org>; Tue, 07 Jun 2016 15:45:17 -0700 (PDT)
In-Reply-To: <1465339484-969-1-git-send-email-dianders@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, kishon@ti.com, Heiko Stuebner <heiko@sntech.de>, robh+dt@kernel.org
Cc: shawn.lin@rock-chips.com, xzy.xu@rock-chips.com, briannorris@chromium.org, adrian.hunter@intel.com, linux-rockchip@lists.infradead.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

The "phyctrl_frqsel" is described in the Arasan datasheet [1] as "the
frequency range of DLL operation".  Although the Rockchip variant of
this PHY has different ranges than the reference Arasan PHY it appears
as if the functionality is similar.  We should set this phyctrl field
properly.

Note: as per Rockchip engineers, apparently the "phyctrl_frqsel" is
actually only useful in HS200 / HS400 modes even though the DLL itself
it used for some purposes in all modes.  See the discussion in the
earlier change in this series: ("mmc: sdhci-of-arasan: Always power the
PHY off/on when clock changes").  In any case, it shouldn't hurt to set
this always.

Note that this change should allow boards to run at HS200 / HS400 speed
modes while running at 100 MHz or 150 MHz.  In fact, running HS400 at
150 MHz (giving 300 MB/s) is the main motivation of this series, since
performance is still good but signal integrity problems are less
prevelant at 150 MHz.

[1]: https://arasan.com/wp-content/media/eMMC-5-1-Total-Solution_Rev-1-3.pdf

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
 drivers/phy/phy-rockchip-emmc.c | 74 +++++++++++++++++++++++++++++++----------
 1 file changed, 57 insertions(+), 17 deletions(-)

diff --git a/drivers/phy/phy-rockchip-emmc.c b/drivers/phy/phy-rockchip-emmc.c
index 8336053aea5c..0fce7359d468 100644
--- a/drivers/phy/phy-rockchip-emmc.c
+++ b/drivers/phy/phy-rockchip-emmc.c
@@ -14,6 +14,7 @@
  * GNU General Public License for more details.
  */
 
+#include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
@@ -78,16 +79,61 @@
 struct rockchip_emmc_phy {
 	unsigned int	reg_offset;
 	struct regmap	*reg_base;
+	struct clk	*emmcclk;
 };
 
-static int rockchip_emmc_phy_power(struct rockchip_emmc_phy *rk_phy,
-				   bool on_off)
+static int rockchip_emmc_phy_power(struct phy *phy, bool on_off)
 {
+	struct rockchip_emmc_phy *rk_phy = phy_get_drvdata(phy);
 	unsigned int caldone;
 	unsigned int dllrdy;
+	unsigned int freqsel = PHYCTRL_FREQSEL_200M;
 	unsigned long timeout;
 
 	/*
+	 * We purposely get the clock here and not in probe to avoid the
+	 * circular dependency problem.  We expect:
+	 * - PHY driver to probe
+	 * - USB driver to start probe
+	 * - USB driver to register it's clock
+	 * - USB driver to get the PHY
+	 * - USB driver to power on the PHY
+	 */
+	if (!rk_phy->emmcclk) {
+		rk_phy->emmcclk = devm_clk_get(&phy->dev, "emmcclk");
+
+		/* Don't expect defer at this point; try next time */
+		if (PTR_ERR(rk_phy->emmcclk) == -EPROBE_DEFER) {
+			dev_warn(&phy->dev, "Unexpected emmcclk defer\n");
+			rk_phy->emmcclk = NULL;
+		}
+	}
+
+	if (!IS_ERR_OR_NULL(rk_phy->emmcclk)) {
+		unsigned long rate = clk_get_rate(rk_phy->emmcclk);
+
+		switch (rate) {
+		case 0 ... 74999999:
+			/* Nominal  50 MHz */
+			freqsel = PHYCTRL_FREQSEL_50M;
+			break;
+		case 75000000 ... 124999999:
+			/* Nominal 100 MHz */
+			freqsel = PHYCTRL_FREQSEL_100M;
+			break;
+		case 125000000 ... 174999999:
+			/* Nominal 150 MHz */
+			freqsel = PHYCTRL_FREQSEL_150M;
+			break;
+		default:
+			if (rate > 200000000)
+				dev_warn(&phy->dev, "Unsupported rate: %lu\n",
+					 rate);
+			break;
+		};
+	}
+
+	/*
 	 * Keep phyctrl_pdb and phyctrl_endll low to allow
 	 * initialization of CALIO state M/C DFFs
 	 */
@@ -132,6 +178,13 @@ static int rockchip_emmc_phy_power(struct rockchip_emmc_phy *rk_phy,
 		return -ETIMEDOUT;
 	}
 
+	/* Set the frequency of the DLL operation */
+	regmap_write(rk_phy->reg_base,
+		     rk_phy->reg_offset + GRF_EMMCPHY_CON0,
+		     HIWORD_UPDATE(freqsel, PHYCTRL_FREQSEL_MASK,
+				   PHYCTRL_FREQSEL_SHIFT));
+
+	/* Turn on the DLL */
 	regmap_write(rk_phy->reg_base,
 		     rk_phy->reg_offset + GRF_EMMCPHY_CON6,
 		     HIWORD_UPDATE(PHYCTRL_ENDLL_ENABLE,
@@ -167,15 +220,8 @@ static int rockchip_emmc_phy_power(struct rockchip_emmc_phy *rk_phy,
 
 static int rockchip_emmc_phy_power_off(struct phy *phy)
 {
-	struct rockchip_emmc_phy *rk_phy = phy_get_drvdata(phy);
-	int ret = 0;
-
 	/* Power down emmc phy analog blocks */
-	ret = rockchip_emmc_phy_power(rk_phy, PHYCTRL_PDB_PWR_OFF);
-	if (ret)
-		return ret;
-
-	return 0;
+	return rockchip_emmc_phy_power(phy, PHYCTRL_PDB_PWR_OFF);
 }
 
 static int rockchip_emmc_phy_power_on(struct phy *phy)
@@ -183,12 +229,6 @@ static int rockchip_emmc_phy_power_on(struct phy *phy)
 	struct rockchip_emmc_phy *rk_phy = phy_get_drvdata(phy);
 	int ret = 0;
 
-	/* DLL operation: 200 MHz */
-	regmap_write(rk_phy->reg_base,
-		     rk_phy->reg_offset + GRF_EMMCPHY_CON0,
-		     HIWORD_UPDATE(PHYCTRL_FREQSEL_200M,
-				   PHYCTRL_FREQSEL_MASK,
-				   PHYCTRL_FREQSEL_SHIFT));
 
 	/* Drive impedance: 50 Ohm */
 	regmap_write(rk_phy->reg_base,
@@ -212,7 +252,7 @@ static int rockchip_emmc_phy_power_on(struct phy *phy)
 				   PHYCTRL_OTAPDLYSEL_SHIFT));
 
 	/* Power up emmc phy analog blocks */
-	ret = rockchip_emmc_phy_power(rk_phy, PHYCTRL_PDB_PWR_ON);
+	ret = rockchip_emmc_phy_power(phy, PHYCTRL_PDB_PWR_ON);
 	if (ret)
 		return ret;
 
-- 
2.8.0.rc3.226.g39d4020

