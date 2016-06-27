From: Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 2/3] phy: rockchip-emmc: Be tolerant to card clock of 0 in power on
Date: Mon, 27 Jun 2016 10:39:26 -0700
Message-ID: <1467049167-14628-3-git-send-email-dianders@chromium.org>
References: <1467049167-14628-1-git-send-email-dianders@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467049167-14628-1-git-send-email-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>, ulf.hansson@linaro.org, kishon@ti.com
Cc: shawn.lin@rock-chips.com, linux-rockchip@lists.infradead.org, linux-mmc@vger.kernel.org, briannorris@chromium.org, Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

It's possible that there are some reasons to turn the PHY on while the
clock is 0.  In this case we just won't wait for the DLL to lock.

This is a bit of a stopgap until we figure out exactly when we're
supposed to wait for the DLL to lock and when we're supposed to power
cycle the PHY.

Note: this patch should help with suspend/resume where the system will
try to turn the PHY back on when the clock is 0.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
 drivers/phy/phy-rockchip-emmc.c | 59 ++++++++++++++++++++++++++---------------
 1 file changed, 37 insertions(+), 22 deletions(-)

diff --git a/drivers/phy/phy-rockchip-emmc.c b/drivers/phy/phy-rockchip-emmc.c
index 9dce958233a0..a2aa6aca7dec 100644
--- a/drivers/phy/phy-rockchip-emmc.c
+++ b/drivers/phy/phy-rockchip-emmc.c
@@ -88,15 +88,36 @@ static int rockchip_emmc_phy_power(struct phy *phy, bool on_off)
 	unsigned int caldone;
 	unsigned int dllrdy;
 	unsigned int freqsel = PHYCTRL_FREQSEL_200M;
+	unsigned long rate;
 	unsigned long timeout;
 
-	if (rk_phy->emmcclk != NULL) {
-		unsigned long rate = clk_get_rate(rk_phy->emmcclk);
+	/*
+	 * Keep phyctrl_pdb and phyctrl_endll low to allow
+	 * initialization of CALIO state M/C DFFs
+	 */
+	regmap_write(rk_phy->reg_base,
+		     rk_phy->reg_offset + GRF_EMMCPHY_CON6,
+		     HIWORD_UPDATE(PHYCTRL_PDB_PWR_OFF,
+				   PHYCTRL_PDB_MASK,
+				   PHYCTRL_PDB_SHIFT));
+	regmap_write(rk_phy->reg_base,
+		     rk_phy->reg_offset + GRF_EMMCPHY_CON6,
+		     HIWORD_UPDATE(PHYCTRL_ENDLL_DISABLE,
+				   PHYCTRL_ENDLL_MASK,
+				   PHYCTRL_ENDLL_SHIFT));
+
+	/* Already finish power_off above */
+	if (on_off == PHYCTRL_PDB_PWR_OFF)
+		return 0;
+
+	rate = clk_get_rate(rk_phy->emmcclk);
+
+	if (rate != 0) {
 		unsigned long ideal_rate;
 		unsigned long diff;
 
 		switch (rate) {
-		case 0 ... 74999999:
+		case 1 ... 74999999:
 			ideal_rate = 50000000;
 			freqsel = PHYCTRL_FREQSEL_50M;
 			break;
@@ -127,25 +148,6 @@ static int rockchip_emmc_phy_power(struct phy *phy, bool on_off)
 	}
 
 	/*
-	 * Keep phyctrl_pdb and phyctrl_endll low to allow
-	 * initialization of CALIO state M/C DFFs
-	 */
-	regmap_write(rk_phy->reg_base,
-		     rk_phy->reg_offset + GRF_EMMCPHY_CON6,
-		     HIWORD_UPDATE(PHYCTRL_PDB_PWR_OFF,
-				   PHYCTRL_PDB_MASK,
-				   PHYCTRL_PDB_SHIFT));
-	regmap_write(rk_phy->reg_base,
-		     rk_phy->reg_offset + GRF_EMMCPHY_CON6,
-		     HIWORD_UPDATE(PHYCTRL_ENDLL_DISABLE,
-				   PHYCTRL_ENDLL_MASK,
-				   PHYCTRL_ENDLL_SHIFT));
-
-	/* Already finish power_off above */
-	if (on_off == PHYCTRL_PDB_PWR_OFF)
-		return 0;
-
-	/*
 	 * According to the user manual, calpad calibration
 	 * cycle takes more than 2us without the minimal recommended
 	 * value, so we may need a little margin here
@@ -183,6 +185,19 @@ static int rockchip_emmc_phy_power(struct phy *phy, bool on_off)
 		     HIWORD_UPDATE(PHYCTRL_ENDLL_ENABLE,
 				   PHYCTRL_ENDLL_MASK,
 				   PHYCTRL_ENDLL_SHIFT));
+
+	/*
+	 * We turned on the DLL even though the rate was 0 because we the
+	 * clock might be turned on later.  ...but we can't wait for the DLL
+	 * to lock when the rate is 0 because it will never lock with no
+	 * input clock.
+	 *
+	 * Technically we should be checking the lock later when the clock
+	 * is turned on, but for now we won't.
+	 */
+	if (rate == 0)
+		return 0;
+
 	/*
 	 * After enabling analog DLL circuits docs say that we need 10.2 us if
 	 * our source clock is at 50 MHz and that lock time scales linearly
-- 
2.8.0.rc3.226.g39d4020
