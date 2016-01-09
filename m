From: Mans Rullgard <mans@mansr.com>
Subject: [PATCH 2/2] mmc: atmel: get rid of struct mci_dma_data
Date: Sat,  9 Jan 2016 01:22:31 +0000
Message-ID: <1452302551-24199-2-git-send-email-mans@mansr.com>
References: <1452302551-24199-1-git-send-email-mans@mansr.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from unicorn.mansr.com ([81.2.72.234]:47437 "EHLO unicorn.mansr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752162AbcAIBXG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 8 Jan 2016 20:23:06 -0500
In-Reply-To: <1452302551-24199-1-git-send-email-mans@mansr.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Haavard Skinnemoen <hskinnemoen@gmail.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Ludovic Desroches <ludovic.desroches@atmel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org

As struct mci_dma_data is now only used by AVR32, it is nothing but
pointless indirection.  Replace it with struct dw_dma_slave in the
AVR32 platform code and with a void pointer elsewhere.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 arch/avr32/mach-at32ap/at32ap700x.c         | 21 ++++++++++-----------
 drivers/mmc/host/atmel-mci.c                |  1 -
 include/linux/atmel-mci.h                   |  2 +-
 include/linux/platform_data/mmc-atmel-mci.h | 22 ----------------------
 4 files changed, 11 insertions(+), 35 deletions(-)
 delete mode 100644 include/linux/platform_data/mmc-atmel-mci.h

diff --git a/arch/avr32/mach-at32ap/at32ap700x.c b/arch/avr32/mach-at32ap/at32ap700x.c
index f433c7220fff..ec5244c1bb1e 100644
--- a/arch/avr32/mach-at32ap/at32ap700x.c
+++ b/arch/avr32/mach-at32ap/at32ap700x.c
@@ -17,7 +17,6 @@
 #include <linux/spi/spi.h>
 #include <linux/usb/atmel_usba_udc.h>
 
-#include <linux/platform_data/mmc-atmel-mci.h>
 #include <linux/atmel-mci.h>
 
 #include <asm/io.h>
@@ -1340,13 +1339,13 @@ static struct clk atmel_mci0_pclk = {
 
 static bool at32_mci_dma_filter(struct dma_chan *chan, void *pdata)
 {
-	struct mci_dma_data *sl = pdata;
+	struct dw_dma_slave *sl = pdata;
 
 	if (!sl)
 		return false;
 
-	if (find_slave_dev(sl) == chan->device->dev) {
-		chan->private = slave_data_ptr(sl);
+	if (sl->dma_dev == chan->device->dev) {
+		chan->private = sl;
 		return true;
 	}
 
@@ -1357,7 +1356,7 @@ struct platform_device *__init
 at32_add_device_mci(unsigned int id, struct mci_platform_data *data)
 {
 	struct platform_device		*pdev;
-	struct mci_dma_data	        *slave;
+	struct dw_dma_slave	        *slave;
 	u32				pioa_mask;
 	u32				piob_mask;
 
@@ -1376,15 +1375,15 @@ at32_add_device_mci(unsigned int id, struct mci_platform_data *data)
 				ARRAY_SIZE(atmel_mci0_resource)))
 		goto fail;
 
-	slave = kzalloc(sizeof(struct mci_dma_data), GFP_KERNEL);
+	slave = kzalloc(sizeof(*slave), GFP_KERNEL);
 	if (!slave)
 		goto fail;
 
-	slave->sdata.dma_dev = &dw_dmac0_device.dev;
-	slave->sdata.src_id = 0;
-	slave->sdata.dst_id = 1;
-	slave->sdata.m_master = 1;
-	slave->sdata.p_master = 0;
+	slave->dma_dev = &dw_dmac0_device.dev;
+	slave->src_id = 0;
+	slave->dst_id = 1;
+	slave->m_master = 1;
+	slave->p_master = 0;
 
 	data->dma_slave = slave;
 	data->dma_filter = at32_mci_dma_filter;
diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 070dffc4699e..97af84d4cdf0 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -29,7 +29,6 @@
 #include <linux/slab.h>
 #include <linux/stat.h>
 #include <linux/types.h>
-#include <linux/platform_data/mmc-atmel-mci.h>
 
 #include <linux/mmc/host.h>
 #include <linux/mmc/sdio.h>
diff --git a/include/linux/atmel-mci.h b/include/linux/atmel-mci.h
index e753062b9355..42a9e1884842 100644
--- a/include/linux/atmel-mci.h
+++ b/include/linux/atmel-mci.h
@@ -37,7 +37,7 @@ struct mci_slot_pdata {
  * @slot: Per-slot configuration data.
  */
 struct mci_platform_data {
-	struct mci_dma_data	*dma_slave;
+	void			*dma_slave;
 	dma_filter_fn		dma_filter;
 	struct mci_slot_pdata	slot[ATMCI_MAX_NR_SLOTS];
 };
diff --git a/include/linux/platform_data/mmc-atmel-mci.h b/include/linux/platform_data/mmc-atmel-mci.h
deleted file mode 100644
index 399a2d5a14bd..000000000000
--- a/include/linux/platform_data/mmc-atmel-mci.h
+++ /dev/null
@@ -1,22 +0,0 @@
-#ifndef __MMC_ATMEL_MCI_H
-#define __MMC_ATMEL_MCI_H
-
-#include <linux/platform_data/dma-atmel.h>
-#include <linux/platform_data/dma-dw.h>
-
-/**
- * struct mci_dma_data - DMA data for MCI interface
- */
-struct mci_dma_data {
-#ifdef CONFIG_ARM
-	struct at_dma_slave     sdata;
-#else
-	struct dw_dma_slave     sdata;
-#endif
-};
-
-/* accessor macros */
-#define	slave_data_ptr(s)	(&(s)->sdata)
-#define find_slave_dev(s)	((s)->sdata.dma_dev)
-
-#endif /* __MMC_ATMEL_MCI_H */
-- 
2.7.0

