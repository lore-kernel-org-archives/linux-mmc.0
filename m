From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH 08/22] mmc: omap_hsmmc: correct debug report error status mnemonics
Date: Thu,  5 May 2011 14:51:08 +0300
Message-ID: <1304596282-4095-9-git-send-email-adrian.hunter@nokia.com>
References: <1304596282-4095-1-git-send-email-adrian.hunter@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1304596282-4095-1-git-send-email-adrian.hunter@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Madhusudhan Chikkature <madhu.cr@ti.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Adrian Hunter <adrian.hunter@nokia.com>
List-Id: linux-mmc@vger.kernel.org

CERR and BADA were in the wrong place and there are only
32 not 35.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 drivers/mmc/host/omap_hsmmc.c |   19 +++++++++++--------
 1 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index bd52849..a1a1101 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -982,14 +982,14 @@ static void omap_hsmmc_dma_cleanup(struct omap_hsmmc_host *host, int errno)
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
@@ -1006,6 +1006,11 @@ static void omap_hsmmc_report_irq(struct omap_hsmmc_host *host, u32 status)
 
 	dev_dbg(mmc_dev(host->mmc), "%s\n", res);
 }
+#else
+static inline void omap_hsmmc_dbg_report_irq(struct omap_hsmmc_host *host,
+					     u32 status)
+{
+}
 #endif  /* CONFIG_MMC_DEBUG */
 
 /*
@@ -1064,9 +1069,7 @@ static void omap_hsmmc_do_irq(struct omap_hsmmc_host *host, int status)
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

