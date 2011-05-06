From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH V2 02/16] mmc: omap_hsmmc: correct debug report error status mnemonics
Date: Fri,  6 May 2011 12:14:01 +0300
Message-ID: <1304673255-31634-3-git-send-email-adrian.hunter@nokia.com>
References: <1304673255-31634-1-git-send-email-adrian.hunter@nokia.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:45637 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755867Ab1EFJPd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 6 May 2011 05:15:33 -0400
In-Reply-To: <1304673255-31634-1-git-send-email-adrian.hunter@nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Madhusudhan Chikkature <madhu.cr@ti.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Adrian Hunter <adrian.hunter@nokia.com>

CERR and BADA were in the wrong place and there are only
32 not 35.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
Reviewed-by: Venkatraman S <svenkatr@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |   19 +++++++++++--------
 1 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 73faaec..0fed8eb 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -970,14 +970,14 @@ static void omap_hsmmc_dma_cleanup(struct omap_hsmmc_host *host, int errno)
  * Readable error output
  */
 #ifdef CONFIG_MMC_DEBUG
-static void omap_hsmmc_report_irq(struct omap_hsmmc_host *host, u32 status)
+static void omap_hsmmc_dbg_report_irq(struct omap_hsmmc_host *host, u32 status)
 {
 	/* --- means reserved bit without definition at documentation */
 	static const char *omap_hsmmc_status_bits[] = {
-		"CC", "TC", "BGE", "---", "BWR", "BRR", "---", "---", "CIRQ",
-		"OBI", "---", "---", "---", "---", "---", "ERRI", "CTO", "CCRC",
-		"CEB", "CIE", "DTO", "DCRC", "DEB", "---", "ACE", "---",
-		"---", "---", "---", "CERR", "CERR", "BADA", "---", "---", "---"
+		"CC"  , "TC"  , "BGE", "---", "BWR" , "BRR" , "---" , "---" ,
+		"CIRQ",	"OBI" , "---", "---", "---" , "---" , "---" , "ERRI",
+		"CTO" , "CCRC", "CEB", "CIE", "DTO" , "DCRC", "DEB" , "---" ,
+		"ACE" , "---" , "---", "---", "CERR", "BADA", "---" , "---"
 	};
 	char res[256];
 	char *buf = res;
@@ -994,6 +994,11 @@ static void omap_hsmmc_report_irq(struct omap_hsmmc_host *host, u32 status)
 
 	dev_dbg(mmc_dev(host->mmc), "%s\n", res);
 }
+#else
+static inline void omap_hsmmc_dbg_report_irq(struct omap_hsmmc_host *host,
+					     u32 status)
+{
+}
 #endif  /* CONFIG_MMC_DEBUG */
 
 /*
@@ -1052,9 +1057,7 @@ static void omap_hsmmc_do_irq(struct omap_hsmmc_host *host, int status)
 	dev_dbg(mmc_dev(host->mmc), "IRQ Status is %x\n", status);
 
 	if (status & ERR) {
-#ifdef CONFIG_MMC_DEBUG
-		omap_hsmmc_report_irq(host, status);
-#endif
+		omap_hsmmc_dbg_report_irq(host, status);
 		if ((status & CMD_TIMEOUT) ||
 			(status & CMD_CRC)) {
 			if (host->cmd) {
-- 
1.7.0.4

