From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH/RFC v2 3/5] mmc: tmio: add max_segs and max_blk_count in tmio_mmc_data
Date: Thu, 30 Jun 2016 00:05:38 +0200
Message-ID: <1467237940-24388-4-git-send-email-horms+renesas@verge.net.au>
References: <1467237940-24388-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1467237940-24388-1-git-send-email-horms+renesas@verge.net.au>
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
v2
* First post
---
 drivers/mmc/host/tmio_mmc_pio.c | 2 +-
 include/linux/mfd/tmio.h        | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index c0020c331595..39dd8402e126 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -1124,7 +1124,7 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
 
 	mmc->caps |= MMC_CAP_4_BIT_DATA | pdata->capabilities;
 	mmc->caps2 |= pdata->capabilities2;
-	mmc->max_segs = 32;
+	mmc->max_segs = pdata->max_segs ? pdata->max_segs : 32;
 	mmc->max_blk_size = 512;
 	mmc->max_blk_count = (PAGE_SIZE / mmc->max_blk_size) *
 		mmc->max_segs;
diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
index 7a26286db895..3b95dc7eb314 100644
--- a/include/linux/mfd/tmio.h
+++ b/include/linux/mfd/tmio.h
@@ -125,6 +125,8 @@ struct tmio_mmc_data {
 	unsigned int			cd_gpio;
 	int				alignment_shift;
 	dma_addr_t			dma_rx_offset;
+	unsigned int			max_blk_count;
+	unsigned short			max_segs;
 	void (*set_pwr)(struct platform_device *host, int state);
 	void (*set_clk_div)(struct platform_device *host, int state);
 };
-- 
2.7.0.rc3.207.g0ac5344
