From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH] mmc: s3cmci: Use DMA slave map rather than exported DMA filter
Date: Wed, 26 Oct 2016 11:08:27 +0200
Message-ID: <1477472907-5932-1-git-send-email-s.nawrocki@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: ulf.hansson@linaro.org, linux-samsung-soc@vger.kernel.org
Cc: sam.van.den.berge@telenet.be, linux-mmc@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Support for DMA slave map has been added to the s3c24xx-dma
controller in commit 34681d84a0f7cc22ded1413dc79eef8a2f23d9c3
"dmaengine: s3c24xx: Add dma_slave_map for s3c2440 devices"
This patch converts the s3cmci driver to also use it, so we can
eventually get rid of the exported filter function once all
DMA related clients are updated.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 drivers/mmc/host/s3cmci.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index c531dee..c109e57 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -28,7 +28,6 @@
 #include <mach/dma.h>
 #include <mach/gpio-samsung.h>
 
-#include <linux/platform_data/dma-s3c24xx.h>
 #include <linux/platform_data/mmc-s3cmci.h>
 
 #include "s3cmci.h"
@@ -1685,13 +1684,7 @@ static int s3cmci_probe(struct platform_device *pdev)
 	/* depending on the dma state, get a dma channel to use. */
 
 	if (s3cmci_host_usedma(host)) {
-		dma_cap_mask_t mask;
-
-		dma_cap_zero(mask);
-		dma_cap_set(DMA_SLAVE, mask);
-
-		host->dma = dma_request_slave_channel_compat(mask,
-			s3c24xx_dma_filter, (void *)DMACH_SDI, &pdev->dev, "rx-tx");
+		host->dma = dma_request_slave_channel(&pdev->dev, "rx-tx");
 		if (!host->dma) {
 			dev_err(&pdev->dev, "cannot get DMA channel.\n");
 			ret = -EBUSY;
-- 
1.9.1
