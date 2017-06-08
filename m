From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH/RFC 1/5] mmc: tmio: add max_segs and max_blk_count in tmio_mmc_data
Date: Thu,  8 Jun 2017 15:09:22 +0200
Message-ID: <1496927368-18897-2-git-send-email-horms+renesas@verge.net.au>
References: <1496927368-18897-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1496927368-18897-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Ai Kyuse <ai.kyuse.uw@renesas.com>, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

To change each value from related driver (e.g. sh_mobile_sdhi driver),
this patch adds these member in the struct tmio_mmc_data.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Ai Kyuse <ai.kyuse.uw@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/mmc/host/tmio_mmc_core.c | 6 +++---
 include/linux/mfd/tmio.h         | 2 ++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index ed4068125349..0e76e099dc7f 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -1247,10 +1247,10 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
 
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
