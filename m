From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [RFC v02 06/15] ARM: davinci: dm355: Add dma_filter_map to edma
Date: Mon, 30 Nov 2015 15:45:36 +0200
Message-ID: <1448891145-10766-7-git-send-email-peter.ujfalusi@ti.com>
References: <1448891145-10766-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1448891145-10766-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: vinod.koul@intel.com, arnd@arndb.de, andy.shevchenko@gmail.com
Cc: linux-mmc@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Provide the dma_filter_map to edma which will allow us to move the drivers
to the new, simpler dmaengine API and we can remove the DMA resources also
for the devices.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-davinci/dm355.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index 609950b8c191..dc8d7ccf69f4 100644
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
 
+static struct dma_filter_map da355_edma_map[] = {
+	DMA_FILTER_ENTRY("davinci-mcbsp.0", "tx", EDMA_CTLR_CHAN(0, 2)),
+	DMA_FILTER_ENTRY("davinci-mcbsp.0", "rx", EDMA_CTLR_CHAN(0, 3)),
+	DMA_FILTER_ENTRY("davinci-mcbsp.1", "tx", EDMA_CTLR_CHAN(0, 8)),
+	DMA_FILTER_ENTRY("davinci-mcbsp.1", "rx", EDMA_CTLR_CHAN(0, 9)),
+	DMA_FILTER_ENTRY("spi_davinci.2", "tx", EDMA_CTLR_CHAN(0, 10)),
+	DMA_FILTER_ENTRY("spi_davinci.2", "rx", EDMA_CTLR_CHAN(0, 11)),
+	DMA_FILTER_ENTRY("spi_davinci.1", "tx", EDMA_CTLR_CHAN(0, 14)),
+	DMA_FILTER_ENTRY("spi_davinci.1", "rx", EDMA_CTLR_CHAN(0, 15)),
+	DMA_FILTER_ENTRY("spi_davinci.0", "tx", EDMA_CTLR_CHAN(0, 16)),
+	DMA_FILTER_ENTRY("spi_davinci.0", "rx", EDMA_CTLR_CHAN(0, 17)),
+	DMA_FILTER_ENTRY("dm6441-mmc.0", "rx", EDMA_CTLR_CHAN(0, 26)),
+	DMA_FILTER_ENTRY("dm6441-mmc.0", "tx", EDMA_CTLR_CHAN(0, 27)),
+	DMA_FILTER_ENTRY("dm6441-mmc.1", "rx", EDMA_CTLR_CHAN(0, 30)),
+	DMA_FILTER_ENTRY("dm6441-mmc.1", "tx", EDMA_CTLR_CHAN(0, 31)),
+};
+
 static struct edma_soc_info dm355_edma_pdata = {
 	.queue_priority_mapping	= queue_priority_mapping,
 	.default_queue		= EVENTQ_1,
+	.filter_map		= da355_edma_map,
+	.filtercnt		= ARRAY_SIZE(da355_edma_map),
 };
 
 static struct resource edma_resources[] = {
-- 
2.6.3
