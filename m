From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH] Revert "mmc: meson-gx: include tx phase in the tuning process"
Date: Mon, 12 Feb 2018 14:13:59 +0100
Message-ID: <20180212131359.7741-1-jbrunet@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

This reverts commit 0a44697627d17a66d7dc98f17aeca07ca79c5c20.

This commit was initially intended to fix problems with hs200 and hs400
on some boards, mainly the odroid-c2. The OC2 (Rev 0.2) I have performs
well in this modes, so I could not confirm these issues.

We've had several reports about the issues being still present on (some)
OC2, so apparently, this change does not do what it was supposed to do.
Maybe the eMMC signal quality is on the edge on the board. This may
explain the variability we see in term of stability, but this is just a
guess. Lowering the max_frequency to 100Mhz seems to do trick for those
affected by the issue

Worse, the commit created new issues (CRC errors and hangs) on other
boards, such as the kvim 1 and 2, the p200 or the libretech-cc.

According to amlogic, the Tx phase should not be tuned and left in its
default configuration, so it is best to just revert the commit.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 22438ebfe4e6..4f972b879fe6 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -717,22 +717,6 @@ static int meson_mmc_clk_phase_tuning(struct mmc_host *mmc, u32 opcode,
 static int meson_mmc_execute_tuning(struct mmc_host *mmc, u32 opcode)
 {
 	struct meson_host *host = mmc_priv(mmc);
-	int ret;
-
-	/*
-	 * If this is the initial tuning, try to get a sane Rx starting
-	 * phase before doing the actual tuning.
-	 */
-	if (!mmc->doing_retune) {
-		ret = meson_mmc_clk_phase_tuning(mmc, opcode, host->rx_clk);
-
-		if (ret)
-			return ret;
-	}
-
-	ret = meson_mmc_clk_phase_tuning(mmc, opcode, host->tx_clk);
-	if (ret)
-		return ret;
 
 	return meson_mmc_clk_phase_tuning(mmc, opcode, host->rx_clk);
 }
@@ -763,9 +747,8 @@ static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		if (!IS_ERR(mmc->supply.vmmc))
 			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, ios->vdd);
 
-		/* Reset phases */
+		/* Reset rx phase */
 		clk_set_phase(host->rx_clk, 0);
-		clk_set_phase(host->tx_clk, 270);
 
 		break;
 
-- 
2.14.3
