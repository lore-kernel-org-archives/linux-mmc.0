From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v2 2/2] mmc: renesas_sdhi: fix kernel panic in _internal_dmac.c
Date: Fri, 20 Oct 2017 12:12:42 +0900
Message-ID: <1508469162-12322-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1508469162-12322-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relmlor2.renesas.com ([210.160.252.172]:36072 "EHLO
        relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751125AbdJTDQr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Oct 2017 23:16:47 -0400
In-Reply-To: <1508469162-12322-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: wsa+renesas@sang-engineering.com, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Since this driver checks if the return value of dma_map_sg() is minus
or not and keeps to enable the DMAC, it may cause kernel panic when
the dma_map_sg() returns 0. So, this patch fixes the issue.

Reported-by: Dirk Behme <dirk.behme@de.bosch.com>
Fixes: 2a68ea7896e3 ("mmc: renesas-sdhi: add support for R-Car Gen3 SDHI DMAC")
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index f905f23..8bae88a 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -146,11 +146,8 @@
 	WARN_ON(host->sg_len > 1);
 
 	/* This DMAC cannot handle if buffer is not 8-bytes alignment */
-	if (!IS_ALIGNED(sg->offset, 8)) {
-		host->force_pio = true;
-		renesas_sdhi_internal_dmac_enable_dma(host, false);
-		return;
-	}
+	if (!IS_ALIGNED(sg->offset, 8))
+		goto force_pio;
 
 	if (data->flags & MMC_DATA_READ) {
 		dtran_mode |= DTRAN_MODE_CH_NUM_CH1;
@@ -163,8 +160,8 @@
 	}
 
 	ret = dma_map_sg(&host->pdev->dev, sg, host->sg_len, dir);
-	if (ret < 0)
-		return;
+	if (ret == 0)
+		goto force_pio;
 
 	renesas_sdhi_internal_dmac_enable_dma(host, true);
 
@@ -176,6 +173,12 @@
 					    dtran_mode);
 	renesas_sdhi_internal_dmac_dm_write(host, DM_DTRAN_ADDR,
 					    sg->dma_address);
+
+	return;
+
+force_pio:
+	host->force_pio = true;
+	renesas_sdhi_internal_dmac_enable_dma(host, false);
 }
 
 static void renesas_sdhi_internal_dmac_issue_tasklet_fn(unsigned long arg)
-- 
1.9.1

