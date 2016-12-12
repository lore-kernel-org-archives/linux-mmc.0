From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 2/9] mmc: sh_mobile_sdhi: improve prerequisite for hw_reset
Date: Mon, 12 Dec 2016 20:51:21 +0100
Message-ID: <20161212195128.16633-3-wsa+renesas@sang-engineering.com>
References: <20161212195128.16633-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20161212195128.16633-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-mmc@vger.kernel.org

We need a SCC unit for hw_reset. Those units can only be described in
of_data. So, of_data and a valid SCC offset are prerequisites for
enabling the hw_reset capability. Merge the two 'if' conditions into one
and add a check for an scc offset.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/sh_mobile_sdhi.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index b48e3ae4549b6b..f3ea2c8b12040c 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -656,27 +656,25 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto efree;
 
-	if (host->mmc->caps & MMC_CAP_UHS_SDR104) {
+	if (of_data && of_data->scc_offset && host->mmc->caps & MMC_CAP_UHS_SDR104) {
+		const struct sh_mobile_sdhi_scc *taps = of_data->taps;
+		bool hit = false;
+
 		host->mmc->caps |= MMC_CAP_HW_RESET;
 
-		if (of_data) {
-			const struct sh_mobile_sdhi_scc *taps = of_data->taps;
-			bool hit = false;
-
-			for (i = 0; i < of_data->taps_num; i++) {
-				if (taps[i].clk_rate == 0 ||
-				    taps[i].clk_rate == host->mmc->f_max) {
-					host->scc_tappos = taps->tap;
-					hit = true;
-					break;
-				}
+		for (i = 0; i < of_data->taps_num; i++) {
+			if (taps[i].clk_rate == 0 ||
+			    taps[i].clk_rate == host->mmc->f_max) {
+				host->scc_tappos = taps->tap;
+				hit = true;
+				break;
 			}
+		}
 
-			if (!hit)
-				dev_warn(&host->pdev->dev, "Unknown clock rate for SDR104\n");
+		if (!hit)
+			dev_warn(&host->pdev->dev, "Unknown clock rate for SDR104\n");
 
-			priv->scc_ctl = host->ctl + of_data->scc_offset;
-		}
+		priv->scc_ctl = host->ctl + of_data->scc_offset;
 	}
 
 	i = 0;
-- 
2.10.2
