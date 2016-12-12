From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 7/9] mmc: sh_mobile_sdhi: enable HS200
Date: Mon, 12 Dec 2016 20:51:26 +0100
Message-ID: <20161212195128.16633-8-wsa+renesas@sang-engineering.com>
References: <20161212195128.16633-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20161212195128.16633-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-mmc@vger.kernel.org

Setup tuning when the board is HS200 enabled.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/sh_mobile_sdhi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 2bd17890ec4b77..c79545e4f69444 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -641,7 +641,9 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 		goto efree;
 
 	/* Enable tuning iff we have an SCC and a supported mode */
-	if (of_data && of_data->scc_offset && host->mmc->caps & MMC_CAP_UHS_SDR104) {
+	if (of_data && of_data->scc_offset &&
+	    (host->mmc->caps & MMC_CAP_UHS_SDR104 ||
+	     host->mmc->caps2 & MMC_CAP2_HS200_1_8V_SDR)) {
 		const struct sh_mobile_sdhi_scc *taps = of_data->taps;
 		bool hit = false;
 
-- 
2.10.2
