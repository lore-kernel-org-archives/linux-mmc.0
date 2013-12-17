From: Sergei Ianovich <ynvich@gmail.com>
Subject: [PATCH v3 07/21] ARM: dts: parse DMA config in pxamci
Date: Tue, 17 Dec 2013 23:37:37 +0400
Message-ID: <1387309071-22382-8-git-send-email-ynvich@gmail.com>
References: <1386901645-28895-1-git-send-email-ynvich@gmail.com>
 <1387309071-22382-1-git-send-email-ynvich@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1387309071-22382-1-git-send-email-ynvich@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Sergei Ianovich <ynvich@gmail.com>, Daniel Mack <zonque@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Chris Ball <cjb@laptop.org>, Mark Brown <broonie@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Jingoo Han <jg1.han@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

The existing PXA MMC driver cannot get DMA channels in a proper
way from the respective device tree binding.

This patch provides temporary workaround which allows using the
existing driver in DT machines by pointing to the proper
dmaengine-based "marvell,pdma-1.0" DMA.

Even though the new DMA provider is not present we can parse device node
attributes manually and use channel numbers to acquire DMA channel
from the existing non-dmaengine provider.

When Daniel's DMA series is merged there will be no need to manually
parse for "dmas" and this patch can be safely reverted.

Signed-off-by: Sergei Ianovich <ynvich@gmail.com>
CC: Daniel Mack <zonque@gmail.com>
CC: Arnd Bergmann <arnd@arndb.de>
---
   v2..v3
   * split into good (PATCH 07/21) and temporary (this one) parts

   v1..v2
   * add binding for next-gen dma controller
   * use correct dma declararion
   * number changed from 5 to 3

 drivers/mmc/host/pxamci.c | 59 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 48 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
index 32fe113..6b67764 100644
--- a/drivers/mmc/host/pxamci.c
+++ b/drivers/mmc/host/pxamci.c
@@ -613,11 +613,46 @@ static int pxamci_of_init(struct platform_device *pdev)
 
         return 0;
 }
+
+static int pxamci_of_init_dma(struct platform_device *pdev,
+		struct pxamci_host *host)
+{
+	struct device_node *np = pdev->dev.of_node;
+	u32 tmp;
+	int i;
+	int ret;
+
+	i = of_property_match_string(np, "dma-names", "rx");
+	if (i < 0)
+		return i;
+
+	ret = of_property_read_u32_index(np, "dmas", 2 * i + 1, &tmp);
+	if (ret < 0)
+		return ret;
+	host->dma_drcmrrx = tmp;
+
+	i = of_property_match_string(np, "dma-names", "tx");
+	if (i < 0)
+		return i;
+
+	ret = of_property_read_u32_index(np, "dmas", 2 * i + 1, &tmp);
+	if (ret < 0)
+		return ret;
+	host->dma_drcmrtx = tmp;
+
+	return 0;
+}
 #else
 static int pxamci_of_init(struct platform_device *pdev)
 {
         return 0;
 }
+
+static int pxamci_of_init_dma(struct platform_device *pdev,
+		struct pxamci_host *host)
+{
+	return -ENODATA;
+}
 #endif
 
 static int pxamci_probe(struct platform_device *pdev)
@@ -741,19 +776,21 @@ static int pxamci_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, mmc);
 
-	dmarx = platform_get_resource(pdev, IORESOURCE_DMA, 0);
-	if (!dmarx) {
-		ret = -ENXIO;
-		goto out;
-	}
-	host->dma_drcmrrx = dmarx->start;
+	if (pxamci_of_init_dma(pdev, host) < 0) {
+		dmarx = platform_get_resource(pdev, IORESOURCE_DMA, 0);
+		if (!dmarx) {
+			ret = -ENXIO;
+			goto out;
+		}
+		host->dma_drcmrrx = dmarx->start;
 
-	dmatx = platform_get_resource(pdev, IORESOURCE_DMA, 1);
-	if (!dmatx) {
-		ret = -ENXIO;
-		goto out;
+		dmatx = platform_get_resource(pdev, IORESOURCE_DMA, 1);
+		if (!dmatx) {
+			ret = -ENXIO;
+			goto out;
+		}
+		host->dma_drcmrtx = dmatx->start;
 	}
-	host->dma_drcmrtx = dmatx->start;
 
 	if (host->pdata) {
 		gpio_cd = host->pdata->gpio_card_detect;
-- 
1.8.4.2
