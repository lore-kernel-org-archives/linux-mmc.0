From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [RFC v03 05/15] ARM: davinci: devices-da8xx: Add dma_filter_map to edma
Date: Wed, 2 Dec 2015 15:59:15 +0200
Message-ID: <1449064765-27427-6-git-send-email-peter.ujfalusi@ti.com>
References: <1449064765-27427-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449064765-27427-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, arnd@arndb.de, andy.shevchenko@gmail.com
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, nsekhar@ti.com, linux-spi@vger.kernel.org, tony@atomide.com
List-Id: linux-mmc@vger.kernel.org

Provide the dma_filter_map to edma which will allow us to move the drivers
to the new, simpler dmaengine API and we can remove the DMA resources also
for the devices.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-davinci/devices-da8xx.c | 46 +++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index 28c90bc372bd..9ffdcd5de0f8 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -17,6 +17,7 @@
 #include <linux/ahci_platform.h>
 #include <linux/clk.h>
 #include <linux/reboot.h>
+#include <linux/dmaengine.h>
 
 #include <mach/cputype.h>
 #include <mach/common.h>
@@ -233,16 +234,54 @@ static const struct platform_device_info da850_edma1_device __initconst = {
 	.size_data	= sizeof(da850_edma1_pdata),
 };
 
+static const struct dma_filter_map da830_edma_map[] = {
+	{ "davinci-mcasp.0", "rx", EDMA_FILTER_PARAM(0, 0) },
+	{ "davinci-mcasp.0", "tx", EDMA_FILTER_PARAM(0, 1) },
+	{ "davinci-mcasp.1", "rx", EDMA_FILTER_PARAM(0, 2) },
+	{ "davinci-mcasp.1", "tx", EDMA_FILTER_PARAM(0, 3) },
+	{ "davinci-mcasp.2", "rx", EDMA_FILTER_PARAM(0, 4) },
+	{ "davinci-mcasp.2", "tx", EDMA_FILTER_PARAM(0, 5) },
+	{ "spi_davinci.0", "rx", EDMA_FILTER_PARAM(0, 14) },
+	{ "spi_davinci.0", "tx", EDMA_FILTER_PARAM(0, 15) },
+	{ "da830-mmc.0", "rx", EDMA_FILTER_PARAM(0, 16) },
+	{ "da830-mmc.0", "tx", EDMA_FILTER_PARAM(0, 17) },
+	{ "spi_davinci.1", "rx", EDMA_FILTER_PARAM(0, 18) },
+	{ "spi_davinci.1", "tx", EDMA_FILTER_PARAM(0, 19) },
+};
+
 int __init da830_register_edma(struct edma_rsv_info *rsv)
 {
 	struct platform_device *edma_pdev;
 
 	da8xx_edma0_pdata.rsv = rsv;
 
+	da8xx_edma0_pdata.slave_map = da830_edma_map;
+	da8xx_edma0_pdata.slavecnt = ARRAY_SIZE(da830_edma_map);
+
 	edma_pdev = platform_device_register_full(&da8xx_edma0_device);
 	return IS_ERR(edma_pdev) ? PTR_ERR(edma_pdev) : 0;
 }
 
+static const struct dma_filter_map da850_edma0_map[] = {
+	{ "davinci-mcasp.0", "rx", EDMA_FILTER_PARAM(0, 0) },
+	{ "davinci-mcasp.0", "tx", EDMA_FILTER_PARAM(0, 1) },
+	{ "davinci-mcbsp.0", "rx", EDMA_FILTER_PARAM(0, 2) },
+	{ "davinci-mcbsp.0", "tx", EDMA_FILTER_PARAM(0, 3) },
+	{ "davinci-mcbsp.1", "rx", EDMA_FILTER_PARAM(0, 4) },
+	{ "davinci-mcbsp.1", "tx", EDMA_FILTER_PARAM(0, 5) },
+	{ "spi_davinci.0", "rx", EDMA_FILTER_PARAM(0, 14) },
+	{ "spi_davinci.0", "tx", EDMA_FILTER_PARAM(0, 15) },
+	{ "da830-mmc.0", "rx", EDMA_FILTER_PARAM(0, 16) },
+	{ "da830-mmc.0", "tx", EDMA_FILTER_PARAM(0, 17) },
+	{ "spi_davinci.1", "rx", EDMA_FILTER_PARAM(0, 18) },
+	{ "spi_davinci.1", "tx", EDMA_FILTER_PARAM(0, 19) },
+};
+
+static const struct dma_filter_map da850_edma1_map[] = {
+	{ "da830-mmc.1", "tx", EDMA_FILTER_PARAM(0, 28) },
+	{ "da830-mmc.1", "rx", EDMA_FILTER_PARAM(0, 29) },
+};
+
 int __init da850_register_edma(struct edma_rsv_info *rsv[2])
 {
 	struct platform_device *edma_pdev;
@@ -252,11 +291,18 @@ int __init da850_register_edma(struct edma_rsv_info *rsv[2])
 		da850_edma1_pdata.rsv = rsv[1];
 	}
 
+	da8xx_edma0_pdata.slave_map = da850_edma0_map;
+	da8xx_edma0_pdata.slavecnt = ARRAY_SIZE(da850_edma0_map);
+
 	edma_pdev = platform_device_register_full(&da8xx_edma0_device);
 	if (IS_ERR(edma_pdev)) {
 		pr_warn("%s: Failed to register eDMA0\n", __func__);
 		return PTR_ERR(edma_pdev);
 	}
+
+	da850_edma1_pdata.slave_map = da850_edma1_map;
+	da850_edma1_pdata.slavecnt = ARRAY_SIZE(da850_edma1_map);
+
 	edma_pdev = platform_device_register_full(&da850_edma1_device);
 	return IS_ERR(edma_pdev) ? PTR_ERR(edma_pdev) : 0;
 }
-- 
2.6.3
