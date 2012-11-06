From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH 1/5] mmc: omap_hsmmc: Avoid host->cmd dereference during data transfer failures
Date: Tue, 6 Nov 2012 22:22:12 +0530
Message-ID: <1352220737-14071-2-git-send-email-svenkatr@ti.com>
References: <1352220737-14071-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38102 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750866Ab2KFQwf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 6 Nov 2012 11:52:35 -0500
In-Reply-To: <1352220737-14071-1-git-send-email-svenkatr@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Venkatraman S <svenkatr@ti.com>, stable@vger.kernel.org

Sometimes, a error occurs just after the Command has been reported
to be successful (CC=1) but before data transfer completes (TC=1).
Setting end_cmd=1 here leads to a NULL pointer dereference of
host->cmd as the command complete has previously been handled.

Set end_cmd only when command complete has not been handled
before, else a NULL pointer dereference occurs.

CC: stable@vger.kernel.org
Signed-off-by: Venkatraman S <svenkatr@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 5434fd8..06d2e03 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -996,7 +996,8 @@ static void omap_hsmmc_do_irq(struct omap_hsmmc_host *host, int status)
 		else if (status & (CMD_CRC | DATA_CRC))
 			hsmmc_command_incomplete(host, -EILSEQ);
 
-		end_cmd = 1;
+		if (host->cmd)
+			end_cmd = 1;
 		if (host->data || host->response_busy) {
 			end_trans = 1;
 			host->response_busy = 0;
-- 
1.8.0

