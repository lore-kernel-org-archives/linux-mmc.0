From: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 10/11] phy: rockchip-emmc: Minor code cleanup in rockchip_emmc_phy_power_off()
Date: Tue,  7 Jun 2016 15:44:43 -0700
Message-ID: <1465339484-969-11-git-send-email-dianders@chromium.org>
References: <1465339484-969-1-git-send-email-dianders@chromium.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1465339484-969-1-git-send-email-dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org, briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

There's no reason to store the return value of rockchip_emmc_phy_power()
in a variable nor to check it.  Just return it.

Signed-off-by: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---
 drivers/phy/phy-rockchip-emmc.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/phy/phy-rockchip-emmc.c b/drivers/phy/phy-rockchip-emmc.c
index 0fce7359d468..188e4c387ba8 100644
--- a/drivers/phy/phy-rockchip-emmc.c
+++ b/drivers/phy/phy-rockchip-emmc.c
@@ -227,8 +227,6 @@ static int rockchip_emmc_phy_power_off(struct phy *phy)
 static int rockchip_emmc_phy_power_on(struct phy *phy)
 {
 	struct rockchip_emmc_phy *rk_phy = phy_get_drvdata(phy);
-	int ret = 0;
-
 
 	/* Drive impedance: 50 Ohm */
 	regmap_write(rk_phy->reg_base,
@@ -252,11 +250,7 @@ static int rockchip_emmc_phy_power_on(struct phy *phy)
 				   PHYCTRL_OTAPDLYSEL_SHIFT));
 
 	/* Power up emmc phy analog blocks */
-	ret = rockchip_emmc_phy_power(phy, PHYCTRL_PDB_PWR_ON);
-	if (ret)
-		return ret;
-
-	return 0;
+	return rockchip_emmc_phy_power(phy, PHYCTRL_PDB_PWR_ON);
 }
 
 static const struct phy_ops ops = {
-- 
2.8.0.rc3.226.g39d4020

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
