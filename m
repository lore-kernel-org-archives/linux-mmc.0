From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [RFC v02 05/15] ARM: davinci: devices-da8xx: Add dma_filter_map to
 edma
Date: Mon, 30 Nov 2015 15:45:35 +0200
Message-ID: <1448891145-10766-6-git-send-email-peter.ujfalusi@ti.com>
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
 arch/arm/mach-davinci/devices-da8xx.c | 46 +++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index 28c90bc372bd..3327cb22e0b5 100644
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
 
+static struct dma_filter_map da830_edma_map[] = {
+	DMA_FILTER_ENTRY("davinci-mcasp.0", "rx", EDMA_CTLR_CHAN(0, 0)),
+	DMA_FILTER_ENTRY("davinci-mcasp.0", "tx", EDMA_CTLR_CHAN(0, 1)),
+	DMA_FILTER_ENTRY("davinci-mcasp.1", "rx", EDMA_CTLR_CHAN(0, 2)),
+	DMA_FILTER_ENTRY("davinci-mcasp.1", "tx", EDMA_CTLR_CHAN(0, 3)),
+	DMA_FILTER_ENTRY("davinci-mcasp.2", "rx", EDMA_CTLR_CHAN(0, 4)),
+	DMA_FILTER_ENTRY("davinci-mcasp.2", "tx", EDMA_CTLR_CHAN(0, 5)),
+	DMA_FILTER_ENTRY("spi_davinci.0", "rx", EDMA_CTLR_CHAN(0, 14)),
+	DMA_FILTER_ENTRY("spi_davinci.0", "tx", EDMA_CTLR_CHAN(0, 15)),
+	DMA_FILTER_ENTRY("da830-mmc.0", "rx", EDMA_CTLR_CHAN(0, 16)),
+	DMA_FILTER_ENTRY("da830-mmc.0", "tx", EDMA_CTLR_CHAN(0, 17)),
+	DMA_FILTER_ENTRY("spi_davinci.1", "rx", EDMA_CTLR_CHAN(0, 18)),
+	DMA_FILTER_ENTRY("spi_davinci.1", "tx", EDMA_CTLR_CHAN(0, 19)),
+};
+
 int __init da830_register_edma(struct edma_rsv_info *rsv)
 {
 	struct platform_device *edma_pdev;
 
 	da8xx_edma0_pdata.rsv = rsv;
 
+	da8xx_edma0_pdata.filter_map = da830_edma_map;
+	da8xx_edma0_pdata.filtercnt = ARRAY_SIZE(da830_edma_map);
+
 	edma_pdev = platform_device_register_full(&da8xx_edma0_device);
 	return IS_ERR(edma_pdev) ? PTR_ERR(edma_pdev) : 0;
 }
 
+static struct dma_filter_map da850_edma0_map[] = {
+	DMA_FILTER_ENTRY("davinci-mcasp.0", "rx", EDMA_CTLR_CHAN(0, 0)),
+	DMA_FILTER_ENTRY("davinci-mcasp.0", "tx", EDMA_CTLR_CHAN(0, 1)),
+	DMA_FILTER_ENTRY("davinci-mcbsp.0", "rx", EDMA_CTLR_CHAN(0, 2)),
+	DMA_FILTER_ENTRY("davinci-mcbsp.0", "tx", EDMA_CTLR_CHAN(0, 3)),
+	DMA_FILTER_ENTRY("davinci-mcbsp.1", "rx", EDMA_CTLR_CHAN(0, 4)),
+	DMA_FILTER_ENTRY("davinci-mcbsp.1", "tx", EDMA_CTLR_CHAN(0, 5)),
+	DMA_FILTER_ENTRY("spi_davinci.0", "rx", EDMA_CTLR_CHAN(0, 14)),
+	DMA_FILTER_ENTRY("spi_davinci.0", "tx", EDMA_CTLR_CHAN(0, 15)),
+	DMA_FILTER_ENTRY("da830-mmc.0", "rx", EDMA_CTLR_CHAN(0, 16)),
+	DMA_FILTER_ENTRY("da830-mmc.0", "tx", EDMA_CTLR_CHAN(0, 17)),
+	DMA_FILTER_ENTRY("spi_davinci.1", "rx", EDMA_CTLR_CHAN(0, 18)),
+	DMA_FILTER_ENTRY("spi_davinci.1", "tx", EDMA_CTLR_CHAN(0, 19)),
+};
+
+static struct dma_filter_map da850_edma1_map[] = {
+	DMA_FILTER_ENTRY("da830-mmc.1", "tx", EDMA_CTLR_CHAN(0, 28)),
+	DMA_FILTER_ENTRY("da830-mmc.1", "rx", EDMA_CTLR_CHAN(0, 29)),
+};
+
 int __init da850_register_edma(struct edma_rsv_info *rsv[2])
 {
 	struct platform_device *edma_pdev;
@@ -252,11 +291,18 @@ int __init da850_register_edma(struct edma_rsv_info *rsv[2])
 		da850_edma1_pdata.rsv = rsv[1];
 	}
 
+	da8xx_edma0_pdata.filter_map = da850_edma0_map;
+	da8xx_edma0_pdata.filtercnt = ARRAY_SIZE(da850_edma0_map);
+
 	edma_pdev = platform_device_register_full(&da8xx_edma0_device);
 	if (IS_ERR(edma_pdev)) {
 		pr_warn("%s: Failed to register eDMA0\n", __func__);
 		return PTR_ERR(edma_pdev);
 	}
+
+	da850_edma1_pdata.filter_map = da850_edma1_map;
+	da850_edma1_pdata.filtercnt = ARRAY_SIZE(da850_edma1_map);
+
 	edma_pdev = platform_device_register_full(&da850_edma1_device);
 	return IS_ERR(edma_pdev) ? PTR_ERR(edma_pdev) : 0;
 }
-- 
2.6.3
