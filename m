From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 7/8 v3] mmc: tmio: use MMC opcode defines instead of numbers
Date: Fri, 25 May 2012 17:45:33 +0200
Message-ID: <1337960752-4944-19-git-send-email-g.liakhovetski@gmx.de>
References: <Pine.LNX.4.64.1205251727260.13353@axis700.grange>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1205251727260.13353@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-mmc@vger.kernel.org

mmc.h defines macros for most frequently used MMC opcodes. Use them instead
of hard-coded numbers.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/tmio_mmc_pio.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index baa0959..a4f1c59 100644
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

--
To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
