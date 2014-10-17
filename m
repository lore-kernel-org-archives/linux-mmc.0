From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 1/3] mmc: atmel-mci: move mache header to platform_data
Date: Fri, 17 Oct 2014 09:52:44 +0200
Message-ID: <1413532366-1317-2-git-send-email-alexandre.belloni@free-electrons.com>
References: <1413532366-1317-1-git-send-email-alexandre.belloni@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1413532366-1317-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>, Chris Ball <chris@printf.net>, Hans-Christian Egtvedt <egtvedt@samfundet.no>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>
List-Id: linux-mmc@vger.kernel.org

Move the mach header that can come either from arm/mach-at91 or avr32 to
platform_data to be able to switch the AT91 platforms to multiplatform.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/mmc/host/atmel-mci.c                |  2 +-
 include/linux/platform_data/mmc-atmel-mci.h | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/platform_data/mmc-atmel-mci.h

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index bb585d940901..b1231835b031 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -29,11 +29,11 @@
 #include <linux/stat.h>
 #include <linux/types.h>
 #include <linux/platform_data/atmel.h>
+#include <linux/platform_data/mmc-atmel-mci.h>
 
 #include <linux/mmc/host.h>
 #include <linux/mmc/sdio.h>
 
-#include <mach/atmel-mci.h>
 #include <linux/atmel-mci.h>
 #include <linux/atmel_pdc.h>
 
diff --git a/include/linux/platform_data/mmc-atmel-mci.h b/include/linux/platform_data/mmc-atmel-mci.h
new file mode 100644
index 000000000000..ebe7ae4f72e4
--- /dev/null
+++ b/include/linux/platform_data/mmc-atmel-mci.h
@@ -0,0 +1,22 @@
+#ifndef __MMC_ATMEL_MCI_H
+#define __MMC_ATMEL_MCI_H
+
+#include <linux/platform_data/dma-atmel.h>
+#include <linux/dw_dmac.h>
+
+/**
+ * struct mci_dma_data - DMA data for MCI interface
+ */
+struct mci_dma_data {
+#ifdef CONFIG_ARM
+	struct at_dma_slave     sdata;
+#else
+	struct dw_dma_slave     sdata;
+#endif
+};
+
+/* accessor macros */
+#define	slave_data_ptr(s)	(&(s)->sdata)
+#define find_slave_dev(s)	((s)->sdata.dma_dev)
+
+#endif /* __MMC_ATMEL_MCI_H */
-- 
1.9.1
