From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH 3/7] mmc: omap_hsmmc: update error code for response_busy cmd
Date: Mon, 19 Nov 2012 21:59:57 +0530
Message-ID: <1353342601-15210-3-git-send-email-svenkatr@ti.com>
References: <1353342601-15210-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42112 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753767Ab2KSQaj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Nov 2012 11:30:39 -0500
In-Reply-To: <1353342601-15210-1-git-send-email-svenkatr@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Balaji T K <balajitk@ti.com>, Venkatraman S <svenkatr@ti.com>

From: Balaji T K <balajitk@ti.com>

update error code to cmd->error for commands with response_busy and no data

Signed-off-by: Balaji T K <balajitk@ti.com>
Reviewed-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Venkatraman S <svenkatr@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 2d90da8..571cd80 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -981,8 +981,8 @@ static void hsmmc_command_incomplete(struct omap_hsmmc_host *host,
 	if (host->data) {
 		omap_hsmmc_reset_controller_fsm(host, SRD);
 		omap_hsmmc_dma_cleanup(host, err);
-	}
-
+	} else if (host->mrq && host->mrq->cmd)
+		host->mrq->cmd->error = err;
 }
 
 static void omap_hsmmc_do_irq(struct omap_hsmmc_host *host, int status)
-- 
1.8.0

