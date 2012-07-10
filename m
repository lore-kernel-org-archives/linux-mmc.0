From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH] mmc: omap_hsmmc: ensure probe returns error upon resource failure
Date: Tue, 10 Jul 2012 16:40:56 -0700
Message-ID: <1341963658-20896-1-git-send-email-khilman@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Venkatraman S <svenkatr@ti.com>, linux-mmc@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Balaji T K <balajitk@ti.com>, Rajendra Nayak <rnayak@ti.com>, Adrian Hunter <adrian.hunter@intel.com>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

If platform_get_resource_by_name() fails, driver probe is aborted an
should return an error so the driver is not bound to the device.

However, in the current error path of platform_get_resource_by_name(),
probe returns zero since the return value (ret) is not properly set.
With a zero return value, the driver core assumes probe was successful
and will bind the driver to the device.

Fix this by ensuring that probe returns an error code in this failure
path.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 389a3ee..19e60e9 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1931,6 +1931,7 @@ static int __devinit omap_hsmmc_probe(struct platform_device *pdev)
 	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "tx");
 	if (!res) {
 		dev_err(mmc_dev(host->mmc), "cannot get DMA TX channel\n");
+		ret = -ENXIO;
 		goto err_irq;
 	}
 	host->dma_line_tx = res->start;
@@ -1938,6 +1939,7 @@ static int __devinit omap_hsmmc_probe(struct platform_device *pdev)
 	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "rx");
 	if (!res) {
 		dev_err(mmc_dev(host->mmc), "cannot get DMA RX channel\n");
+		ret = -ENXIO;
 		goto err_irq;
 	}
 	host->dma_line_rx = res->start;
-- 
1.7.9.2
