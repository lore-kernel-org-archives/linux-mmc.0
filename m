From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 07/10 v3] mmc: tmio: support caps2 flags
Date: Fri, 25 May 2012 17:45:42 +0200
Message-ID: <1337960752-4944-28-git-send-email-g.liakhovetski@gmx.de>
References: <Pine.LNX.4.64.1205251727260.13353@axis700.grange>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1205251727260.13353@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Allow tmio mmc glue drivers pass mmc_host::caps2 flags down to the mmc
layer.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/tmio_mmc_pio.c |    1 +
 include/linux/mfd/tmio.h        |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 5261934..5509554 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -947,6 +947,7 @@ int __devinit tmio_mmc_host_probe(struct tmio_mmc_host **host,
 
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

--
To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
