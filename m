From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] mmc: dw_mmc: exynos: fix the NULL pointer dereference error
Date: Mon, 20 Jun 2016 13:16:09 +0900
Message-ID: <1466396169-26703-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:51160 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751524AbcFTERC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jun 2016 00:17:02 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0O91001EDYIZIYC0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 20 Jun 2016 13:16:11 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, shawn.lin@rock-chips.com, Jaehoon Chung <jh80.chung@samsung.com>

"host->cur_slot" should be assigned to start the request.
So it can be the NULL pointer. This patch fixed this error.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/dw_mmc-exynos.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index 7e3a324..da0ef17 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -157,7 +157,7 @@ static void dw_mci_exynos_set_clksel_timing(struct dw_mci *host, u32 timing)
 	 * HOLD register should be bypassed in case there is no phase shift
 	 * applied on CMD/DATA that is sent to the card.
 	 */
-	if (!SDMMC_CLKSEL_GET_DRV_WD3(clksel))
+	if (!SDMMC_CLKSEL_GET_DRV_WD3(clksel) && host->cur_slot)
 		set_bit(DW_MMC_CARD_NO_USE_HOLD, &host->cur_slot->flags);
 }
 
-- 
1.9.1

