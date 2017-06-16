From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH mmc/next v2 1/4] mmc: tmio, renesas-sdhi: add max_{segs,blk_count} to tmio_mmc_data
Date: Fri, 16 Jun 2017 11:58:51 +0200
Message-ID: <1497607134-10241-2-git-send-email-horms+renesas@verge.net.au>
References: <1497607134-10241-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:45944 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753084AbdFPJ7F (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Jun 2017 05:59:05 -0400
In-Reply-To: <1497607134-10241-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Ai Kyuse <ai.kyuse.uw@renesas.com>, Simon Horman <horms+renesas@verge.net.au>

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Allow TMIO and SDHI driver implementations to provide values for
max_segs and max_blk_count.

A follow-up patch will set these values for Renesas Gen3 SoCs
the using an SDHI driver.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Ai Kyuse <ai.kyuse.uw@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
v2
* Enhanced changelog
* Include Renesas SDHI changes
---
 drivers/mmc/host/renesas_sdhi.h      | 2 ++
 drivers/mmc/host/renesas_sdhi_core.c | 2 ++
 drivers/mmc/host/tmio_mmc_core.c     | 6 +++---
 include/linux/mfd/tmio.h             | 2 ++
 4 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
index eb3ea15ff92d..6f7233fe32a2 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -31,6 +31,8 @@ struct renesas_sdhi_of_data {
 	int scc_offset;
 	struct renesas_sdhi_scc *taps;
 	int taps_num;
+	unsigned int max_blk_count;
+	unsigned short max_segs;
 };
 
 int renesas_sdhi_probe(struct platform_device *pdev,
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index f4690cba3443..75c7bf4f7ca2 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -523,6 +523,8 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 		mmc_data->capabilities |= of_data->capabilities;
 		mmc_data->capabilities2 |= of_data->capabilities2;
 		mmc_data->dma_rx_offset = of_data->dma_rx_offset;
+		mmc_data->max_blk_count = of_data->max_blk_count;
+		mmc_data->max_segs = of_data->max_segs;
 		dma_priv->dma_buswidth = of_data->dma_buswidth;
 		host->bus_shift = of_data->bus_shift;
 	}
diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index fbe38464e7d7..7cb8d3510396 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -1248,10 +1248,10 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
 
 	mmc->caps |= MMC_CAP_4_BIT_DATA | pdata->capabilities;
 	mmc->caps2 |= pdata->capabilities2;
-	mmc->max_segs = 32;
+	mmc->max_segs = pdata->max_segs ? : 32;
 	mmc->max_blk_size = 512;
-	mmc->max_blk_count = (PAGE_SIZE / mmc->max_blk_size) *
-		mmc->max_segs;
+	mmc->max_blk_count = pdata->max_blk_count ? :
+		(PAGE_SIZE / mmc->max_blk_size) * mmc->max_segs;
 	mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
 	mmc->max_seg_size = mmc->max_req_size;
 
diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
index c83c16b931a8..4e261ea94d6a 100644
--- a/include/linux/mfd/tmio.h
+++ b/include/linux/mfd/tmio.h
@@ -128,6 +128,8 @@ struct tmio_mmc_data {
 	unsigned int			cd_gpio;
 	int				alignment_shift;
 	dma_addr_t			dma_rx_offset;
+	unsigned int			max_blk_count;
+	unsigned short			max_segs;
 	void (*set_pwr)(struct platform_device *host, int state);
 	void (*set_clk_div)(struct platform_device *host, int state);
 };
-- 
2.1.4

