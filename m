From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 4/9] mmc: sh_mobile_sdhi: remove superfluous check in hw_reset
Date: Mon, 12 Dec 2016 20:51:23 +0100
Message-ID: <20161212195128.16633-5-wsa+renesas@sang-engineering.com>
References: <20161212195128.16633-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20161212195128.16633-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-mmc@vger.kernel.org

The capability for HW_RESET is only activated if SDR104 is present, so
no need to check for SDR104 in the function itself again.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/sh_mobile_sdhi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 96ebe985d5cdc6..7964f9a87d9c20 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -460,9 +460,6 @@ static void sh_mobile_sdhi_hw_reset(struct tmio_mmc_host *host)
 {
 	struct sh_mobile_sdhi *priv;
 
-	if (!(host->mmc->caps & MMC_CAP_UHS_SDR104))
-		return;
-
 	priv = host_to_priv(host);
 
 	/* Reset SCC */
-- 
2.10.2
