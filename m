From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 1/4] mmc: tmio_mmc: Move some defines into a shared header
 (fwd)
Date: Thu, 24 Mar 2011 09:54:59 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1103240952280.15629@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:64789 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752277Ab1CXIzS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Mar 2011 04:55:18 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Paul Mundt <lethal@linux-sh.org>, Simon Horman <horms@verge.net.au>

From: Simon Horman <horms@verge.net.au>

Also add TMIO_BBS.

This allows these defines to also be used by zboot.

Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Simon Horman <horms@verge.net.au>
Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

As requested by Simon, this is now rebased on top of all my current tmio 
patches.

 drivers/mmc/host/tmio_mmc.h     |   30 +++--------------------
 drivers/mmc/host/tmio_mmc_dma.c |    1 +
 drivers/mmc/host/tmio_mmc_pio.c |   21 +----------------
 include/linux/mmc/tmio.h        |   49 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 55 insertions(+), 46 deletions(-)
 create mode 100644 include/linux/mmc/tmio.h

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 7d79b14..099ed49 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -17,36 +17,14 @@
 #define TMIO_MMC_H
 
 #include <linux/highmem.h>
+#include <linux/mmc/tmio.h>
 #include <linux/pagemap.h>
 
-/* Definitions for values the CTRL_STATUS register can take. */
-#define TMIO_STAT_CMDRESPEND    0x00000001
-#define TMIO_STAT_DATAEND       0x00000004
-#define TMIO_STAT_CARD_REMOVE   0x00000008
-#define TMIO_STAT_CARD_INSERT   0x00000010
-#define TMIO_STAT_SIGSTATE      0x00000020
-#define TMIO_STAT_WRPROTECT     0x00000080
-#define TMIO_STAT_CARD_REMOVE_A 0x00000100
-#define TMIO_STAT_CARD_INSERT_A 0x00000200
-#define TMIO_STAT_SIGSTATE_A    0x00000400
-#define TMIO_STAT_CMD_IDX_ERR   0x00010000
-#define TMIO_STAT_CRCFAIL       0x00020000
-#define TMIO_STAT_STOPBIT_ERR   0x00040000
-#define TMIO_STAT_DATATIMEOUT   0x00080000
-#define TMIO_STAT_RXOVERFLOW    0x00100000
-#define TMIO_STAT_TXUNDERRUN    0x00200000
-#define TMIO_STAT_CMDTIMEOUT    0x00400000
-#define TMIO_STAT_RXRDY         0x01000000
-#define TMIO_STAT_TXRQ          0x02000000
-#define TMIO_STAT_ILL_FUNC      0x20000000
-#define TMIO_STAT_CMD_BUSY      0x40000000
-#define TMIO_STAT_ILL_ACCESS    0x80000000
-
 /* Definitions for values the CTRL_SDIO_STATUS register can take. */
-#define TMIO_SDIO_STAT_IOIRQ		0x0001
+#define TMIO_SDIO_STAT_IOIRQ	0x0001
 #define TMIO_SDIO_STAT_EXPUB52	0x4000
-#define TMIO_SDIO_STAT_EXWT		0x8000
-#define TMIO_SDIO_MASK_ALL		0xc007
+#define TMIO_SDIO_STAT_EXWT	0x8000
+#define TMIO_SDIO_MASK_ALL	0xc007
 
 /* Define some IRQ masks */
 /* This is the mask used at reset by the chip */
diff --git a/drivers/mmc/host/tmio_mmc_dma.c b/drivers/mmc/host/tmio_mmc_dma.c
index c505278..d3de74a 100644
--- a/drivers/mmc/host/tmio_mmc_dma.c
+++ b/drivers/mmc/host/tmio_mmc_dma.c
@@ -14,6 +14,7 @@
 #include <linux/dmaengine.h>
 #include <linux/mfd/tmio.h>
 #include <linux/mmc/host.h>
+#include <linux/mmc/tmio.h>
 #include <linux/pagemap.h>
 #include <linux/scatterlist.h>
 
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index e35e179..6ae8d2f 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -35,6 +35,7 @@
 #include <linux/irq.h>
 #include <linux/mfd/tmio.h>
 #include <linux/mmc/host.h>
+#include <linux/mmc/tmio.h>
 #include <linux/module.h>
 #include <linux/pagemap.h>
 #include <linux/platform_device.h>
