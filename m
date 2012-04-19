From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH 1/2] mmc: omap_hsmmc: Add fclk frequency to debufs
Date: Thu, 19 Apr 2012 10:23:10 +0530
Message-ID: <1334811190-21025-1-git-send-email-svenkatr@ti.com>
References: <CANfBPZ9iQRsaqDkcxNcu9BePZQhTGYc50pSUYNVdt00Ab5Tsrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40317 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751016Ab2DSExl (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 19 Apr 2012 00:53:41 -0400
In-Reply-To: <CANfBPZ9iQRsaqDkcxNcu9BePZQhTGYc50pSUYNVdt00Ab5Tsrw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Viswanath Puttagunta <vishp@ti.com>, Venkatraman S <svenkatr@ti.com>

From: Viswanath Puttagunta <vishp@ti.com>

Add mmc functional clock frequency to list of
internal state variables to display for debug.

Signed-off-by: Viswanath Puttagunta <vishp@ti.com>
Signed-off-by: Venkatraman S <svenkatr@ti.com>
---
	v1 -> v2: Restored indentation to be consistent
		  as the rest of the file.
 drivers/mmc/host/omap_hsmmc.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index d15b149..5d0ce20 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1683,8 +1683,9 @@ static int omap_hsmmc_regs_show(struct seq_file *s, void *data)
 	if (host->pdata->get_context_loss_count)
 		context_loss = host->pdata->get_context_loss_count(host->dev);
 
-	seq_printf(s, "mmc%d:\n ctx_loss:\t%d:%d\n\nregs:\n",
-			mmc->index, host->context_loss, context_loss);
+	seq_printf(s, "mmc%d:\n ctx_loss:\t%d:%d\n fclk:\t\t%lu Hz\n\nregs:\n",
+			mmc->index, host->context_loss, context_loss,
+			clk_get_rate(host->fclk));
 
 	if (host->suspended) {
 		seq_printf(s, "host suspended, can't read registers\n");
-- 
1.7.10.rc2

