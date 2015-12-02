From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [RFC v03 12/15] ARM: davinci: devices-da8xx: Remove DMA resources for MMC and SPI
Date: Wed, 2 Dec 2015 15:59:22 +0200
Message-ID: <1449064765-27427-13-git-send-email-peter.ujfalusi@ti.com>
References: <1449064765-27427-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449064765-27427-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, arnd@arndb.de, andy.shevchenko@gmail.com
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, nsekhar@ti.com, linux-spi@vger.kernel.org, tony@atomide.com
List-Id: linux-mmc@vger.kernel.org

The drivers are now converted to not use the DMA resource.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-davinci/devices-da8xx.c | 49 -----------------------------------
 1 file changed, 49 deletions(-)

diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index 9ffdcd5de0f8..242fb48371ae 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -57,15 +57,6 @@
 #define DA8XX_EMAC_RAM_OFFSET		0x0000
 #define DA8XX_EMAC_CTRL_RAM_SIZE	SZ_8K
 
-#define DA8XX_DMA_SPI0_RX	EDMA_CTLR_CHAN(0, 14)
-#define DA8XX_DMA_SPI0_TX	EDMA_CTLR_CHAN(0, 15)
-#define DA8XX_DMA_MMCSD0_RX	EDMA_CTLR_CHAN(0, 16)
-#define DA8XX_DMA_MMCSD0_TX	EDMA_CTLR_CHAN(0, 17)
-#define DA8XX_DMA_SPI1_RX	EDMA_CTLR_CHAN(0, 18)
-#define DA8XX_DMA_SPI1_TX	EDMA_CTLR_CHAN(0, 19)
-#define DA850_DMA_MMCSD1_RX	EDMA_CTLR_CHAN(1, 28)
-#define DA850_DMA_MMCSD1_TX	EDMA_CTLR_CHAN(1, 29)
-
 void __iomem *da8xx_syscfg0_base;
 void __iomem *da8xx_syscfg1_base;
 
@@ -751,16 +742,6 @@ static struct resource da8xx_mmcsd0_resources[] = {
 		.end	= IRQ_DA8XX_MMCSDINT0,
 		.flags	= IORESOURCE_IRQ,
 	},
-	{		/* DMA RX */
-		.start	= DA8XX_DMA_MMCSD0_RX,
-		.end	= DA8XX_DMA_MMCSD0_RX,
-		.flags	= IORESOURCE_DMA,
-	},
-	{		/* DMA TX */
-		.start	= DA8XX_DMA_MMCSD0_TX,
-		.end	= DA8XX_DMA_MMCSD0_TX,
-		.flags	= IORESOURCE_DMA,
-	},
 };
 
 static struct platform_device da8xx_mmcsd0_device = {
@@ -788,16 +769,6 @@ static struct resource da850_mmcsd1_resources[] = {
 		.end	= IRQ_DA850_MMCSDINT0_1,
 		.flags	= IORESOURCE_IRQ,
 	},
-	{		/* DMA RX */
-		.start	= DA850_DMA_MMCSD1_RX,
-		.end	= DA850_DMA_MMCSD1_RX,
-		.flags	= IORESOURCE_DMA,
-	},
-	{		/* DMA TX */
-		.start	= DA850_DMA_MMCSD1_TX,
-		.end	= DA850_DMA_MMCSD1_TX,
-		.flags	= IORESOURCE_DMA,
-	},
 };
 
 static struct platform_device da850_mmcsd1_device = {
@@ -984,16 +955,6 @@ static struct resource da8xx_spi0_resources[] = {
 		.end	= IRQ_DA8XX_SPINT0,
 		.flags	= IORESOURCE_IRQ,
 	},
-	[2] = {
-		.start	= DA8XX_DMA_SPI0_RX,
-		.end	= DA8XX_DMA_SPI0_RX,
-		.flags	= IORESOURCE_DMA,
-	},
-	[3] = {
-		.start	= DA8XX_DMA_SPI0_TX,
-		.end	= DA8XX_DMA_SPI0_TX,
-		.flags	= IORESOURCE_DMA,
-	},
 };
 
 static struct resource da8xx_spi1_resources[] = {
@@ -1007,16 +968,6 @@ static struct resource da8xx_spi1_resources[] = {
 		.end	= IRQ_DA8XX_SPINT1,
 		.flags	= IORESOURCE_IRQ,
 	},
-	[2] = {
-		.start	= DA8XX_DMA_SPI1_RX,
-		.end	= DA8XX_DMA_SPI1_RX,
-		.flags	= IORESOURCE_DMA,
-	},
-	[3] = {
-		.start	= DA8XX_DMA_SPI1_TX,
-		.end	= DA8XX_DMA_SPI1_TX,
-		.flags	= IORESOURCE_DMA,
-	},
 };
 
 static struct davinci_spi_platform_data da8xx_spi_pdata[] = {
-- 
2.6.3
