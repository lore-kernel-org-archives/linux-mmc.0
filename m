From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH v2 5/6] mmc: tmio: merge distributed include files
Date: Wed,  6 Apr 2016 11:34:38 +0200
Message-ID: <1459935278-4181-1-git-send-email-wsa@the-dreams.de>
References: <1459934734-3613-6-git-send-email-wsa@the-dreams.de>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1459934734-3613-6-git-send-email-wsa@the-dreams.de>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, Simon Horman <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: linux-mmc@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

There is no reason to have a public and private header file. Merge them
into a private one, so looking up symbols is less confusing.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

change since v1: correct authorship. Sorry for the noise.

 drivers/mmc/host/tmio_mmc.h     | 56 ++++++++++++++++++++++++++++++-
 drivers/mmc/host/tmio_mmc_dma.c |  1 -
 drivers/mmc/host/tmio_mmc_pio.c |  1 -
 include/linux/mmc/tmio.h        | 73 -----------------------------------------
 4 files changed, 55 insertions(+), 76 deletions(-)
 delete mode 100644 include/linux/mmc/tmio.h

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 032188b766defd..439fdad2bad91d 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -1,6 +1,8 @@
 /*
  * linux/drivers/mmc/host/tmio_mmc.h
  *
+ * Copyright (C) 2016 Sang Engineering, Wolfram Sang
+ * Copyright (C) 2015-16 Renesas Electronics Corporation
  * Copyright (C) 2007 Ian Molton
  * Copyright (C) 2004 Ian Molton
  *
@@ -18,12 +20,64 @@
 
 #include <linux/dmaengine.h>
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
+#define TMIO_STATUS2_DAT0	BIT(7)
+
+#define	CLK_CTL_DIV_MASK	0xff
+#define	CLK_CTL_SCLKEN		BIT(8)
+
+#define TMIO_BBS		512		/* Boot block size */
+
 /* Definitions for values the CTRL_SDIO_STATUS register can take. */
 #define TMIO_SDIO_STAT_IOIRQ	0x0001
 #define TMIO_SDIO_STAT_EXPUB52	0x4000
diff --git a/drivers/mmc/host/tmio_mmc_dma.c b/drivers/mmc/host/tmio_mmc_dma.c
index 67543587382312..d1573687515d2c 100644
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
index 879e0f5455ef44..15e6f6d5a42337 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -39,7 +39,6 @@
 #include <linux/mmc/host.h>
 #include <linux/mmc/mmc.h>
 #include <linux/mmc/slot-gpio.h>
-#include <linux/mmc/tmio.h>
 #include <linux/module.h>
 #include <linux/pagemap.h>
 #include <linux/platform_device.h>
diff --git a/include/linux/mmc/tmio.h b/include/linux/mmc/tmio.h
deleted file mode 100644
index b2f28e99503383..00000000000000
--- a/include/linux/mmc/tmio.h
+++ /dev/null
@@ -1,73 +0,0 @@
-/*
- * include/linux/mmc/tmio.h
- *
- * Copyright (C) 2016 Sang Engineering, Wolfram Sang
- * Copyright (C) 2015-16 Renesas Electronics Corporation
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
-#define TMIO_STATUS2_DAT0	BIT(7)
-
-#define	CLK_CTL_DIV_MASK	0xff
-#define	CLK_CTL_SCLKEN		BIT(8)
-
-#define TMIO_BBS		512		/* Boot block size */
-
-#endif /* LINUX_MMC_TMIO_H */
-- 
2.7.0

