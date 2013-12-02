From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH v5 3/3] mmc: omap_hsmmc: Extend debugfs for SDIO IRQ, GPIO and pinmux.
Date: Tue,  3 Dec 2013 00:21:52 +0100
Message-ID: <1386026512-23446-4-git-send-email-afenkart@gmail.com>
References: <1386026512-23446-1-git-send-email-afenkart@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ee0-f53.google.com ([74.125.83.53]:55621 "EHLO
	mail-ee0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753894Ab3LBXZV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Dec 2013 18:25:21 -0500
In-Reply-To: <1386026512-23446-1-git-send-email-afenkart@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, Balaji T K <balajitk@ti.com>, zonque@gmail.com, galak@codeaurora.org, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Andreas Fenkart <afenkart@gmail.com>

Add SDIO IRQ entries to debugfs entry. Note that PSTATE shows current
state of data lines, incl. SDIO IRQ pending

Signed-off-by: Andreas Fenkart <afenkart@gmail.com>
---
 drivers/mmc/host/omap_hsmmc.c |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 2c14171..5fe3f24 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -82,6 +82,7 @@ static void apply_clk_hack(struct device *dev)
 #define OMAP_HSMMC_RSP54	0x0118
 #define OMAP_HSMMC_RSP76	0x011C
 #define OMAP_HSMMC_DATA		0x0120
+#define OMAP_HSMMC_PSTATE	0x0124
 #define OMAP_HSMMC_HCTL		0x0128
 #define OMAP_HSMMC_SYSCTL	0x012C
 #define OMAP_HSMMC_STAT		0x0130
@@ -1789,14 +1790,25 @@ static int omap_hsmmc_regs_show(struct seq_file *s, void *data)
 {
 	struct mmc_host *mmc = s->private;
 	struct omap_hsmmc_host *host = mmc_priv(mmc);
+	bool suspended;
+
+	seq_puts(s, "\n");
+	seq_printf(s, "sdio irq\t%s\n", ((host->flags & HSMMC_SDIO_IRQ_ENABLED)
+					 ? "enabled" : "disabled"));
+	suspended = host->dev->power.runtime_status != RPM_ACTIVE;
+	if (host->flags & HSMMC_SWAKEUP_QUIRK)
+		seq_printf(s, "pinmux config\t%s\n", (suspended ?
+						      "gpio" : "sdio"));
 
 	seq_printf(s, "mmc%d:\n ctx_loss:\t%d\n\nregs:\n",
 			mmc->index, host->context_loss);
 
 	pm_runtime_get_sync(host->dev);
-
+	seq_puts(s, "\nregs:\n");
 	seq_printf(s, "CON:\t\t0x%08x\n",
 			OMAP_HSMMC_READ(host->base, CON));
+	seq_printf(s, "PSTATE:\t\t0x%08x\n",
+		   OMAP_HSMMC_READ(host->base, PSTATE));
 	seq_printf(s, "HCTL:\t\t0x%08x\n",
 			OMAP_HSMMC_READ(host->base, HCTL));
 	seq_printf(s, "SYSCTL:\t\t0x%08x\n",
-- 
1.7.10.4

