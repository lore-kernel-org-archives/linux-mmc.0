From: Ming Lei <ming.lei@canonical.com>
Subject: [RFC PATCH] Revert "mmc: omap_hsmmc: Enable Auto CMD12"
Date: Fri, 22 Jun 2012 18:49:35 +0800
Message-ID: <1340362175-25807-1-git-send-email-ming.lei@canonical.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:59093 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757881Ab2FVKuz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Jun 2012 06:50:55 -0400
Received: by pbbrp8 with SMTP id rp8so3400415pbb.19
        for <linux-mmc@vger.kernel.org>; Fri, 22 Jun 2012 03:50:55 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Ming Lei <ming.lei@canonical.com>, Balaji T K <balajitk@ti.com>, Venkatraman S <svenkatr@ti.com>

This patch reverts the commit dba3c29ea4a1d5d544.

After bisecting, this commit dba3c29 is found to ruin micro-SD card data
(writing incorrect file, or fs is corrupt after several times mount)
on the beagle-xm revB, and reverting the commit will fix the problem.

Also from TRM of OMAP3/OMAP4/DM37x, the below is mentioned about
the Auto CMD12 Enable bit.
        - SDIO does not support this feature.
        - SD card only.
Looks it is not suitable to always enable Auto CMD12 in host controller
driver.

Considered that the commit is not mature enough, so ask to revert it
first. 

Cc: Balaji T K <balajitk@ti.com>
Cc: Venkatraman S <svenkatr@ti.com>
Buglink: https://lkml.org/lkml/2012/6/10/225
Reported-by: Paolo Pisati <p.pisati@gmail.com>
Reported-bisected-and-tested-by: Ming Lei <ming.lei@canonical.com>
Signed-off-by: Ming Lei <ming.lei@canonical.com>
---
 drivers/mmc/host/omap_hsmmc.c |   15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 9a7a60a..389a3ee 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -85,7 +85,6 @@
 #define BRR_ENABLE		(1 << 5)
 #define DTO_ENABLE		(1 << 20)
 #define INIT_STREAM		(1 << 1)
-#define ACEN_ACMD12		(1 << 2)
 #define DP_SELECT		(1 << 21)
 #define DDIR			(1 << 4)
 #define DMA_EN			0x1
@@ -117,7 +116,6 @@
 #define OMAP_MMC_MAX_CLOCK	52000000
 #define DRIVER_NAME		"omap_hsmmc"
 
-#define AUTO_CMD12		(1 << 0)	/* Auto CMD12 support */
 /*
  * One controller can have multiple slots, like on some omap boards using
  * omap.c controller driver. Luckily this is not currently done on any known
@@ -177,7 +175,6 @@ struct omap_hsmmc_host {
 	int			reqs_blocked;
 	int			use_reg;
 	int			req_in_progress;
-	unsigned int		flags;
 	struct omap_hsmmc_next	next_data;
 
 	struct	omap_mmc_platform_data	*pdata;
@@ -773,8 +770,6 @@ omap_hsmmc_start_command(struct omap_hsmmc_host *host, struct mmc_command *cmd,
 		cmdtype = 0x3;
 
 	cmdreg = (cmd->opcode << 24) | (resptype << 16) | (cmdtype << 22);
-	if ((host->flags & AUTO_CMD12) && mmc_op_multi(cmd->opcode))
-		cmdreg |= ACEN_ACMD12;
 
 	if (data) {
 		cmdreg |= DP_SELECT | MSBS | BCE;
@@ -847,14 +842,11 @@ omap_hsmmc_xfer_done(struct omap_hsmmc_host *host, struct mmc_data *data)
 	else
 		data->bytes_xfered = 0;
 
-	if (data->stop && ((!(host->flags & AUTO_CMD12)) || data->error)) {
-		omap_hsmmc_start_command(host, data->stop, NULL);
-	} else {
-		if (data->stop)
-			data->stop->resp[0] = OMAP_HSMMC_READ(host->base,
-							RSP76);
+	if (!data->stop) {
 		omap_hsmmc_request_done(host, data->mrq);
+		return;
 	}
+	omap_hsmmc_start_command(host, data->stop, NULL);
 }
 
 /*
@@ -1859,7 +1851,6 @@ static int __devinit omap_hsmmc_probe(struct platform_device *pdev)
 	host->mapbase	= res->start + pdata->reg_offset;
 	host->base	= ioremap(host->mapbase, SZ_4K);
 	host->power_mode = MMC_POWER_OFF;
-	host->flags	= AUTO_CMD12;
 	host->next_data.cookie = 1;
 
 	platform_set_drvdata(pdev, host);
-- 
1.7.9.5

