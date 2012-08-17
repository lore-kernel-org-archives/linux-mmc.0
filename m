From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH 05/10] mmc: omap_hsmmc: remove unused vars and includes
Date: Sat, 18 Aug 2012 00:22:25 +0530
Message-ID: <1345229550-8672-6-git-send-email-svenkatr@ti.com>
References: <1345229550-8672-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40408 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932379Ab2HQSxv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 17 Aug 2012 14:53:51 -0400
In-Reply-To: <1345229550-8672-1-git-send-email-svenkatr@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: cjb@laptop.org, balajitk@ti.com, vishp@ti.com, Venkatraman S <svenkatr@ti.com>

Some straight forward cleanup of unnecessary #include's
and host variables. Some of the verbose and redundant
debug messages are converted to use dev_vdbg.

Signed-off-by: Venkatraman S <svenkatr@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index e180735..da4f5a7 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -35,7 +35,6 @@
 #include <linux/mmc/core.h>
 #include <linux/mmc/mmc.h>
 #include <linux/io.h>
-#include <linux/semaphore.h>
 #include <linux/gpio.h>
 #include <linux/regulator/consumer.h>
 #include <linux/pm_runtime.h>
@@ -162,8 +161,6 @@ struct omap_hsmmc_host {
 	unsigned int		dma_sg_idx;
 	unsigned char		bus_mode;
 	unsigned char		power_mode;
-	u32			*buffer;
-	u32			bytesleft;
 	int			suspended;
 	int			irq;
 	int			use_dma, dma_ch;
@@ -172,7 +169,6 @@ struct omap_hsmmc_host {
 	int			slot_id;
 	int			response_busy;
 	int			context_loss;
-	int			vdd;
 	int			protect_card;
 	int			reqs_blocked;
 	int			use_reg;
@@ -496,7 +492,7 @@ static void omap_hsmmc_set_clock(struct omap_hsmmc_host *host)
 	unsigned long regval;
 	unsigned long timeout;
 
-	dev_dbg(mmc_dev(host->mmc), "Set clock to %uHz\n", ios->clock);
+	dev_vdbg(mmc_dev(host->mmc), "Set clock to %uHz\n", ios->clock);
 
 	omap_hsmmc_stop_clock(host);
 
@@ -746,7 +742,7 @@ omap_hsmmc_start_command(struct omap_hsmmc_host *host, struct mmc_command *cmd,
 {
 	int cmdreg = 0, resptype = 0, cmdtype = 0;
 
-	dev_dbg(mmc_dev(host->mmc), "%s: CMD%d, argument 0x%08x\n",
+	dev_vdbg(mmc_dev(host->mmc), "%s: CMD%d, argument 0x%08x\n",
 		mmc_hostname(host->mmc), cmd->opcode, cmd->arg);
 	host->cmd = cmd;
 
@@ -935,7 +931,7 @@ static void omap_hsmmc_dbg_report_irq(struct omap_hsmmc_host *host, u32 status)
 			buf += len;
 		}
 
-	dev_dbg(mmc_dev(host->mmc), "%s\n", res);
+	dev_vdbg(mmc_dev(host->mmc), "%s\n", res);
 }
 #else
 static inline void omap_hsmmc_dbg_report_irq(struct omap_hsmmc_host *host,
@@ -997,7 +993,7 @@ static void omap_hsmmc_do_irq(struct omap_hsmmc_host *host, int status)
 	}
 
 	data = host->data;
-	dev_dbg(mmc_dev(host->mmc), "IRQ Status is %x\n", status);
+	dev_vdbg(mmc_dev(host->mmc), "IRQ Status is %x\n", status);
 
 	if (status & ERR) {
 		omap_hsmmc_dbg_report_irq(host, status);
@@ -1502,12 +1498,10 @@ static void omap_hsmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		case MMC_POWER_OFF:
 			mmc_slot(host).set_power(host->dev, host->slot_id,
 						 0, 0);
-			host->vdd = 0;
 			break;
 		case MMC_POWER_UP:
 			mmc_slot(host).set_power(host->dev, host->slot_id,
 						 1, ios->vdd);
-			host->vdd = ios->vdd;
 			break;
 		case MMC_POWER_ON:
 			do_send_init_stream = 1;
-- 
1.7.11.1.25.g0e18bef

