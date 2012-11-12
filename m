From: Balaji T K <balajitk@ti.com>
Subject: [PATCH v3 2/3] mmc: omap_hsmmc: no reset of cmd state machine for DCRC
Date: Mon, 12 Nov 2012 18:36:43 +0530
Message-ID: <1352725604-20390-3-git-send-email-balajitk@ti.com>
References: <1352477176-6673-1-git-send-email-balajitk@ti.com>
 <1352725604-20390-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40282 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752438Ab2KLNGx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 12 Nov 2012 08:06:53 -0500
In-Reply-To: <1352725604-20390-1-git-send-email-balajitk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org
Cc: linux-omap@vger.kernel.org, svenkatr@ti.com, balbi@ti.com, Balaji T K <balajitk@ti.com>

Avoid soft reset of command internal state machine on data errors.

Signed-off-by: Balaji T K <balajitk@ti.com>
Reviewed-by: Felipe Balbi <balbi@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 245d7b5..d931e08 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -971,8 +971,8 @@ static inline void omap_hsmmc_reset_controller_fsm(struct omap_hsmmc_host *host,
 static void hsmmc_command_incomplete(struct omap_hsmmc_host *host,
 					int err, int end_cmd)
 {
-	omap_hsmmc_reset_controller_fsm(host, SRC);
 	if (end_cmd) {
+		omap_hsmmc_reset_controller_fsm(host, SRC);
 		if (host->cmd)
 			host->cmd->error = err;
 	}
-- 
1.7.5.4

