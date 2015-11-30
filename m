From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [RFC v02 08/15] ARM: davinci: dm644x: Add dma_filter_map to edma
Date: Mon, 30 Nov 2015 15:45:38 +0200
Message-ID: <1448891145-10766-9-git-send-email-peter.ujfalusi@ti.com>
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
 arch/arm/mach-davinci/dm644x.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index d38f5049d56e..3550488b5bfd 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -11,6 +11,7 @@
 #include <linux/init.h>
 #include <linux/clk.h>
 #include <linux/serial_8250.h>
+#include <linux/dmaengine.h>
 #include <linux/platform_device.h>
 #include <linux/platform_data/edma.h>
 #include <linux/platform_data/gpio-davinci.h>
@@ -505,9 +506,20 @@ static s8 queue_priority_mapping[][2] = {
 	{-1, -1},
 };
 
+static struct dma_filter_map da644x_edma_map[] = {
+	DMA_FILTER_ENTRY("davinci-mcbsp", "tx", EDMA_CTLR_CHAN(0, 2)),
+	DMA_FILTER_ENTRY("davinci-mcbsp", "rx", EDMA_CTLR_CHAN(0, 3)),
+	DMA_FILTER_ENTRY("spi_davinci", "tx", EDMA_CTLR_CHAN(0, 16)),
+	DMA_FILTER_ENTRY("spi_davinci", "rx", EDMA_CTLR_CHAN(0, 17)),
+	DMA_FILTER_ENTRY("dm6441-mmc.0", "rx", EDMA_CTLR_CHAN(0, 26)),
+	DMA_FILTER_ENTRY("dm6441-mmc.0", "tx", EDMA_CTLR_CHAN(0, 27)),
+};
+
 static struct edma_soc_info dm644x_edma_pdata = {
 	.queue_priority_mapping	= queue_priority_mapping,
 	.default_queue		= EVENTQ_1,
+	.filter_map		= da644x_edma_map,
+	.filtercnt		= ARRAY_SIZE(da644x_edma_map),
 };
 
 static struct resource edma_resources[] = {
-- 
2.6.3
