From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH/RFC 2/5] mmc: sh_mobile_sdhi: set max_segs and max_blk_count values R-Car Gen3
Date: Thu,  8 Jun 2017 15:13:12 +0200
Message-ID: <1496927595-19521-3-git-send-email-horms+renesas@verge.net.au>
References: <1496927595-19521-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1496927595-19521-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Ai Kyuse <ai.kyuse.uw@renesas.com>
List-Id: linux-mmc@vger.kernel.org

To avoid complicate code in own dma code for gen3, this patch
adds set max_segs to 1. Then, the tmio driver will get requests
as sg_len = 1 only.

In the performance point of view, the CONFIG_MMC_BLOCK_BOUNCE should
be set. Otherwise, mmc block layer will set 4-kbyte each as a request.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Ai Kyuse <ai.kyuse.uw@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/mmc/host/renesas_sdhi.h      | 2 ++
 drivers/mmc/host/renesas_sdhi_core.c | 2 ++
 2 files changed, 4 insertions(+)

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
index 82150a966391..294bc9705c5f 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -522,6 +522,8 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 		mmc_data->capabilities |= of_data->capabilities;
 		mmc_data->capabilities2 |= of_data->capabilities2;
 		mmc_data->dma_rx_offset = of_data->dma_rx_offset;
+		mmc_data->max_blk_count = of_data->max_blk_count;
+		mmc_data->max_segs = of_data->max_segs;
 		dma_priv->dma_buswidth = of_data->dma_buswidth;
 		host->bus_shift = of_data->bus_shift;
 	}
-- 
2.1.4
