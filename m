From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [RFC v03 06/15] ARM: davinci: dm355: Add dma_filter_map to edma
Date: Wed, 2 Dec 2015 15:59:16 +0200
Message-ID: <1449064765-27427-7-git-send-email-peter.ujfalusi@ti.com>
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
 arch/arm/mach-davinci/dm355.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index 609950b8c191..ee7656fa0c52 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -13,6 +13,7 @@
 #include <linux/serial_8250.h>
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
 #include <linux/spi/spi.h>
 #include <linux/platform_data/edma.h>
 #include <linux/platform_data/gpio-davinci.h>
@@ -576,9 +577,28 @@ static s8 queue_priority_mapping[][2] = {
 	{-1, -1},
 };
 
+static const struct dma_filter_map da355_edma_map[] = {
+	{ "davinci-mcbsp.0", "tx", EDMA_FILTER_PARAM(0, 2) },
+	{ "davinci-mcbsp.0", "rx", EDMA_FILTER_PARAM(0, 3) },
+	{ "davinci-mcbsp.1", "tx", EDMA_FILTER_PARAM(0, 8) },
+	{ "davinci-mcbsp.1", "rx", EDMA_FILTER_PARAM(0, 9) },
+	{ "spi_davinci.2", "tx", EDMA_FILTER_PARAM(0, 10) },
+	{ "spi_davinci.2", "rx", EDMA_FILTER_PARAM(0, 11) },
+	{ "spi_davinci.1", "tx", EDMA_FILTER_PARAM(0, 14) },
+	{ "spi_davinci.1", "rx", EDMA_FILTER_PARAM(0, 15) },
+	{ "spi_davinci.0", "tx", EDMA_FILTER_PARAM(0, 16) },
+	{ "spi_davinci.0", "rx", EDMA_FILTER_PARAM(0, 17) },
+	{ "dm6441-mmc.0", "rx", EDMA_FILTER_PARAM(0, 26) },
+	{ "dm6441-mmc.0", "tx", EDMA_FILTER_PARAM(0, 27) },
+	{ "dm6441-mmc.1", "rx", EDMA_FILTER_PARAM(0, 30) },
+	{ "dm6441-mmc.1", "tx", EDMA_FILTER_PARAM(0, 31) },
+};
+
 static struct edma_soc_info dm355_edma_pdata = {
 	.queue_priority_mapping	= queue_priority_mapping,
 	.default_queue		= EVENTQ_1,
+	.slave_map		= da355_edma_map,
+	.slavecnt		= ARRAY_SIZE(da355_edma_map),
 };
 
 static struct resource edma_resources[] = {
-- 
2.6.3
