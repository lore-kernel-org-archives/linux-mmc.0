From: Ian Molton <ian.molton@codethink.co.uk>
Subject: [PATCH 6/6] mmc: TMIO: Move register definitions to where they belong
Date: Wed, 30 Apr 2014 17:59:11 +0100
Message-ID: <1398877151-6965-7-git-send-email-ian.molton@codethink.co.uk>
References: <1398877151-6965-1-git-send-email-ian.molton@codethink.co.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:47952 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S964792AbaD3Q7n (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Apr 2014 12:59:43 -0400
In-Reply-To: <1398877151-6965-1-git-send-email-ian.molton@codethink.co.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: grant.likely@linaro.org, chris@printf.net, Ian Molton <ian.molton@codethink.co.uk>

	Simple move to remove a redundant header file from public view, when
it only contains driver-internal register definitions.

Reviewed-by: Violeta Menendez <violeta.menendez@codethink.co.uk>
Signed-off-by: Ian Molton <ian.molton@codethink.co.uk>
---
 drivers/mmc/host/tmio_mmc.h     | 47 ++++++++++++++++++++++++++++-
 drivers/mmc/host/tmio_mmc_dma.c |  1 -
 drivers/mmc/host/tmio_mmc_pio.c |  1 -
 include/linux/mmc/tmio.h        | 66 -----------------------------------------
 4 files changed, 46 insertions(+), 69 deletions(-)
 delete mode 100644 include/linux/mmc/tmio.h

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 42894b7..08f4739 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -17,12 +17,57 @@
 #define TMIO_MMC_H
 
 #include <linux/highmem.h>
-#include <linux/mmc/tmio.h>
 #include <linux/mutex.h>
 #include <linux/pagemap.h>
 #include <linux/scatterlist.h>
 #include <linux/spinlock.h>
 
+#define CTL_SD_CMD 0x00
+#define CTL_ARG_REG 0x04
+#define CTL_STOP_INTERNAL_ACTION 0x08
+#define CTL_XFER_BLK_COUNT 0xa
+#define CTL_RESPONSE 0x0c
+#define CTL_STATUS 0x1c
+#define CTL_STATUS2 0x1e
+#define CTL_IRQ_MASK 0x20
+#define CTL_SD_CARD_CLK_CTL 0x24
+#define CTL_SD_XFER_LEN 0x26
+#define CTL_SD_MEM_CARD_OPT 0x28
+#define CTL_SD_ERROR_DETAIL_STATUS 0x2c
+#define CTL_SD_DATA_PORT 0x30
+#define CTL_TRANSACTION_CTL 0x34
+#define CTL_SDIO_STATUS 0x36
+#define CTL_SDIO_IRQ_MASK 0x38
+#define CTL_DMA_ENABLE 0xd8
+#define CTL_RESET_SD 0xe0
+#define CTL_VERSION 0xe2
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
 /* Definitions for values the CTRL_SDIO_STATUS register can take. */
 #define TMIO_SDIO_STAT_IOIRQ	0x0001
 #define TMIO_SDIO_STAT_EXPUB52	0x4000
diff --git a/drivers/mmc/host/tmio_mmc_dma.c b/drivers/mmc/host/tmio_mmc_dma.c
index 03e7b28..1872d6c 100644
--- a/drivers/mmc/host/tmio_mmc_dma.c
+++ b/drivers/mmc/host/tmio_mmc_dma.c
@@ -15,7 +15,6 @@
 #include <linux/dmaengine.h>
 #include <linux/mfd/tmio.h>
 #include <linux/mmc/host.h>
-#include <linux/mmc/tmio.h>
 #include <linux/pagemap.h>
 #include <linux/scatterlist.h>
 
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 50e8c01..ed71b73 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -37,7 +37,6 @@
 #include <linux/mmc/host.h>
 #include <linux/mmc/mmc.h>
 #include <linux/mmc/slot-gpio.h>
-#include <linux/mmc/tmio.h>
 #include <linux/module.h>
 #include <linux/pagemap.h>
 #include <linux/platform_device.h>
diff --git a/include/linux/mmc/tmio.h b/include/linux/mmc/tmio.h
deleted file mode 100644
index 84d9053..0000000
--- a/include/linux/mmc/tmio.h
+++ /dev/null
@@ -1,66 +0,0 @@
-/*
- * include/linux/mmc/tmio.h
- *
- * Copyright (C) 2007 Ian Molton
- * Copyright (C) 2004 Ian Molton
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * Driver for the MMC / SD / SDIO cell found in:
- *
- * TC6393XB TC6391XB TC6387XB T7L66XB ASIC3
- */
-#ifndef LINUX_MMC_TMIO_H
-#define LINUX_MMC_TMIO_H
-
-#define CTL_SD_CMD 0x00
-#define CTL_ARG_REG 0x04
-#define CTL_STOP_INTERNAL_ACTION 0x08
-#define CTL_XFER_BLK_COUNT 0xa
-#define CTL_RESPONSE 0x0c
-#define CTL_STATUS 0x1c
-#define CTL_STATUS2 0x1e
-#define CTL_IRQ_MASK 0x20
-#define CTL_SD_CARD_CLK_CTL 0x24
-#define CTL_SD_XFER_LEN 0x26
-#define CTL_SD_MEM_CARD_OPT 0x28
-#define CTL_SD_ERROR_DETAIL_STATUS 0x2c
-#define CTL_SD_DATA_PORT 0x30
-#define CTL_TRANSACTION_CTL 0x34
-#define CTL_SDIO_STATUS 0x36
-#define CTL_SDIO_IRQ_MASK 0x38
-#define CTL_DMA_ENABLE 0xd8
-#define CTL_RESET_SD 0xe0
-#define CTL_VERSION 0xe2
-#define CTL_SDIO_REGS 0x100
-#define CTL_CLK_AND_WAIT_CTL 0x138
-#define CTL_RESET_SDIO 0x1e0
-
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
-#define TMIO_BBS		512		/* Boot block size */
-
-#endif /* LINUX_MMC_TMIO_H */
-- 
1.9.1

