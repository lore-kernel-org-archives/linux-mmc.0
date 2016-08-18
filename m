From: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH v2] mmc: sdhci-of-arasan: Don't power PHY w/ slow/no clock
Date: Thu, 18 Aug 2016 10:26:38 -0700
Message-ID: <1471541198-8013-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

>From empirical evidence (tested on Rockchip rk3399), it appears that the
PHY intended to be used with the Arasan SDHCI 5.1 controller has trouble
turning on when the card clock is slow or off.  Strangely these problems
appear to show up consistently on some boards while other boards work
fine, but on the boards where it shows up the problem reproduces 100% of
the time and is quite consistent in its behavior.

These problems can be fixed by always making sure that we power on the
PHY (and turn on its DLL) when the card clock is faster than about 50
MHz.  Once on, we need to make sure that we never power down the PHY /
turn off its DLL until the clock is faster again.

We'll add logic for handling this into the sdhci-of-arasan driver.  Note
that right now the only user of a PHY in the sdhci-of-arasan driver is
arasan,sdhci-5.1.  It's presumed that all arasan,sdhci-5.1 PHY
implementations need this workaround, so the logic is only contingent on
having a PHY to control.  If future Arasan controllers don't have this
problem we can add code to decide if we want this flow or not.

Also note that we check for slow clocks by checking for <= 400 kHz
rather than checking for 50 MHz.  This keeps things the most consistent
and also means we can power the PHY on at max speed (where the DLL will
lock fastest).  Presumably anyone who intends to run with a card clock
of < 50 MHz and > 400 kHz will be running on a device where this problem
is fixed anyway.

I believe this brings some resolution to the problems reported before.
See the commit 6fc09244d74d ("mmc: sdhci-of-arasan: Revert: Always power
the PHY off/on when clock changes").

Signed-off-by: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Acked-by: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Reviewed-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---
Tested on chromeos kernel-4.4 with backports.

Changes in v2:
- Fixed typos (Adrian)
- Add #define (Adrian)
- Add Shawn review / Adrian ack

 drivers/mmc/host/sdhci-of-arasan.c | 63 +++++++++++++++++++++++++++++---------
 1 file changed, 48 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index e0f193f7e3e5..0b3a9cfed2df 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -35,6 +35,8 @@
 #define CLK_CTRL_TIMEOUT_MASK		(0xf << CLK_CTRL_TIMEOUT_SHIFT)
 #define CLK_CTRL_TIMEOUT_MIN_EXP	13
 
+#define PHY_CLK_TOO_SLOW_HZ		400000
+
 /*
  * On some SoCs the syscon area has a feature where the upper 16-bits of
  * each 32-bit register act as a write mask for the lower 16-bits.  This allows
@@ -77,6 +79,7 @@ struct sdhci_arasan_soc_ctl_map {
  * @host:		Pointer to the main SDHCI host structure.
  * @clk_ahb:		Pointer to the AHB clock
  * @phy:		Pointer to the generic phy
+ * @is_phy_on:		True if the PHY is on; false if not.
  * @sdcardclk_hw:	Struct for the clock we might provide to a PHY.
  * @sdcardclk:		Pointer to normal 'struct clock' for sdcardclk_hw.
  * @soc_ctl_base:	Pointer to regmap for syscon for soc_ctl registers.
@@ -86,6 +89,7 @@ struct sdhci_arasan_data {
 	struct sdhci_host *host;
 	struct clk	*clk_ahb;
 	struct phy	*phy;
+	bool		is_phy_on;
 
 	struct clk_hw	sdcardclk_hw;
 	struct clk      *sdcardclk;
@@ -170,13 +174,47 @@ static void sdhci_arasan_set_clock(struct sdhci_host *host, unsigned int clock)
 	struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
 	bool ctrl_phy = false;
 
-	if (clock > MMC_HIGH_52_MAX_DTR && (!IS_ERR(sdhci_arasan->phy)))
-		ctrl_phy = true;
+	if (!IS_ERR(sdhci_arasan->phy)) {
+		if (!sdhci_arasan->is_phy_on && clock <= PHY_CLK_TOO_SLOW_HZ) {
+			/*
+			 * If PHY off, set clock to max speed and power PHY on.
+			 *
+			 * Although PHY docs apparently suggest power cycling
+			 * when changing the clock the PHY doesn't like to be
+			 * powered on while at low speeds like those used in ID
+			 * mode.  Even worse is powering the PHY on while the
+			 * clock is off.
+			 *
+			 * To workaround the PHY limitations, the best we can
+			 * do is to power it on at a faster speed and then slam
+			 * through low speeds without power cycling.
+			 */
+			sdhci_set_clock(host, host->max_clk);
+			spin_unlock_irq(&host->lock);
+			phy_power_on(sdhci_arasan->phy);
+			spin_lock_irq(&host->lock);
+			sdhci_arasan->is_phy_on = true;
+
+			/*
+			 * We'll now fall through to the below case with
+			 * ctrl_phy = false (so we won't turn off/on).  The
+			 * sdhci_set_clock() will set the real clock.
+			 */
+		} else if (clock > PHY_CLK_TOO_SLOW_HZ) {
+			/*
+			 * At higher clock speeds the PHY is fine being power
+			 * cycled and docs say you _should_ power cycle when
+			 * changing clock speeds.
+			 */
+			ctrl_phy = true;
+		}
+	}
 
