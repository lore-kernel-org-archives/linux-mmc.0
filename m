From: Joe Perches <joe@perches.com>
Subject: [PATCH -next 09/26] mmc: Use dma_zalloc_coherent
Date: Sun, 15 Jun 2014 13:37:38 -0700
Message-ID: <1bcfedf9f6f944be57f4076d8b248a9f248a3f5d.1402863905.git.joe@perches.com>
References: <cover.1402863904.git.joe@perches.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1402863904.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: David Brown <davidb@codeaurora.org>, Daniel Walker <dwalker@fifo99.com>, Bryan Huntsman <bryanh@codeaurora.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Use the zeroing function instead of dma_alloc_coherent & memset(,0,)

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/mmc/host/msm_sdcc.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/msm_sdcc.c b/drivers/mmc/host/msm_sdcc.c
index 9405ecd..3035d84 100644
--- a/drivers/mmc/host/msm_sdcc.c
+++ b/drivers/mmc/host/msm_sdcc.c
@@ -1146,15 +1146,13 @@ msmsdcc_init_dma(struct msmsdcc_host *host)
 	if (!host->dmares)
 		return -ENODEV;
 
-	host->dma.nc = dma_alloc_coherent(NULL,
-					  sizeof(struct msmsdcc_nc_dmadata),
-					  &host->dma.nc_busaddr,
-					  GFP_KERNEL);
+	host->dma.nc = dma_zalloc_coherent(NULL,
+					   sizeof(struct msmsdcc_nc_dmadata),
+					   &host->dma.nc_busaddr, GFP_KERNEL);
 	if (host->dma.nc == NULL) {
 		pr_err("Unable to allocate DMA buffer\n");
 		return -ENOMEM;
 	}
-	memset(host->dma.nc, 0x00, sizeof(struct msmsdcc_nc_dmadata));
 	host->dma.cmd_busaddr = host->dma.nc_busaddr;
 	host->dma.cmdptr_busaddr = host->dma.nc_busaddr +
 				offsetof(struct msmsdcc_nc_dmadata, cmdptr);
-- 
1.8.1.2.459.gbcd45b4.dirty
