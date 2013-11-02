From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH 3/3] mmc: omap_hsmmc: Extend debugfs for SDIO IRQ, GPIO and pinmux.
Date: Sat,  2 Nov 2013 21:26:16 +0100
Message-ID: <1383423976-24798-3-git-send-email-afenkart@gmail.com>
References: <1383423976-24798-1-git-send-email-afenkart@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:58644 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754328Ab3KBU2n (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 2 Nov 2013 16:28:43 -0400
In-Reply-To: <1383423976-24798-1-git-send-email-afenkart@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, Balaji T K <balajitk@ti.com>, zonque@gmail.com, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Andreas Fenkart <andreas.fenkart@dev.digitalstrom.org>, Andreas Fenkart <afenkart@gmail.com>

From: Andreas Fenkart <andreas.fenkart@dev.digitalstrom.org>

Add SDIO IRQ entries to debugfs entry. Note that PSTATE shows current
state of data lines, incl. SDIO IRQ pending

Signed-off-by: Andreas Fenkart <afenkart@gmail.com>
---
 drivers/mmc/host/omap_hsmmc.c |   22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index e880b44..19c0aa5 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -81,6 +81,7 @@ static void apply_clk_hack(struct device *dev)
 #define OMAP_HSMMC_RSP54	0x0118
 #define OMAP_HSMMC_RSP76	0x011C
 #define OMAP_HSMMC_DATA		0x0120
+#define OMAP_HSMMC_PSTATE	0x0124
 #define OMAP_HSMMC_HCTL		0x0128
 #define OMAP_HSMMC_SYSCTL	0x012C
 #define OMAP_HSMMC_STAT		0x0130
@@ -1800,6 +1801,23 @@ static int omap_hsmmc_regs_show(struct seq_file *s, void *data)
 {
 	struct mmc_host *mmc = s->private;
 	struct omap_hsmmc_host *host = mmc_priv(mmc);
+	unsigned long flags;
+	bool suspended;
+
+	spin_lock_irqsave(&host->irq_lock, flags);
+	seq_printf(s, "\n");
+	seq_printf(s, "sdio irq\t%s\n", ((host->flags & HSMMC_SDIO_IRQ_ENABLED)
+					 ? "enabled" : "disabled"));
+	suspended = host->dev->power.runtime_status != RPM_ACTIVE;
+	if (host->flags & HSMMC_SWAKEUP_QUIRK) {
+		seq_printf(s, "pinmux config\t%s\n", (suspended ?
+						      "gpio" : "sdio"));
+		if (suspended)
+			seq_printf(s, "sdio irq pin\t%s\n",
+				   gpio_get_value(mmc_slot(host).gpio_cirq) ?
+				   "high" : "low");
+	}
+	spin_unlock_irqrestore(&host->irq_lock, flags);
 
 	if (host->suspended) {
 		seq_printf(s, "host suspended, can't read registers\n");
@@ -1807,9 +1825,11 @@ static int omap_hsmmc_regs_show(struct seq_file *s, void *data)
 	}
 
 	pm_runtime_get_sync(host->dev);
-
+	seq_printf(s, "\nregs:\n");
 	seq_printf(s, "CON:\t\t0x%08x\n",
 			OMAP_HSMMC_READ(host->base, CON));
+	seq_printf(s, "PSTATE:\t\t0x%08x\n",
+		   OMAP_HSMMC_READ(host->base, PSTATE));
 	seq_printf(s, "HCTL:\t\t0x%08x\n",
 			OMAP_HSMMC_READ(host->base, HCTL));
 	seq_printf(s, "SYSCTL:\t\t0x%08x\n",
-- 
1.7.10.4

