From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 8/9] mmc: omap_hsmmc: Extend debugfs for SDIO IRQ, GPIO and pinmux
Date: Fri, 21 Mar 2014 21:47:37 +0530
Message-ID: <1395418658-2375-9-git-send-email-balajitk@ti.com>
References: <1395404448-30030-2-git-send-email-afenkart@gmail.com>
 <1395418658-2375-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45961 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761048AbaCUQSE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Mar 2014 12:18:04 -0400
In-Reply-To: <1395418658-2375-1-git-send-email-balajitk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, chris@printf.net
Cc: linux-omap@vger.kernel.org, Andreas Fenkart <afenkart@gmail.com>, Tony Lindgren <tony@atomide.com>, Balaji T K <balajitk@ti.com>

From: Andreas Fenkart <afenkart@gmail.com>

Add SDIO IRQ entries to debugfs entry. Note that PSTATE shows current
state of data lines, incl. SDIO IRQ pending

Signed-off-by: Andreas Fenkart <afenkart@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Balaji T K <balajitk@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |   23 ++++++++++++++++++++---
 1 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index dc23ac7..2482783 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -56,6 +56,7 @@
 #define OMAP_HSMMC_RSP54	0x0118
 #define OMAP_HSMMC_RSP76	0x011C
 #define OMAP_HSMMC_DATA		0x0120
+#define OMAP_HSMMC_PSTATE	0x0124
 #define OMAP_HSMMC_HCTL		0x0128
 #define OMAP_HSMMC_SYSCTL	0x012C
 #define OMAP_HSMMC_STAT		0x0130
@@ -1865,14 +1866,30 @@ static int omap_hsmmc_regs_show(struct seq_file *s, void *data)
 {
 	struct mmc_host *mmc = s->private;
 	struct omap_hsmmc_host *host = mmc_priv(mmc);
+	const char *cirq_state;
+	bool suspended;
 
-	seq_printf(s, "mmc%d:\n ctx_loss:\t%d\n\nregs:\n",
-			mmc->index, host->context_loss);
+	seq_printf(s, "mmc%d:\n", mmc->index);
+	if (mmc->caps & MMC_CAP_SDIO_IRQ)
+		cirq_state = (host->flags & HSMMC_SDIO_IRQ_ENABLED) ?
+			"enabled" : "disabled";
+	else
+		cirq_state = "polling";
+	seq_printf(s, "sdio irq\t%s\n", cirq_state);
 
-	pm_runtime_get_sync(host->dev);
+	if (host->flags & HSMMC_SWAKEUP_QUIRK) {
+		suspended = host->dev->power.runtime_status != RPM_ACTIVE;
+		seq_printf(s, "pinmux config\t%s\n", (suspended ?
+						      "gpio" : "sdio"));
+	}
+	seq_printf(s, "ctx_loss:\t%d\n", host->context_loss);
 
+	pm_runtime_get_sync(host->dev);
+	seq_puts(s, "\nregs:\n");
 	seq_printf(s, "CON:\t\t0x%08x\n",
 			OMAP_HSMMC_READ(host->base, CON));
+	seq_printf(s, "PSTATE:\t\t0x%08x\n",
+		   OMAP_HSMMC_READ(host->base, PSTATE));
 	seq_printf(s, "HCTL:\t\t0x%08x\n",
 			OMAP_HSMMC_READ(host->base, HCTL));
 	seq_printf(s, "SYSCTL:\t\t0x%08x\n",
-- 
1.7.5.4

