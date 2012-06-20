From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 6/7 v4] mmc: tmio: use MMC opcode defines instead of numbers
Date: Wed, 20 Jun 2012 19:10:35 +0200
Message-ID: <1340212236-647-7-git-send-email-g.liakhovetski@gmx.de>
References: <1340212236-647-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1340212236-647-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-mmc@vger.kernel.org

mmc.h defines macros for most frequently used MMC opcodes. Use them instead
of hard-coded numbers.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/tmio_mmc_pio.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 410b8cf..2050827 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -36,6 +36,7 @@
 #include <linux/mfd/tmio.h>
 #include <linux/mmc/cd-gpio.h>
 #include <linux/mmc/host.h>
+#include <linux/mmc/mmc.h>
 #include <linux/mmc/tmio.h>
 #include <linux/module.h>
 #include <linux/pagemap.h>
@@ -305,8 +306,8 @@ static int tmio_mmc_start_command(struct tmio_mmc_host *host, struct mmc_command
 	int c = cmd->opcode;
 	u32 irq_mask = TMIO_MASK_CMD;
 
-	/* Command 12 is handled by hardware */
-	if (cmd->opcode == 12 && !cmd->arg) {
+	/* CMD12 is handled by hardware */
+	if (cmd->opcode == MMC_STOP_TRANSMISSION && !cmd->arg) {
 		sd_ctrl_write16(host, CTL_STOP_INTERNAL_ACTION, 0x001);
 		return 0;
 	}
@@ -449,7 +450,7 @@ void tmio_mmc_do_data_irq(struct tmio_mmc_host *host)
 	}
 
 	if (stop) {
-		if (stop->opcode == 12 && !stop->arg)
+		if (stop->opcode == MMC_STOP_TRANSMISSION && !stop->arg)
 			sd_ctrl_write16(host, CTL_STOP_INTERNAL_ACTION, 0x000);
 		else
 			BUG();
-- 
1.7.2.5

