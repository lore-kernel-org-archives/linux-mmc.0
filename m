From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH v1 4/5] dma: mxs-dma: add dt probe support
Date: Tue, 13 Mar 2012 16:47:07 +0800
Message-ID: <1331628428-24017-5-git-send-email-b29396@freescale.com>
References: <1331628428-24017-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1331628428-24017-1-git-send-email-b29396@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: s.hauer@pengutronix.de, shawn.guo@freescale.com, kernel@pengutronix.de, grant.likely@secretlab.ca, rob.herring@calxeda.com, cjb@laptop.org, rdunlap@xenotime.net, vinod.koul@linux.intel.com
List-Id: linux-mmc@vger.kernel.org

From: Dong Aisheng <dong.aisheng@linaro.org>

Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
---
 .../devicetree/bindings/dma/fsl-mxs-dma.txt        |   17 ++++++++
 drivers/dma/mxs-dma.c                              |   44 +++++++++++++------
 2 files changed, 47 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/fsl-mxs-dma.txt b/Documentation/devicetree/bindings/dma/fsl-mxs-dma.txt
new file mode 100644
index 0000000..cfa1730
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/fsl-mxs-dma.txt
@@ -0,0 +1,17 @@
+* Freescale MXS DMA
+
+Required properties:
+- compatible : Should be "fsl,mxs-dma-apbh" or "fsl,mxs-dma-apbx"
+- reg : Should contain registers location and length
+
+Examples:
+
+dma-apbh@80004000 {
+	compatible = "fsl,mxs-dma-apbh";
+	reg = <0x80004000 2000>;
+};
+
+dma-apbx@80024000 {
+	compatible = "fsl,mxs-dma-apbx";
+	reg = <0x80024000 2000>;
+};
diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
index b06cd4c..45e8d46 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -22,6 +22,9 @@
 #include <linux/platform_device.h>
 #include <linux/dmaengine.h>
 #include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 
 #include <asm/irq.h>
 #include <mach/mxs.h>
@@ -130,6 +133,25 @@ struct mxs_dma_engine {
 	struct mxs_dma_chan		mxs_chans[MXS_DMA_CHANNELS];
 };
 
+static struct platform_device_id mxs_dma_type[] = {
+	{
+		.name = "mxs-dma-apbh",
+		.driver_data = MXS_DMA_APBH,
+	}, {
+		.name = "mxs-dma-apbx",
+		.driver_data = MXS_DMA_APBX,
+	}, {
+		/* end of list */
+	}
+};
+
+static const struct of_device_id mxs_dma_dt_ids[] = {
+	{ .compatible = "fsl,mxs-dma-apbh", .data = &mxs_dma_type[0], },
+	{ .compatible = "fsl,mxs-dma-apbx", .data = &mxs_dma_type[1], },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, mxs_dma_dt_ids);
+
 static void mxs_dma_reset_chan(struct mxs_dma_chan *mxs_chan)
 {
 	struct mxs_dma_engine *mxs_dma = mxs_chan->mxs_dma;
@@ -587,8 +609,8 @@ err_out:
 
 static int __init mxs_dma_probe(struct platform_device *pdev)
 {
-	const struct platform_device_id *id_entry =
-				platform_get_device_id(pdev);
+	const struct platform_device_id *id_entry;
+	const struct of_device_id *of_id;
 	struct mxs_dma_engine *mxs_dma;
 	struct resource *iores;
 	int ret, i;
@@ -597,6 +619,11 @@ static int __init mxs_dma_probe(struct platform_device *pdev)
 	if (!mxs_dma)
 		return -ENOMEM;
 
+	of_id = of_match_device(mxs_dma_dt_ids, &pdev->dev);
+	if (of_id)
+		id_entry = of_id->data;
+	else
+		id_entry = platform_get_device_id(pdev);
 	mxs_dma->dev_id = id_entry->driver_data;
 
 	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -679,21 +706,10 @@ err_request_region:
 	return ret;
 }
 
-static struct platform_device_id mxs_dma_type[] = {
-	{
-		.name = "mxs-dma-apbh",
-		.driver_data = MXS_DMA_APBH,
-	}, {
-		.name = "mxs-dma-apbx",
-		.driver_data = MXS_DMA_APBX,
-	}, {
-		/* end of list */
-	}
-};
-
 static struct platform_driver mxs_dma_driver = {
 	.driver		= {
 		.name	= "mxs-dma",
+		.of_match_table = mxs_dma_dt_ids,
 	},
 	.id_table	= mxs_dma_type,
 };
-- 
1.7.0.4
