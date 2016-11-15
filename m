From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCHv2 03/10] mmc: dw_mmc: change the DW_MCI_FREQ_MIN from 400K to
 100K
Date: Tue, 15 Nov 2016 19:12:25 +0900
Message-ID: <20161115101232.3854-4-jh80.chung@samsung.com>
References: <20161115101232.3854-1-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:60899 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941609AbcKOKMo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Nov 2016 05:12:44 -0500
In-reply-to: <20161115101232.3854-1-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: devicetree@vger.kernel.org, ulf.hansson@linaro.org, heiko@sntech.de, shawn.lin@rock-chips.com, robh+dt@kernel.org, Jaehoon Chung <jh80.chung@samsung.com>

If there is no property "clock-freq-min-max", mmc->f_min should be set
to 400K by default. But Some SoC can be used 100K.
When 100K is used, MMC core will try to check from 400K to 100K.

Reported-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Tested-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/mmc/host/dw_mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 6c0c4c5..be36f48 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -54,7 +54,7 @@
 #define DW_MCI_DMA_THRESHOLD	16
 
 #define DW_MCI_FREQ_MAX	200000000	/* unit: HZ */
-#define DW_MCI_FREQ_MIN	400000		/* unit: HZ */
+#define DW_MCI_FREQ_MIN	100000		/* unit: HZ */
 
 #define IDMAC_INT_CLR		(SDMMC_IDMAC_INT_AI | SDMMC_IDMAC_INT_NI | \
 				 SDMMC_IDMAC_INT_CES | SDMMC_IDMAC_INT_DU | \
-- 
2.10.1