@@ -44,26 +45,6 @@
 
 #include "tmio_mmc.h"
 
-#define CTL_SD_CMD 0x00
-#define CTL_ARG_REG 0x04
-#define CTL_STOP_INTERNAL_ACTION 0x08
-#define CTL_XFER_BLK_COUNT 0xa
-#define CTL_RESPONSE 0x0c
-#define CTL_STATUS 0x1c
-#define CTL_IRQ_MASK 0x20
-#define CTL_SD_CARD_CLK_CTL 0x24
-#define CTL_SD_XFER_LEN 0x26
-#define CTL_SD_MEM_CARD_OPT 0x28
-#define CTL_SD_ERROR_DETAIL_STATUS 0x2c
-#define CTL_SD_DATA_PORT 0x30
-#define CTL_TRANSACTION_CTL 0x34
-#define CTL_SDIO_STATUS 0x36
-#define CTL_SDIO_IRQ_MASK 0x38
-#define CTL_RESET_SD 0xe0
-#define CTL_SDIO_REGS 0x100
-#define CTL_CLK_AND_WAIT_CTL 0x138
-#define CTL_RESET_SDIO 0x1e0
-
 static u16 sd_ctrl_read16(struct tmio_mmc_host *host, int addr)
 {
 	return readw(host->ctl + (addr << host->bus_shift));
diff --git a/include/linux/mmc/tmio.h b/include/linux/mmc/tmio.h
new file mode 100644
index 0000000..7131f8d
--- /dev/null
+++ b/include/linux/mmc/tmio.h
@@ -0,0 +1,49 @@
+#ifndef TMIO_H
+#define TMIO_H
+
+#define CTL_SD_CMD 0x00
+#define CTL_ARG_REG 0x04
+#define CTL_STOP_INTERNAL_ACTION 0x08
+#define CTL_XFER_BLK_COUNT 0xa
+#define CTL_RESPONSE 0x0c
+#define CTL_STATUS 0x1c
+#define CTL_IRQ_MASK 0x20
+#define CTL_SD_CARD_CLK_CTL 0x24
+#define CTL_SD_XFER_LEN 0x26
+#define CTL_SD_MEM_CARD_OPT 0x28
+#define CTL_SD_ERROR_DETAIL_STATUS 0x2c
+#define CTL_SD_DATA_PORT 0x30
+#define CTL_TRANSACTION_CTL 0x34
+#define CTL_SDIO_STATUS 0x36
+#define CTL_SDIO_IRQ_MASK 0x38
+#define CTL_RESET_SD 0xe0
+#define CTL_SDIO_REGS 0x100
+#define CTL_CLK_AND_WAIT_CTL 0x138
+#define CTL_RESET_SDIO 0x1e0
+
+/* Definitions for values the CTRL_STATUS register can take. */
+#define TMIO_STAT_CMDRESPEND    0x00000001
+#define TMIO_STAT_DATAEND       0x00000004
+#define TMIO_STAT_CARD_REMOVE   0x00000008
+#define TMIO_STAT_CARD_INSERT   0x00000010
+#define TMIO_STAT_SIGSTATE      0x00000020
+#define TMIO_STAT_WRPROTECT     0x00000080
+#define TMIO_STAT_CARD_REMOVE_A 0x00000100
+#define TMIO_STAT_CARD_INSERT_A 0x00000200
+#define TMIO_STAT_SIGSTATE_A    0x00000400
+#define TMIO_STAT_CMD_IDX_ERR   0x00010000
+#define TMIO_STAT_CRCFAIL       0x00020000
+#define TMIO_STAT_STOPBIT_ERR   0x00040000
+#define TMIO_STAT_DATATIMEOUT   0x00080000
+#define TMIO_STAT_RXOVERFLOW    0x00100000
+#define TMIO_STAT_TXUNDERRUN    0x00200000
+#define TMIO_STAT_CMDTIMEOUT    0x00400000
+#define TMIO_STAT_RXRDY         0x01000000
+#define TMIO_STAT_TXRQ          0x02000000
+#define TMIO_STAT_ILL_FUNC      0x20000000
+#define TMIO_STAT_CMD_BUSY      0x40000000
+#define TMIO_STAT_ILL_ACCESS    0x80000000
+
+#define TMIO_BBS		512		/* Boot block size */
+
+#endif
-- 
1.7.2.5

