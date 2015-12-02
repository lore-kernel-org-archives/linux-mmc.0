From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [RFC v03 13/15] ARM: davinci: devices: Remove DMA resources for MMC
Date: Wed, 2 Dec 2015 15:59:23 +0200
Message-ID: <1449064765-27427-14-git-send-email-peter.ujfalusi@ti.com>
References: <1449064765-27427-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449064765-27427-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, arnd@arndb.de, andy.shevchenko@gmail.com
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, nsekhar@ti.com, linux-spi@vger.kernel.org, tony@atomide.com
List-Id: linux-mmc@vger.kernel.org

The driver is converted to not use the DMA resource.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-davinci/devices.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/arch/arm/mach-davinci/devices.c b/arch/arm/mach-davinci/devices.c
index 6257aa452568..3ae70f2909b0 100644
--- a/arch/arm/mach-davinci/devices.c
+++ b/arch/arm/mach-davinci/devices.c
@@ -36,9 +36,6 @@
 #define DM365_MMCSD0_BASE	     0x01D11000
 #define DM365_MMCSD1_BASE	     0x01D00000
 
-#define DAVINCI_DMA_MMCRXEVT	26
-#define DAVINCI_DMA_MMCTXEVT	27
-
 void __iomem  *davinci_sysmod_base;
 
 void davinci_map_sysmod(void)
@@ -144,14 +141,6 @@ static struct resource mmcsd0_resources[] = {
 		.start = IRQ_SDIOINT,
 		.flags = IORESOURCE_IRQ,
 	},
-	/* DMA channels: RX, then TX */
-	{
-		.start = EDMA_CTLR_CHAN(0, DAVINCI_DMA_MMCRXEVT),
-		.flags = IORESOURCE_DMA,
-	}, {
-		.start = EDMA_CTLR_CHAN(0, DAVINCI_DMA_MMCTXEVT),
-		.flags = IORESOURCE_DMA,
-	},
 };
 
 static struct platform_device davinci_mmcsd0_device = {
@@ -181,14 +170,6 @@ static struct resource mmcsd1_resources[] = {
 		.start = IRQ_DM355_SDIOINT1,
 		.flags = IORESOURCE_IRQ,
 	},
-	/* DMA channels: RX, then TX */
-	{
-		.start = EDMA_CTLR_CHAN(0, 30),	/* rx */
-		.flags = IORESOURCE_DMA,
-	}, {
-		.start = EDMA_CTLR_CHAN(0, 31),	/* tx */
-		.flags = IORESOURCE_DMA,
-	},
 };
 
 static struct platform_device davinci_mmcsd1_device = {
-- 
2.6.3