-	if (ctrl_phy) {
+	if (ctrl_phy && sdhci_arasan->is_phy_on) {
 		spin_unlock_irq(&host->lock);
 		phy_power_off(sdhci_arasan->phy);
 		spin_lock_irq(&host->lock);
+		sdhci_arasan->is_phy_on = false;
 	}
 
 	sdhci_set_clock(host, clock);
@@ -185,6 +223,7 @@ static void sdhci_arasan_set_clock(struct sdhci_host *host, unsigned int clock)
 		spin_unlock_irq(&host->lock);
 		phy_power_on(sdhci_arasan->phy);
 		spin_lock_irq(&host->lock);
+		sdhci_arasan->is_phy_on = true;
 	}
 }
 
@@ -239,13 +278,14 @@ static int sdhci_arasan_suspend(struct device *dev)
 	if (ret)
 		return ret;
 
-	if (!IS_ERR(sdhci_arasan->phy)) {
+	if (!IS_ERR(sdhci_arasan->phy) && sdhci_arasan->is_phy_on) {
 		ret = phy_power_off(sdhci_arasan->phy);
 		if (ret) {
 			dev_err(dev, "Cannot power off phy.\n");
 			sdhci_resume_host(host);
 			return ret;
 		}
+		sdhci_arasan->is_phy_on = false;
 	}
 
 	clk_disable(pltfm_host->clk);
@@ -281,12 +321,13 @@ static int sdhci_arasan_resume(struct device *dev)
 		return ret;
 	}
 
-	if (!IS_ERR(sdhci_arasan->phy)) {
+	if (!IS_ERR(sdhci_arasan->phy) && host->mmc->actual_clock) {
 		ret = phy_power_on(sdhci_arasan->phy);
 		if (ret) {
 			dev_err(dev, "Cannot power on phy.\n");
 			return ret;
 		}
+		sdhci_arasan->is_phy_on = true;
 	}
 
 	return sdhci_resume_host(host);
@@ -547,12 +588,6 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 			goto unreg_clk;
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
@@ -565,9 +600,6 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 
 err_add_host:
 	if (!IS_ERR(sdhci_arasan->phy))
-		phy_power_off(sdhci_arasan->phy);
-err_phy_power:
-	if (!IS_ERR(sdhci_arasan->phy))
 		phy_exit(sdhci_arasan->phy);
 unreg_clk:
 	sdhci_arasan_unregister_sdclk(&pdev->dev);
@@ -589,7 +621,8 @@ static int sdhci_arasan_remove(struct platform_device *pdev)
 	struct clk *clk_ahb = sdhci_arasan->clk_ahb;
 
 	if (!IS_ERR(sdhci_arasan->phy)) {
-		phy_power_off(sdhci_arasan->phy);
+		if (sdhci_arasan->is_phy_on)
+			phy_power_off(sdhci_arasan->phy);
 		phy_exit(sdhci_arasan->phy);
 	}
 
-- 
2.8.0.rc3.226.g39d4020
