From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 1/9] mmc: sh_mobile_sdhi: simplify accessing DT data
Date: Mon, 12 Dec 2016 20:51:20 +0100
Message-ID: <20161212195128.16633-2-wsa+renesas@sang-engineering.com>
References: <20161212195128.16633-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20161212195128.16633-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-mmc@vger.kernel.org

By using the helper of_device_get_match_data(), we can skip some
checking and make the code simpler.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/sh_mobile_sdhi.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 15c77bc6e4ee72..b48e3ae4549b6b 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -548,8 +548,7 @@ static void sh_mobile_sdhi_enable_dma(struct tmio_mmc_host *host, bool enable)
 
 static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *of_id =
-		of_match_device(sh_mobile_sdhi_of_match, &pdev->dev);
+	const struct sh_mobile_sdhi_of_data *of_data = of_device_get_match_data(&pdev->dev);
 	struct sh_mobile_sdhi *priv;
 	struct tmio_mmc_data *mmc_data;
 	struct tmio_mmc_data *mmd = pdev->dev.platform_data;
@@ -590,9 +589,7 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 		goto eprobe;
 	}
 
-	if (of_id && of_id->data) {
-		const struct sh_mobile_sdhi_of_data *of_data = of_id->data;
-
+	if (of_data) {
 		mmc_data->flags |= of_data->tmio_flags;
 		mmc_data->capabilities |= of_data->capabilities;
 		mmc_data->capabilities2 |= of_data->capabilities2;
@@ -662,14 +659,10 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 	if (host->mmc->caps & MMC_CAP_UHS_SDR104) {
 		host->mmc->caps |= MMC_CAP_HW_RESET;
 
-		if (of_id && of_id->data) {
-			const struct sh_mobile_sdhi_of_data *of_data;
-			const struct sh_mobile_sdhi_scc *taps;
+		if (of_data) {
+			const struct sh_mobile_sdhi_scc *taps = of_data->taps;
 			bool hit = false;
 
-			of_data = of_id->data;
-			taps = of_data->taps;
-
 			for (i = 0; i < of_data->taps_num; i++) {
 				if (taps[i].clk_rate == 0 ||
 				    taps[i].clk_rate == host->mmc->f_max) {
-- 
2.10.2
