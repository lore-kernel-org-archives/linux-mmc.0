From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] mmc: core: Lower max_seg_size if too high for DMA
Date: Wed, 31 Oct 2018 08:57:38 -0700
Message-ID: <20181031155738.18367-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Russell King <rmk+kernel@armlinux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

With CONFIG_DMA_API_DEBUG_SG a device may produce the following warning:

"DMA-API: mapping sg segment longer than device claims to support"

We default to 64KiB if a DMA engine driver does not initialize dma_parms
and call dma_set_max_seg_size(). This may be lower that what many MMC
drivers do with mmc->max_seg_size = mmc->max_blk_size * mmc->max_blk_count.

Let's do a sanity check for max_seg_size being higher than what DMA
supports in mmc_add_host() and lower it as needed.

Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>
Reported-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/mmc/core/host.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -13,6 +13,7 @@
  */
 
 #include <linux/device.h>
+#include <linux/dma-mapping.h>
 #include <linux/err.h>
 #include <linux/idr.h>
 #include <linux/of.h>
@@ -415,6 +416,19 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 
 EXPORT_SYMBOL(mmc_alloc_host);
 
+static void mmc_check_max_seg_size(struct mmc_host *host)
+{
+	unsigned int max_seg_size = dma_get_max_seg_size(mmc_dev(host));
+
+	if (host->max_seg_size <= max_seg_size)
+		return;
+
+	dev_info(mmc_dev(host), "Lowering max_seg_size for DMA: %u vs %u\n",
+		 host->max_seg_size, max_seg_size);
+
+	host->max_seg_size = max_seg_size;
+}
+
 /**
  *	mmc_add_host - initialise host hardware
  *	@host: mmc host
@@ -430,6 +444,8 @@ int mmc_add_host(struct mmc_host *host)
 	WARN_ON((host->caps & MMC_CAP_SDIO_IRQ) &&
 		!host->ops->enable_sdio_irq);
 
+	mmc_check_max_seg_size(host);
+
 	err = device_add(&host->class_dev);
 	if (err)
 		return err;
-- 
2.19.1
