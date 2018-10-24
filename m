From: Michael Thalmeier <michael.thalmeier@hale.at>
Subject: [PATCH] Revert "mmc: mxs: fix card detection in case of 'broken-cd' flag set"
Date: Wed, 24 Oct 2018 16:10:08 +0200
Message-ID: <20181024141008.30312-1-michael.thalmeier@hale.at>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Roman Peniaev <r.peniaev@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, michael@thalmeier.at
List-Id: linux-mmc@vger.kernel.org

This reverts commit 6f726f495f2d ("mmc: mxs: fix card detection in case of 'broken-cd' flag set").

Since mxs_mmc_probe always sets MMC_CAP_NEEDS_POLL unconditionally, card
detect is not working properly any more since commit 6f726f495f2d.
Instead of querying the card detect status mxs_mmc_get_cd now always
returns 1 which causes probing commands being sent to the mmc card.

The expected behaviour of commit 6f726f495f2d should be reachable by setting
broken_cd instead.

Signed-off-by: Michael Thalmeier <michael.thalmeier@hale.at>
---
 drivers/mmc/host/mxs-mmc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index add1e70..cfdae61 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -86,8 +86,7 @@ static int mxs_mmc_get_cd(struct mmc_host *mmc)
 	if (ret >= 0)
 		return ret;
 
-	present = mmc->caps & MMC_CAP_NEEDS_POLL ||
-		!(readl(ssp->base + HW_SSP_STATUS(ssp)) &
+	present = !(readl(ssp->base + HW_SSP_STATUS(ssp)) &
 			BM_SSP_STATUS_CARD_DETECT);
 
 	if (mmc->caps2 & MMC_CAP2_CD_ACTIVE_HIGH)
-- 
2.9.2
