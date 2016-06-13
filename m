From: Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v2 02/11] mmc: sdhci-of-arasan: Always power the PHY off/on when clock changes
Date: Mon, 13 Jun 2016 16:04:26 -0700
Message-ID: <1465859076-4868-3-git-send-email-dianders@chromium.org>
References: <1465859076-4868-1-git-send-email-dianders@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465859076-4868-1-git-send-email-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, kishon@ti.com, Heiko Stuebner <heiko@sntech.de>, robh+dt@kernel.org
Cc: shawn.lin@rock-chips.com, xzy.xu@rock-chips.com, briannorris@chromium.org, adrian.hunter@intel.com, linux-rockchip@lists.infradead.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, michal.simek@xilinx.com, soren.brinkmann@xilinx.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

In commit 802ac39a5566 ("mmc: sdhci-of-arasan: fix set_clock when a phy
is supported") we added code to power the PHY off and on whenever the
clock was changed but we avoided doing the power cycle code when the
clock was low speed.  Let's now do it always.

Although there may be other reasons for power cycling the PHY when the
clock changes, one of the main reasons is that we need to give the DLL a
chance to re-lock with the new clock.

One of the things that the DLL is for is tuning the Receive Clock in
HS200 mode and STRB in HS400 mode.  Thus it is clear that we should make
sure we power cycle the PHY (and wait for the DLL to lock) when we know
we'll be in one of these two speed modes.  That's what the original code
did, though it used the clock rate rather than the speed mode.  However,
even in speed modes other than HS200,/HS400 the DLL is used for
something since it can be clearly observed that the PHY doesn't function
properly if you leave the DLL off.

Although it appears less important to power cycle the PHY and wait for
the DLL to lock when not in HS200/HS400 modes (no bugs were reported),
it still seems wise to let the locking always happen nevertheless.

Note: as part of this, we make sure that we never try to turn the PHY on
when the clock is off (when the clock rate is 0).  The PHY cannot work
when the clock is off since its DLL can't lock.

This change requires ("phy: rockchip-emmc: Increase lock time
allowance") and will cause problems if picked without that change.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
Changes in v2: None

 drivers/mmc/host/sdhci-of-arasan.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 533e2bcb10bc..3ff1711077c2 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -35,11 +35,13 @@
 /**
  * struct sdhci_arasan_data
  * @clk_ahb:	Pointer to the AHB clock
- * @phy: Pointer to the generic phy
+ * @phy:	Pointer to the generic phy
+ * @phy_on:	True if the PHY is turned on.
  */
 struct sdhci_arasan_data {
 	struct clk	*clk_ahb;
 	struct phy	*phy;
+	bool		phy_on;
 };
 
 static unsigned int sdhci_arasan_get_timeout_clock(struct sdhci_host *host)
@@ -61,12 +63,10 @@ static void sdhci_arasan_set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
-	bool ctrl_phy = false;
 
-	if (clock > MMC_HIGH_52_MAX_DTR && (!IS_ERR(sdhci_arasan->phy)))
-		ctrl_phy = true;
+	if (sdhci_arasan->phy_on && !IS_ERR(sdhci_arasan->phy)) {
+		sdhci_arasan->phy_on = false;
 
-	if (ctrl_phy) {
 		spin_unlock_irq(&host->lock);
 		phy_power_off(sdhci_arasan->phy);
 		spin_lock_irq(&host->lock);
@@ -74,7 +74,9 @@ static void sdhci_arasan_set_clock(struct sdhci_host *host, unsigned int clock)
 
 	sdhci_set_clock(host, clock);
 
-	if (ctrl_phy) {
+	if (host->mmc->actual_clock && !IS_ERR(sdhci_arasan->phy)) {
+		sdhci_arasan->phy_on = true;
+
 		spin_unlock_irq(&host->lock);
 		phy_power_on(sdhci_arasan->phy);
 		spin_lock_irq(&host->lock);
@@ -257,12 +259,6 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 			goto clk_disable_all;
 		}
 
-		ret = phy_power_on(sdhci_arasan->phy);
-		if (ret < 0) {
-			dev_err(&pdev->dev, "phy_power_on err.\n");
-			goto err_phy_power;
-		}
-
 		host->mmc_host_ops.hs400_enhanced_strobe =
 					sdhci_arasan_hs400_enhanced_strobe;
 	}
@@ -275,9 +271,6 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 
 err_add_host:
 	if (!IS_ERR(sdhci_arasan->phy))
-		phy_power_off(sdhci_arasan->phy);
-err_phy_power:
-	if (!IS_ERR(sdhci_arasan->phy))
 		phy_exit(sdhci_arasan->phy);
 clk_disable_all:
 	clk_disable_unprepare(clk_xin);
-- 
2.8.0.rc3.226.g39d4020
