From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH] MMC: tmio: fix a recent regression: restore .set_ios(MMC_POWER_UP)
 handling
Date: Thu, 21 Apr 2011 09:09:59 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1104210903250.6893@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <damm@opensource.se>, Simon Horman <horms@verge.net.au>, Ian Molton <ian@mnementh.co.uk>, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

The aggressive clock gating for TMIO MMC patch has broken switching
interface power on, using MFD or platform callbacks. Restore the
ios->power_mode == MMC_POWER_UP && ios->clock == 0 case handling.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

This one should go in 2.6.39

 drivers/mmc/host/tmio_mmc_pio.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 6e3271d..f4fac9f 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -772,15 +772,15 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		tmio_mmc_set_clock(host, ios->clock);
 
 	/* Power sequence - OFF -> UP -> ON */
-	if (ios->power_mode == MMC_POWER_OFF || !ios->clock) {
+	if (ios->power_mode == MMC_POWER_UP) {
+		/* power up SD bus */
+		if (host->set_pwr)
+			host->set_pwr(host->pdev, 1);
+	} else if (ios->power_mode == MMC_POWER_OFF || !ios->clock) {
 		/* power down SD bus */
 		if (ios->power_mode == MMC_POWER_OFF && host->set_pwr)
 			host->set_pwr(host->pdev, 0);
 		tmio_mmc_clk_stop(host);
-	} else if (ios->power_mode == MMC_POWER_UP) {
-		/* power up SD bus */
-		if (host->set_pwr)
-			host->set_pwr(host->pdev, 1);
 	} else {
 		/* start bus clock */
 		tmio_mmc_clk_start(host);
-- 
1.7.2.5

