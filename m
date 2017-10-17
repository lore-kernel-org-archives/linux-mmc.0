From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 2/2] mmc: renesas_sdhi: fix kernel panic in _internal_dmac.c
Date: Tue, 17 Oct 2017 16:30:21 +0900
Message-ID: <1508225421-25405-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1508225421-25405-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1508225421-25405-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: wsa+renesas@sang-engineering.com, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
List-Id: linux-mmc@vger.kernel.org

Since this driver checks if the return value of dma_map_sg() is minus
or not and keeps to enable the DMAC, it may cause kernel panic when
the dma_map_sg() returns 0. So, this patch fixes the issue.

Reported-by: Dirk Behme <dirk.behme@de.bosch.com>
Fixes: 2a68ea7896e3 ("mmc: renesas-sdhi: add support for R-Car Gen3 SDHI DMAC")
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 6c9b4b2..378fe88 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -147,11 +147,8 @@
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
@@ -164,8 +161,8 @@
 	}
 
 	ret = dma_map_sg(&host->pdev->dev, sg, host->sg_len, dir);
-	if (ret < 0)
-		return;
+	if (ret == 0)
+		goto force_pio;
 
 	renesas_sdhi_internal_dmac_enable_dma(host, true);
 
@@ -177,6 +174,12 @@
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
