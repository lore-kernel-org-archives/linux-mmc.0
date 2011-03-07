From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH/RFC 5/5] mmc: tmio: support aggressive clock gating
Date: Mon, 7 Mar 2011 19:48:03 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1103071946080.29543@axis700.grange>
References: <Pine.LNX.4.64.1103071937010.29543@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1103071937010.29543@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ian Molton <ian@mnementh.co.uk>
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

_Must_ be tested on non-SDHI systems with and without aggressive clock 
gating enabled.

 drivers/mmc/host/tmio_mmc.c |   17 ++++++++---------
 1 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index 5e880c06..13e447a 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -1155,19 +1155,18 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		tmio_mmc_set_clock(host, ios->clock);
 
 	/* Power sequence - OFF -> UP -> ON */
-	switch (ios->power_mode) {
-	case MMC_POWER_OFF: /* power down SD bus */
-		if (host->set_pwr)
+	if (ios->power_mode == MMC_POWER_OFF || !ios->clock) {
+		/* power down SD bus */
+		if (ios->power_mode == MMC_POWER_OFF && host->set_pwr)
 			host->set_pwr(host->pdev, 0);
 		tmio_mmc_clk_stop(host);
-		break;
-	case MMC_POWER_ON: /* start bus clock */
-		tmio_mmc_clk_start(host);
-		break;
-	case MMC_POWER_UP: /* power up SD bus */
+	} else if (ios->power_mode == MMC_POWER_UP) {
+		/* power up SD bus */
 		if (host->set_pwr)
 			host->set_pwr(host->pdev, 1);
-		break;
+	} else {
+		/* start bus clock */
+		tmio_mmc_clk_start(host);
 	}
 
 	switch (ios->bus_width) {
-- 
1.7.2.3

