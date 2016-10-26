From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v2] mmc: s3cmci: Use DMA slave map rather than exported DMA
 filter
Date: Wed, 26 Oct 2016 18:30:53 +0200
Message-ID: <1477499453-22549-1-git-send-email-s.nawrocki@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: ulf.hansson@linaro.org, linux-samsung-soc@vger.kernel.org
Cc: sam.van.den.berge@telenet.be, arnd@arndb.de, linux-mmc@vger.kernel.org, b.zolnierkie@samsung.com, Sylwester Nawrocki <s.nawrocki@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Support for DMA slave map has been added to the s3c24xx-dma
controller in commit 34681d84a0f7cc22ded1413dc79eef8a2f23d9c3
"dmaengine: s3c24xx: Add dma_slave_map for s3c2440 devices"
This patch converts the s3cmci driver to also use it, so we can
eventually get rid of the exported filter function once all
related DMA clients are updated.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
Changes since v1:
 - dma_request_chan() used instead of dma_request_slave_channel()
   for better error handling.

 drivers/mmc/host/s3cmci.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index c531dee..932a4b1 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -28,7 +28,6 @@
 #include <mach/dma.h>
 #include <mach/gpio-samsung.h>

-#include <linux/platform_data/dma-s3c24xx.h>
 #include <linux/platform_data/mmc-s3cmci.h>

 #include "s3cmci.h"
@@ -1682,19 +1681,13 @@ static int s3cmci_probe(struct platform_device *pdev)
 		gpio_direction_input(host->pdata->gpio_wprotect);
 	}

-	/* depending on the dma state, get a dma channel to use. */
+	/* Depending on the dma state, get a DMA channel to use. */

 	if (s3cmci_host_usedma(host)) {
-		dma_cap_mask_t mask;
-
-		dma_cap_zero(mask);
-		dma_cap_set(DMA_SLAVE, mask);
-
-		host->dma = dma_request_slave_channel_compat(mask,
-			s3c24xx_dma_filter, (void *)DMACH_SDI, &pdev->dev, "rx-tx");
-		if (!host->dma) {
+		host->dma = dma_request_chan(&pdev->dev, "rx-tx");
+		ret = PTR_ERR_OR_ZERO(host->dma);
+		if (ret) {
 			dev_err(&pdev->dev, "cannot get DMA channel.\n");
-			ret = -EBUSY;
 			goto probe_free_gpio_wp;
 		}
 	}
--
1.9.1
