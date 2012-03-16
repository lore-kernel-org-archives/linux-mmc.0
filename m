From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH v2 1/8] mmc: omap: Enable Auto CMD12
Date: Fri, 16 Mar 2012 19:08:57 +0530
Message-ID: <1331905144-31655-2-git-send-email-svenkatr@ti.com>
References: <y>
 <1331905144-31655-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48107 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030441Ab2CPNkD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 16 Mar 2012 09:40:03 -0400
In-Reply-To: <1331905144-31655-1-git-send-email-svenkatr@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: cjb@laptop.org, balajitk@ti.com, balbi@ti.com, Venkatraman S <svenkatr@ti.com>

From: Balaji T K <balajitk@ti.com>

Enable Auto-CMD12 for multi block read/write on HSMMC
Tested on OMAP4430, OMAP3430 and OMAP2430 SDP

Signed-off-by: Balaji T K <balajitk@ti.com>
Signed-off-by: Venkatraman S <svenkatr@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |   16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index f29e1a2..a9ffd70 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -85,6 +85,7 @@
 #define BRR_ENABLE		(1 << 5)
 #define DTO_ENABLE		(1 << 20)
 #define INIT_STREAM		(1 << 1)
+#define ACEN_ACMD12		(1 << 2)
 #define DP_SELECT		(1 << 21)
 #define DDIR			(1 << 4)
 #define DMA_EN			0x1
@@ -115,6 +116,7 @@
 #define OMAP_MMC_MAX_CLOCK	52000000
 #define DRIVER_NAME		"omap_hsmmc"
 
+#define AUTO_CMD12		(1 << 0)	/* Auto CMD12 support */
 /*
  * One controller can have multiple slots, like on some omap boards using
  * omap.c controller driver. Luckily this is not currently done on any known
@@ -175,6 +177,7 @@ struct omap_hsmmc_host {
 	int			reqs_blocked;
 	int			use_reg;
 	int			req_in_progress;
+	unsigned int		flags;
 	struct omap_hsmmc_next	next_data;
 
 	struct	omap_mmc_platform_data	*pdata;
@@ -766,6 +769,8 @@ omap_hsmmc_start_command(struct omap_hsmmc_host *host, struct mmc_command *cmd,
 		cmdtype = 0x3;
 
 	cmdreg = (cmd->opcode << 24) | (resptype << 16) | (cmdtype << 22);
+	if ((host->flags & AUTO_CMD12) && mmc_op_multi(cmd->opcode))
+		cmdreg |= ACEN_ACMD12;
 
 	if (data) {
 		cmdreg |= DP_SELECT | MSBS | BCE;
@@ -837,11 +842,15 @@ omap_hsmmc_xfer_done(struct omap_hsmmc_host *host, struct mmc_data *data)
 	else
 		data->bytes_xfered = 0;
 
-	if (!data->stop) {
+	if (data->stop && ((!(host->flags & AUTO_CMD12)) || data->error)) {
+		omap_hsmmc_start_command(host, data->stop, NULL);
+	}
+	else {
+		if (data->stop)
+			data->stop->resp[0] = OMAP_HSMMC_READ(host->base,
+							RSP76);
 		omap_hsmmc_request_done(host, data->mrq);
-		return;
 	}
-	omap_hsmmc_start_command(host, data->stop, NULL);
 }
 
 /*
@@ -1826,6 +1835,7 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
 	host->mapbase	= res->start;
 	host->base	= ioremap(host->mapbase, SZ_4K);
 	host->power_mode = MMC_POWER_OFF;
+	host->flags	= AUTO_CMD12;
 	host->next_data.cookie = 1;
 
 	platform_set_drvdata(pdev, host);
-- 
1.7.10.rc0.41.gfa678

