From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH 04/10] mmc: omap: fix mmc_omap_report_irq to use dev_dbg macros
Date: Sat, 18 Aug 2012 00:22:24 +0530
Message-ID: <1345229550-8672-5-git-send-email-svenkatr@ti.com>
References: <1345229550-8672-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55046 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932379Ab2HQSxn (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 17 Aug 2012 14:53:43 -0400
In-Reply-To: <1345229550-8672-1-git-send-email-svenkatr@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: cjb@laptop.org, balajitk@ti.com, vishp@ti.com, Venkatraman S <svenkatr@ti.com>

The function mmc_omap_report_irq uses raw printks and the
actual output was disabled by a static variable. Make
the function use dev_vdbg macro and use it under the
standard CONFIG_MMC_DEBUG flag.

Signed-off-by: Venkatraman S <svenkatr@ti.com>
---
 drivers/mmc/host/omap.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 0ec4e55..614f63c 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -679,22 +679,29 @@ mmc_omap_xfer_data(struct mmc_omap_host *host, int write)
 	}
 }
 
-static inline void mmc_omap_report_irq(u16 status)
+#ifdef CONFIG_MMC_DEBUG
+static void mmc_omap_report_irq(struct mmc_omap_host *host, u16 status)
 {
 	static const char *mmc_omap_status_bits[] = {
 		"EOC", "CD", "CB", "BRS", "EOFB", "DTO", "DCRC", "CTO",
 		"CCRC", "CRW", "AF", "AE", "OCRB", "CIRQ", "CERR"
 	};
-	int i, c = 0;
+	int i;
+	char res[64], *buf = res;
+
+	buf += sprintf(buf, "MMC IRQ 0x%x:", status);
 
 	for (i = 0; i < ARRAY_SIZE(mmc_omap_status_bits); i++)
-		if (status & (1 << i)) {
-			if (c)
-				printk(" ");
-			printk("%s", mmc_omap_status_bits[i]);
-			c++;
-		}
+		if (status & (1 << i))
+			buf += sprintf(buf, " %s", mmc_omap_status_bits[i]);
+	dev_vdbg(mmc_dev(host->mmc), "%s\n", res);
+}
+#else
+static void mmc_omap_report_irq(struct mmc_omap_host *host, u16 status)
+{
 }
+#endif
+
 
 static irqreturn_t mmc_omap_irq(int irq, void *dev_id)
 {
@@ -728,12 +735,10 @@ static irqreturn_t mmc_omap_irq(int irq, void *dev_id)
 			cmd = host->cmd->opcode;
 		else
 			cmd = -1;
-#ifdef CONFIG_MMC_DEBUG
 		dev_dbg(mmc_dev(host->mmc), "MMC IRQ %04x (CMD %d): ",
 			status, cmd);
-		mmc_omap_report_irq(status);
-		printk("\n");
-#endif
+		mmc_omap_report_irq(host, status);
+
 		if (host->total_bytes_left) {
 			if ((status & OMAP_MMC_STAT_A_FULL) ||
 			    (status & OMAP_MMC_STAT_END_OF_DATA))
-- 
1.7.11.1.25.g0e18bef

