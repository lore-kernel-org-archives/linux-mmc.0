From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 1/1] mmc: omap_hsmmc: DMA unmap only once in case of MMC error
Date: Mon, 7 Nov 2011 21:55:11 +0530
Message-ID: <1320683111-12577-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org
Cc: linux-omap@vger.kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, Per Forlin <per.forlin@linaro.org>
List-Id: linux-mmc@vger.kernel.org

From: Per Forlin <per.forlin@linaro.org>

Reported by Russell King:
mmcblk0: error -84 transferring data, sector 149201, nr 64,
cmd response 0x900, card status 0xb00
mmcblk0: retrying using single block read

WARNING: at lib/dma-debug.c:811 check_unmap
omap_hsmmc omap_hsmmc.0: DMA-API: device driver tries to free DMA memory
it has not allocated [device address=0x0000000080933000] [size=20480 bytes]

In case of an error dma_unmap() is issued in omap_hsmmc_dma_cleanup()
and then again in omap_hsmmc_post_req(). Resolve this by clearing the
host_cookie to indicate there is no DMA mapped memory to unmap.

Signed-off-by: Per Forlin <per.forlin@linaro.org>
Tested-by: Balaji T K <balajitk@ti.com>
---
Repost with my Tested-by

 drivers/mmc/host/omap_hsmmc.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 101cd31..d5fe43d 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1010,6 +1010,7 @@ static void omap_hsmmc_dma_cleanup(struct omap_hsmmc_host *host, int errno)
 			host->data->sg_len,
 			omap_hsmmc_get_dma_dir(host, host->data));
 		omap_free_dma(dma_ch);
+		host->data->host_cookie = 0;
 	}
 	host->data = NULL;
 }
@@ -1575,8 +1576,10 @@ static void omap_hsmmc_post_req(struct mmc_host *mmc, struct mmc_request *mrq,
 	struct mmc_data *data = mrq->data;
 
 	if (host->use_dma) {
-		dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
-			     omap_hsmmc_get_dma_dir(host, data));
+		if (data->host_cookie)
+			dma_unmap_sg(mmc_dev(host->mmc), data->sg,
+				     data->sg_len,
+				     omap_hsmmc_get_dma_dir(host, data));
 		data->host_cookie = 0;
 	}
 }
-- 
1.7.0.4

