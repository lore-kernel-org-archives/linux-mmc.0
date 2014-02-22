From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: [RESEND 7/7] mmc: omap: Add erase capability
Date: Sat, 22 Feb 2014 18:01:43 +0200
Message-ID: <1393084903-7194-8-git-send-email-jarkko.nikula@bitmer.com>
References: <1393084903-7194-1-git-send-email-jarkko.nikula@bitmer.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:49635 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751690AbaBVQR7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 22 Feb 2014 11:17:59 -0500
In-Reply-To: <1393084903-7194-1-git-send-email-jarkko.nikula@bitmer.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <chris@printf.net>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Jarkko Nikula <jarkko.nikula@bitmer.com>

This patch adds the erase capability to OMAP1/OMAP2420 MMC driver. Idea is
the same than in commit 93caf8e ("omap_hsmmc: add erase capability") that we
disable the data timeout interrupt for erases.

Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
Acked-by: Tony Lindgren <tony@atomide.com>
Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/mmc/host/omap.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 42175cd90435..5c2e58b29305 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -26,6 +26,7 @@
 #include <linux/omap-dma.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/card.h>
+#include <linux/mmc/mmc.h>
 #include <linux/clk.h>
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
@@ -336,6 +337,7 @@ mmc_omap_start_command(struct mmc_omap_host *host, struct mmc_command *cmd)
 	u32 cmdreg;
 	u32 resptype;
 	u32 cmdtype;
+	u16 irq_mask;
 
 	host->cmd = cmd;
 
@@ -388,12 +390,14 @@ mmc_omap_start_command(struct mmc_omap_host *host, struct mmc_command *cmd)
 	OMAP_MMC_WRITE(host, CTO, 200);
 	OMAP_MMC_WRITE(host, ARGL, cmd->arg & 0xffff);
 	OMAP_MMC_WRITE(host, ARGH, cmd->arg >> 16);
-	OMAP_MMC_WRITE(host, IE,
-		       OMAP_MMC_STAT_A_EMPTY    | OMAP_MMC_STAT_A_FULL    |
-		       OMAP_MMC_STAT_CMD_CRC    | OMAP_MMC_STAT_CMD_TOUT  |
-		       OMAP_MMC_STAT_DATA_CRC   | OMAP_MMC_STAT_DATA_TOUT |
-		       OMAP_MMC_STAT_END_OF_CMD | OMAP_MMC_STAT_CARD_ERR  |
-		       OMAP_MMC_STAT_END_OF_DATA);
+	irq_mask = OMAP_MMC_STAT_A_EMPTY    | OMAP_MMC_STAT_A_FULL    |
+		   OMAP_MMC_STAT_CMD_CRC    | OMAP_MMC_STAT_CMD_TOUT  |
+		   OMAP_MMC_STAT_DATA_CRC   | OMAP_MMC_STAT_DATA_TOUT |
+		   OMAP_MMC_STAT_END_OF_CMD | OMAP_MMC_STAT_CARD_ERR  |
+		   OMAP_MMC_STAT_END_OF_DATA;
+	if (cmd->opcode == MMC_ERASE)
+		irq_mask &= ~OMAP_MMC_STAT_DATA_TOUT;
+	OMAP_MMC_WRITE(host, IE, irq_mask);
 	OMAP_MMC_WRITE(host, CMD, cmdreg);
 }
 
@@ -1234,7 +1238,7 @@ static int mmc_omap_new_slot(struct mmc_omap_host *host, int id)
 
 	mmc->caps = 0;
 	if (host->pdata->slots[id].wires >= 4)
-		mmc->caps |= MMC_CAP_4_BIT_DATA;
+		mmc->caps |= MMC_CAP_4_BIT_DATA | MMC_CAP_ERASE;
 
 	mmc->ops = &mmc_omap_ops;
 	mmc->f_min = 400000;
-- 
1.8.5.3

