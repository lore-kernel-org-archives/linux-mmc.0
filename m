From: Balaji T K <balajitk@ti.com>
Subject: [PATCH v2 5/6] mmc: omap_hsmmc: fix cmd23 multiblock read/write
Date: Fri, 9 May 2014 22:16:52 +0530
Message-ID: <1399654013-28262-6-git-send-email-balajitk@ti.com>
References: <1399654013-28262-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33568 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756948AbaEIQrG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 9 May 2014 12:47:06 -0400
In-Reply-To: <1399654013-28262-1-git-send-email-balajitk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, chris@printf.net, ulf.hansson@linaro.org
Cc: linux-omap@vger.kernel.org, Balaji T K <balajitk@ti.com>

Check for set block count command fails always since host->cmd is
set to NULL in the same function incorrectly. Correct host->cmd usage properly.

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 140425c..cba71d6 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -920,16 +920,17 @@ omap_hsmmc_xfer_done(struct omap_hsmmc_host *host, struct mmc_data *data)
 static void
 omap_hsmmc_cmd_done(struct omap_hsmmc_host *host, struct mmc_command *cmd)
 {
-	host->cmd = NULL;
-
 	if (host->mrq->sbc && (host->cmd == host->mrq->sbc) &&
 	    !host->mrq->sbc->error && !(host->flags & AUTO_CMD23)) {
+		host->cmd = NULL;
 		omap_hsmmc_start_dma_transfer(host);
 		omap_hsmmc_start_command(host, host->mrq->cmd,
 						host->mrq->data);
 		return;
 	}
 
+	host->cmd = NULL;
+
 	if (cmd->flags & MMC_RSP_PRESENT) {
 		if (cmd->flags & MMC_RSP_136) {
 			/* response type 2 */
-- 
1.7.5.4

