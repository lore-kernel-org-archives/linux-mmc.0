From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [RFC 5/6] ARM: davinci: devices-da8xx: device -> dma instance mapping support
Date: Fri, 27 Nov 2015 10:29:41 +0200
Message-ID: <1448612982-28141-6-git-send-email-peter.ujfalusi@ti.com>
References: <1448612982-28141-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448612982-28141-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, arnd@arndb.de, andy.shevchenko@gmail.com
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, nsekhar@ti.com
List-Id: linux-mmc@vger.kernel.org

In order to switch the driver to use the new simpler dmaengine API the
device mapping for the dma instances needs to be added and also the DMA
resources should be named.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-davinci/devices-da8xx.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index 28c90bc372bd..e7e042dd7603 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -233,12 +233,28 @@ static const struct platform_device_info da850_edma1_device __initconst = {
 	.size_data	= sizeof(da850_edma1_pdata),
 };
 
+static char *da8xx_edma0_devices[] = {
+	"davinci-mcasp.0",
+	"davinci-mcasp.1",
+	"davinci-mcasp.2",
+	"da830-mmc.0",
+	"spi_davinci.0",
+	"spi_davinci.1",
+};
+
+static char *da850_edma1_devices[] = {
+	"da830-mmc.1",
+};
+
 int __init da830_register_edma(struct edma_rsv_info *rsv)
 {
 	struct platform_device *edma_pdev;
 
 	da8xx_edma0_pdata.rsv = rsv;
 
+	da8xx_edma0_pdata.devnames = da8xx_edma0_devices;
+	da8xx_edma0_pdata.devcnt = ARRAY_SIZE(da8xx_edma0_devices);
+
 	edma_pdev = platform_device_register_full(&da8xx_edma0_device);
 	return IS_ERR(edma_pdev) ? PTR_ERR(edma_pdev) : 0;
 }
@@ -252,11 +268,18 @@ int __init da850_register_edma(struct edma_rsv_info *rsv[2])
 		da850_edma1_pdata.rsv = rsv[1];
 	}
 
+	da8xx_edma0_pdata.devnames = da8xx_edma0_devices;
+	da8xx_edma0_pdata.devcnt = ARRAY_SIZE(da8xx_edma0_devices);
+
 	edma_pdev = platform_device_register_full(&da8xx_edma0_device);
 	if (IS_ERR(edma_pdev)) {
 		pr_warn("%s: Failed to register eDMA0\n", __func__);
 		return PTR_ERR(edma_pdev);
 	}
+
+	da850_edma1_pdata.devnames = da850_edma1_devices;
+	da850_edma1_pdata.devcnt = ARRAY_SIZE(da850_edma1_devices);
+
 	edma_pdev = platform_device_register_full(&da850_edma1_device);
 	return IS_ERR(edma_pdev) ? PTR_ERR(edma_pdev) : 0;
 }
@@ -706,11 +729,13 @@ static struct resource da8xx_mmcsd0_resources[] = {
 		.flags	= IORESOURCE_IRQ,
 	},
 	{		/* DMA RX */
+		.name	= "rx",
 		.start	= DA8XX_DMA_MMCSD0_RX,
 		.end	= DA8XX_DMA_MMCSD0_RX,
 		.flags	= IORESOURCE_DMA,
 	},
 	{		/* DMA TX */
+		.name	= "tx",
 		.start	= DA8XX_DMA_MMCSD0_TX,
 		.end	= DA8XX_DMA_MMCSD0_TX,
 		.flags	= IORESOURCE_DMA,
@@ -743,11 +768,13 @@ static struct resource da850_mmcsd1_resources[] = {
 		.flags	= IORESOURCE_IRQ,
 	},
 	{		/* DMA RX */
+		.name	= "rx",
 		.start	= DA850_DMA_MMCSD1_RX,
 		.end	= DA850_DMA_MMCSD1_RX,
 		.flags	= IORESOURCE_DMA,
 	},
 	{		/* DMA TX */
+		.name	= "tx",
 		.start	= DA850_DMA_MMCSD1_TX,
 		.end	= DA850_DMA_MMCSD1_TX,
 		.flags	= IORESOURCE_DMA,
@@ -939,11 +966,13 @@ static struct resource da8xx_spi0_resources[] = {
 		.flags	= IORESOURCE_IRQ,
 	},
 	[2] = {
+		.name	= "rx",
 		.start	= DA8XX_DMA_SPI0_RX,
 		.end	= DA8XX_DMA_SPI0_RX,
 		.flags	= IORESOURCE_DMA,
 	},
 	[3] = {
+		.name	= "tx",
 		.start	= DA8XX_DMA_SPI0_TX,
 		.end	= DA8XX_DMA_SPI0_TX,
 		.flags	= IORESOURCE_DMA,
@@ -962,11 +991,13 @@ static struct resource da8xx_spi1_resources[] = {
 		.flags	= IORESOURCE_IRQ,
 	},
 	[2] = {
+		.name	= "rx",
 		.start	= DA8XX_DMA_SPI1_RX,
 		.end	= DA8XX_DMA_SPI1_RX,
 		.flags	= IORESOURCE_DMA,
 	},
 	[3] = {
+		.name	= "tx",
 		.start	= DA8XX_DMA_SPI1_TX,
 		.end	= DA8XX_DMA_SPI1_TX,
 		.flags	= IORESOURCE_DMA,
-- 
2.6.3
