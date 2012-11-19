From: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
Subject: [PATCH 1/3] mmc: omap_hsmmc: NULL pointer upon DTO after CC.
Date: Mon, 19 Nov 2012 22:42:57 +0100
Message-ID: <1353361379-21002-2-git-send-email-andreas.fenkart@streamunlimited.com>
References: <1353361379-21002-1-git-send-email-andreas.fenkart@streamunlimited.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:49293 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752321Ab2KSVni (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Nov 2012 16:43:38 -0500
In-Reply-To: <1353361379-21002-1-git-send-email-andreas.fenkart@streamunlimited.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: david.vrabel@csr.com, daniel@zonque.org, Andreas Fenkart <andreas.fenkart@streamunlimited.com>

Signed-off-by: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
---
 drivers/mmc/host/omap_hsmmc.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 21ca331..13ef4a0 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -991,9 +991,12 @@ static inline void omap_hsmmc_reset_controller_fsm(struct omap_hsmmc_host *host,
 static void hsmmc_command_incomplete(struct omap_hsmmc_host *host, int err)
 {
 	omap_hsmmc_reset_controller_fsm(host, SRC);
-	host->cmd->error = err;
+
+	if (host->cmd)
+		host->cmd->error = err;
 
 	if (host->data) {
+		host->data->error = err;
 		omap_hsmmc_reset_controller_fsm(host, SRD);
 		omap_hsmmc_dma_cleanup(host, err);
 	}
@@ -1022,7 +1025,7 @@ static void omap_hsmmc_do_irq(struct omap_hsmmc_host *host, int status)
 		}
 	}
 
-	if (end_cmd || ((status & CC) && host->cmd))
+	if ((end_cmd || (status & CC)) && host->cmd)
 		omap_hsmmc_cmd_done(host, host->cmd);
 	if ((end_trans || (status & TC)) && host->mrq)
 		omap_hsmmc_xfer_done(host, data);
-- 
1.7.10.4

