From: David Lechner <david@lechnology.com>
Subject: [PATCH v3 5/5] ARM: davinci: remove mmc dma resources
Date: Wed, 16 Mar 2016 22:45:35 -0500
Message-ID: <1458186341-6970-6-git-send-email-david@lechnology.com>
References: <1458186341-6970-1-git-send-email-david@lechnology.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1458186341-6970-1-git-send-email-david@lechnology.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: David Lechner <david@lechnology.com>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

The davinci_mmc driver no longer uses platform resources for getting dma
channels. Instead lookup is now done using dma_slave_map.

Signed-off-by: David Lechner <david@lechnology.com>
Acked-by: Sekhar Nori <nsekhar@ti.com>
---

v3 changes: none.


 arch/arm/mach-davinci/devices-da8xx.c | 20 --------------------
 arch/arm/mach-davinci/devices.c       | 16 ----------------
 2 files changed, 36 deletions(-)

diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index 725e693..add3771 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -751,16 +751,6 @@ static struct resource da8xx_mmcsd0_resources[] = {
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
@@ -788,16 +778,6 @@ static struct resource da850_mmcsd1_resources[] = {
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
diff --git a/arch/arm/mach-davinci/devices.c b/arch/arm/mach-davinci/devices.c
index 6257aa4..67d26c5 100644
--- a/arch/arm/mach-davinci/devices.c
+++ b/arch/arm/mach-davinci/devices.c
@@ -144,14 +144,6 @@ static struct resource mmcsd0_resources[] = {
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
@@ -181,14 +173,6 @@ static struct resource mmcsd1_resources[] = {
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
1.9.1
