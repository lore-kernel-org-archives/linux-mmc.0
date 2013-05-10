From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 3/3] mmc: omap_hsmmc: Skip platform_get_resource_byname() for dt case
Date: Fri, 10 May 2013 17:42:35 +0530
Message-ID: <1368187955-13069-4-git-send-email-balajitk@ti.com>
References: <1368187955-13069-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1368187955-13069-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Balaji T K <balajitk@ti.com>
List-Id: linux-mmc@vger.kernel.org

From: Santosh Shilimkar <santosh.shilimkar@ti.com>

MMC driver probe will abort for DT case because of failed
platform_get_resource_byname() lookup. Fix it by skipping resource
lookup byname for device tree build.

Issue is hidden because hwmod populates the IO resources which
helps to succeed platform_get_resource_byname() and probe.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Balaji T K <balajitk@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |   28 +++++++++++++++-------------
 1 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index dc89aea..eccedc7 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1911,21 +1911,23 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 
 	omap_hsmmc_conf_bus_power(host);
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "tx");
-	if (!res) {
-		dev_err(mmc_dev(host->mmc), "cannot get DMA TX channel\n");
-		ret = -ENXIO;
-		goto err_irq;
-	}
-	tx_req = res->start;
+	if (!pdev->dev.of_node) {
+		res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "tx");
+		if (!res) {
+			dev_err(mmc_dev(host->mmc), "cannot get DMA TX channel\n");
+			ret = -ENXIO;
+			goto err_irq;
+		}
+		tx_req = res->start;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "rx");
-	if (!res) {
-		dev_err(mmc_dev(host->mmc), "cannot get DMA RX channel\n");
-		ret = -ENXIO;
-		goto err_irq;
+		res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "rx");
+		if (!res) {
+			dev_err(mmc_dev(host->mmc), "cannot get DMA RX channel\n");
+			ret = -ENXIO;
+			goto err_irq;
+		}
+		rx_req = res->start;
 	}
-	rx_req = res->start;
 
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
-- 
1.7.5.4

