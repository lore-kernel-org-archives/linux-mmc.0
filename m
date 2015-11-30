From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [RFC v02 07/15] ARM: davinci: dm365: Add dma_filter_map to edma
Date: Mon, 30 Nov 2015 15:45:37 +0200
Message-ID: <1448891145-10766-8-git-send-email-peter.ujfalusi@ti.com>
References: <1448891145-10766-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448891145-10766-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, arnd@arndb.de, andy.shevchenko@gmail.com
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, nsekhar@ti.com, linux-spi@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Provide the dma_filter_map to edma which will allow us to move the drivers
to the new, simpler dmaengine API and we can remove the DMA resources also
for the devices.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-davinci/dm365.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 2068cbeaeb03..3dfcf7c9aa20 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -17,6 +17,7 @@
 #include <linux/serial_8250.h>
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
 #include <linux/spi/spi.h>
 #include <linux/platform_data/edma.h>
 #include <linux/platform_data/gpio-davinci.h>
@@ -862,9 +863,30 @@ static s8 dm365_queue_priority_mapping[][2] = {
 	{-1, -1},
 };
 
+static struct dma_filter_map da365_edma_map[] = {
+	DMA_FILTER_ENTRY("davinci-mcbsp.0", "tx", EDMA_CTLR_CHAN(0, 2)),
+	DMA_FILTER_ENTRY("davinci-mcbsp.0", "rx", EDMA_CTLR_CHAN(0, 3)),
+	DMA_FILTER_ENTRY("davinci_voicecodec", "tx", EDMA_CTLR_CHAN(0, 2)),
+	DMA_FILTER_ENTRY("davinci_voicecodec", "rx", EDMA_CTLR_CHAN(0, 3)),
+	DMA_FILTER_ENTRY("spi_davinci.2", "tx", EDMA_CTLR_CHAN(0, 10)),
+	DMA_FILTER_ENTRY("spi_davinci.2", "rx", EDMA_CTLR_CHAN(0, 11)),
+	DMA_FILTER_ENTRY("spi_davinci.1", "tx", EDMA_CTLR_CHAN(0, 14)),
+	DMA_FILTER_ENTRY("spi_davinci.1", "rx", EDMA_CTLR_CHAN(0, 15)),
+	DMA_FILTER_ENTRY("spi_davinci.0", "tx", EDMA_CTLR_CHAN(0, 16)),
+	DMA_FILTER_ENTRY("spi_davinci.0", "rx", EDMA_CTLR_CHAN(0, 17)),
+	DMA_FILTER_ENTRY("spi_davinci.3", "tx", EDMA_CTLR_CHAN(0, 18)),
+	DMA_FILTER_ENTRY("spi_davinci.3", "rx", EDMA_CTLR_CHAN(0, 19)),
+	DMA_FILTER_ENTRY("dm6441-mmc.0", "rx", EDMA_CTLR_CHAN(0, 26)),
+	DMA_FILTER_ENTRY("dm6441-mmc.0", "tx", EDMA_CTLR_CHAN(0, 27)),
+	DMA_FILTER_ENTRY("dm6441-mmc.1", "rx", EDMA_CTLR_CHAN(0, 30)),
+	DMA_FILTER_ENTRY("dm6441-mmc.1", "tx", EDMA_CTLR_CHAN(0, 31)),
+};
+
 static struct edma_soc_info dm365_edma_pdata = {
 	.queue_priority_mapping	= dm365_queue_priority_mapping,
 	.default_queue		= EVENTQ_3,
+	.filter_map		= da365_edma_map,
+	.filtercnt		= ARRAY_SIZE(da365_edma_map),
 };
 
 static struct resource edma_resources[] = {
-- 
2.6.3
