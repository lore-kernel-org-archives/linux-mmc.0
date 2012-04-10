From: Viswanath Puttagunta <vishp@ti.com>
Subject: [PATCH] mmc: omap: Add fclk frequency to debufs
Date: Tue, 10 Apr 2012 11:26:36 -0500
Message-ID: <1334075196-26493-1-git-send-email-vishp@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50912 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751409Ab2DJQ0j (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 10 Apr 2012 12:26:39 -0400
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id q3AGQdqu010557
	for <linux-mmc@vger.kernel.org>; Tue, 10 Apr 2012 11:26:39 -0500
Received: from DLEE74.ent.ti.com (dlee74.ent.ti.com [157.170.170.8])
	by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id q3AGQdgd004330
	for <linux-mmc@vger.kernel.org>; Tue, 10 Apr 2012 11:26:39 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linux MMC Mainling List <linux-mmc@vger.kernel.org>
Cc: T Krishnamoorthy Balaji <balajitk@ti.com>, Venkatraman S <svenkatr@ti.com>, Viswanath Puttagunta <vishp@ti.com>

Add mmc functional clock frequency to list of
internal state variables to display for debug.

Signed-off-by: Viswanath Puttagunta <vishp@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 5c2b1c1..ee1f2d8 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1668,8 +1668,9 @@ static int omap_hsmmc_regs_show(struct seq_file *s, void *data)
 	if (host->pdata->get_context_loss_count)
 		context_loss = host->pdata->get_context_loss_count(host->dev);
 
-	seq_printf(s, "mmc%d:\n ctx_loss:\t%d:%d\n\nregs:\n",
-			mmc->index, host->context_loss, context_loss);
+	seq_printf(s, "mmc%d:\n ctx_loss:\t%d:%d\n fclk:\t\t%lu Hz\n\nregs:\n",
+			mmc->index, host->context_loss, context_loss,
+					   clk_get_rate(host->fclk));
 
 	if (host->suspended) {
 		seq_printf(s, "host suspended, can't read registers\n");
-- 
1.7.4.1

