From: Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v2 09/11] phy: rockchip-emmc: Minor code cleanup in rockchip_emmc_phy_power_on/off()
Date: Mon, 13 Jun 2016 16:04:33 -0700
Message-ID: <1465859076-4868-10-git-send-email-dianders@chromium.org>
References: <1465859076-4868-1-git-send-email-dianders@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465859076-4868-1-git-send-email-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, kishon@ti.com, Heiko Stuebner <heiko@sntech.de>, robh+dt@kernel.org
Cc: shawn.lin@rock-chips.com, xzy.xu@rock-chips.com, briannorris@chromium.org, adrian.hunter@intel.com, linux-rockchip@lists.infradead.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

There's no reason to store the return value of rockchip_emmc_phy_power()
in a variable nor to check it.  Just return it.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
Changes in v2:
- Move code cleanup before set phyctrl_frqsel based on card clock (Shawn)

 drivers/phy/phy-rockchip-emmc.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/phy/phy-rockchip-emmc.c b/drivers/phy/phy-rockchip-emmc.c
index 2d059c046978..23fe50864526 100644
--- a/drivers/phy/phy-rockchip-emmc.c
+++ b/drivers/phy/phy-rockchip-emmc.c
@@ -169,20 +169,14 @@ static int rockchip_emmc_phy_power(struct rockchip_emmc_phy *rk_phy,
 static int rockchip_emmc_phy_power_off(struct phy *phy)
 {
 	struct rockchip_emmc_phy *rk_phy = phy_get_drvdata(phy);
-	int ret = 0;
 
 	/* Power down emmc phy analog blocks */
-	ret = rockchip_emmc_phy_power(rk_phy, PHYCTRL_PDB_PWR_OFF);
-	if (ret)
-		return ret;
-
-	return 0;
+	return rockchip_emmc_phy_power(rk_phy, PHYCTRL_PDB_PWR_OFF);
 }
 
 static int rockchip_emmc_phy_power_on(struct phy *phy)
 {
 	struct rockchip_emmc_phy *rk_phy = phy_get_drvdata(phy);
-	int ret = 0;
 
 	/* DLL operation: 200 MHz */
 	regmap_write(rk_phy->reg_base,
@@ -213,11 +207,7 @@ static int rockchip_emmc_phy_power_on(struct phy *phy)
 				   PHYCTRL_OTAPDLYSEL_SHIFT));
 
 	/* Power up emmc phy analog blocks */
-	ret = rockchip_emmc_phy_power(rk_phy, PHYCTRL_PDB_PWR_ON);
-	if (ret)
-		return ret;
-
-	return 0;
+	return rockchip_emmc_phy_power(rk_phy, PHYCTRL_PDB_PWR_ON);
 }
 
 static const struct phy_ops ops = {
-- 
2.8.0.rc3.226.g39d4020
