From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: [PATCH 7/7] mmc: omap: Add erase capability
Date: Wed,  4 Dec 2013 21:14:14 +0000
Message-ID: <1386191654-7686-8-git-send-email-jarkko.nikula@bitmer.com>
References: <20131202193459.GL26766@atomide.com>
 <1386191654-7686-1-git-send-email-jarkko.nikula@bitmer.com>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1386191654-7686-1-git-send-email-jarkko.nikula@bitmer.com>
Sender: linux-omap-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Dan Carpenter <dan.carpenter@oracle.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Jarkko Lavinen <j.lavinen@samsung.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-mmc@vger.kernel.org

This patch adds the erase capability to OMAP1/OMAP2420 MMC driver. Idea is
the same than in commit 93caf8e ("omap_hsmmc: add erase capability") that we
disable the data timeout interrupt for erases.

Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
---
 drivers/mmc/host/omap.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 42175cd..5c2e58b 100644
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
1.8.4.3

