From: Simon Horman <horms@verge.net.au>
Subject: [PATCH 1/4] mmc: tmio_mmc: Move some defines into a shared header
Date: Mon, 14 Mar 2011 11:57:12 +0900
Message-ID: <1300071435-26759-2-git-send-email-horms@verge.net.au>
References: <1300071435-26759-1-git-send-email-horms@verge.net.au>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:40249 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753641Ab1CNC50 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 13 Mar 2011 22:57:26 -0400
In-Reply-To: <1300071435-26759-1-git-send-email-horms@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Paul Mundt <lethal@linux-sh.org>, Simon Horman <horms@verge.net.au>

Also add TMIO_BBS.

This allows these defines to also be used by zboot.

Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Simon Horman <horms@verge.net.au>

---

This almost certainly conflicts with recent work by Guennadi.
Though it should be trivial for either of us to rebase our patches.
---
 drivers/mmc/host/tmio_mmc.c |   46 +--------------------------------------
 include/linux/mmc/tmio.h    |   49 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 44 deletions(-)
 create mode 100644 include/linux/mmc/tmio.h

diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index e3c6ef2..c1a81f8 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -36,55 +36,13 @@
 #include <linux/mfd/core.h>
 #include <linux/mfd/tmio.h>
 #include <linux/mmc/host.h>
+#include <linux/mmc/tmio.h>
 #include <linux/module.h>
 #include <linux/pagemap.h>
 #include <linux/scatterlist.h>
 #include <linux/workqueue.h>
 #include <linux/spinlock.h>
 
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
 #define TMIO_SDIO_STAT_IOIRQ	0x0001
 #define TMIO_SDIO_STAT_EXPUB52	0x4000
@@ -1290,7 +1248,7 @@ static int __devinit tmio_mmc_probe(struct platform_device *dev)
 	mmc->f_max = pdata->hclk;
 	mmc->f_min = mmc->f_max / 512;
 	mmc->max_segs = 32;
-	mmc->max_blk_size = 512;
+	mmc->max_blk_size = TMIO_BBS;
 	mmc->max_blk_count = (PAGE_CACHE_SIZE / mmc->max_blk_size) *
 		mmc->max_segs;
 	mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
diff --git a/include/linux/mmc/tmio.h b/include/linux/mmc/tmio.h
new file mode 100644
index 0000000..cb3f868
--- /dev/null
+++ b/include/linux/mmc/tmio.h
@@ -0,0 +1,49 @@
+#ifndef TMIO_MMC_H
+#define TMIO_MMC_H
+
+#define CTL_SD_CMD			0x00
+#define CTL_ARG_REG			0x04
+#define CTL_STOP_INTERNAL_ACTION	0x08
+#define CTL_XFER_BLK_COUNT		0xa
+#define CTL_RESPONSE			0x0c
+#define CTL_STATUS			0x1c
+#define CTL_IRQ_MASK			0x20
+#define CTL_SD_CARD_CLK_CTL		0x24
+#define CTL_SD_XFER_LEN			0x26
+#define CTL_SD_MEM_CARD_OPT		0x28
+#define CTL_SD_ERROR_DETAIL_STATUS	0x2c
+#define CTL_SD_DATA_PORT		0x30
+#define CTL_TRANSACTION_CTL		0x34
+#define CTL_SDIO_STATUS			0x36
+#define CTL_SDIO_IRQ_MASK		0x38
+#define CTL_RESET_SD			0xe0
+#define CTL_SDIO_REGS			0x100
+#define CTL_CLK_AND_WAIT_CTL		0x138
+#define CTL_RESET_SDIO			0x1e0
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
+#define TMIO_BBS	512
+
+#endif
-- 
1.7.2.3

