From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: [PATCH] mmc: atmel-mci: modify CLKDIV displaying in debugfs
Date: Fri,  6 Jul 2012 12:11:51 +0200
Message-ID: <1341569511-11340-1-git-send-email-nicolas.ferre@atmel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:31560 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750946Ab2GFKL7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Jul 2012 06:11:59 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ludovic.Desroches@atmel.com
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nicolas Ferre <nicolas.ferre@atmel.com>

Modify clock division displaying in debugfs for matching
the new CLKDIV,CLKODD user interface arrangement.
Is using the has_odd_clk_div property to choose the proper format.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/mmc/host/atmel-mci.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 1fe20cd..9c5daa2 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -396,11 +396,17 @@ static int atmci_regs_show(struct seq_file *s, void *v)
 	clk_disable(host->mck);
 	spin_unlock_bh(&host->lock);
 
-	seq_printf(s, "MR:\t0x%08x%s%s CLKDIV=%u\n",
+	seq_printf(s, "MR:\t0x%08x%s%s ",
 			buf[ATMCI_MR / 4],
 			buf[ATMCI_MR / 4] & ATMCI_MR_RDPROOF ? " RDPROOF" : "",
-			buf[ATMCI_MR / 4] & ATMCI_MR_WRPROOF ? " WRPROOF" : "",
-			buf[ATMCI_MR / 4] & 0xff);
+			buf[ATMCI_MR / 4] & ATMCI_MR_WRPROOF ? " WRPROOF" : "");
+	if (host->caps.has_odd_clk_div)
+		seq_printf(s, "{CLKDIV,CLKODD}=%u\n",
+				((buf[ATMCI_MR / 4] & 0xff) << 1)
+				| ((buf[ATMCI_MR / 4] >> 16) & 1));
+	else
+		seq_printf(s, "CLKDIV=%u\n",
+				(buf[ATMCI_MR / 4] & 0xff));
 	seq_printf(s, "DTOR:\t0x%08x\n", buf[ATMCI_DTOR / 4]);
 	seq_printf(s, "SDCR:\t0x%08x\n", buf[ATMCI_SDCR / 4]);
 	seq_printf(s, "ARGR:\t0x%08x\n", buf[ATMCI_ARGR / 4]);
-- 
1.7.5.4

