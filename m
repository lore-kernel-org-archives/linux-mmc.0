From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 7/9 v4] mmc: tmio: support caps2 flags
Date: Fri, 22 Jun 2012 15:23:20 +0200
Message-ID: <1340371402-4801-8-git-send-email-g.liakhovetski@gmx.de>
References: <1340371402-4801-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1340371402-4801-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

Allow tmio mmc glue drivers pass mmc_host::caps2 flags down to the mmc
layer.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/tmio_mmc_pio.c |    1 +
 include/linux/mfd/tmio.h        |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index b204012f..f8df021 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -951,6 +951,7 @@ int __devinit tmio_mmc_host_probe(struct tmio_mmc_host **host,
 
 	mmc->ops = &tmio_mmc_ops;
 	mmc->caps = MMC_CAP_4_BIT_DATA | pdata->capabilities;
+	mmc->caps2 = pdata->capabilities2;
 	mmc->max_segs = 32;
 	mmc->max_blk_size = 512;
 	mmc->max_blk_count = (PAGE_CACHE_SIZE / mmc->max_blk_size) *
diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
index b332c4c..d83af39 100644
--- a/include/linux/mfd/tmio.h
+++ b/include/linux/mfd/tmio.h
@@ -101,6 +101,7 @@ struct tmio_mmc_host;
 struct tmio_mmc_data {
 	unsigned int			hclk;
 	unsigned long			capabilities;
+	unsigned long			capabilities2;
 	unsigned long			flags;
 	u32				ocr_mask;	/* available voltages */
 	struct tmio_mmc_dma		*dma;
-- 
1.7.2.5

