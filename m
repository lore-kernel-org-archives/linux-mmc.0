From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH v13 3/7] mmc: omap_hsmmc: Extend debugfs by SDIO IRQ handling, runtime state
Date: Fri, 23 May 2014 10:30:30 +0200
Message-ID: <1400833834-15893-4-git-send-email-afenkart@gmail.com>
References: <1400833834-15893-1-git-send-email-afenkart@gmail.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1400833834-15893-1-git-send-email-afenkart@gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Chris Ball <chris@printf.net>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, Balaji T K <balajitk@ti.com>, Andreas Mueller <schnitzeltony@googlemail.com>, Sebastian Reichel <sre@kernel.org>, zonque@gmail.com, galak@codeaurora.org, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Andreas Fenkart <afenkart@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Add SDIO IRQ entries to debugfs entry. Note that PSTATE shows current
state of data lines, incl. SDIO IRQ pending

Acked-by: Balaji T K <balajitk@ti.com>
Signed-off-by: Andreas Fenkart <afenkart@gmail.com>

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 0125eea..cfd2bfb 100644
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
@@ -1816,10 +1817,23 @@ static int omap_hsmmc_regs_show(struct seq_file *s, void *data)
 {
 	struct mmc_host *mmc = s->private;
 	struct omap_hsmmc_host *host = mmc_priv(mmc);
+#ifdef CONFIG_PM
+	bool suspended;
+#endif
 
 	seq_printf(s, "mmc%d:\n", mmc->index);
+	seq_printf(s, "sdio irq mode\t%s\n",
+		   (mmc->caps & MMC_CAP_SDIO_IRQ) ? "interrupt" : "polling");
+
+	if (mmc->caps & MMC_CAP_SDIO_IRQ) {
+		seq_printf(s, "sdio irq \t%s\n",
+			   (host->flags & HSMMC_SDIO_IRQ_ENABLED) ?  "enabled"
+			   : "disabled");
+	}
 
 #ifdef CONFIG_PM
+	suspended = host->dev->power.runtime_status != RPM_ACTIVE;
+	seq_printf(s, "runtime state\t%s\n", (suspended ? "idle" : "active"));
 	seq_printf(s, "ctx_loss:\t%d\n", host->context_loss);
 #endif
 
@@ -1827,6 +1841,8 @@ static int omap_hsmmc_regs_show(struct seq_file *s, void *data)
 	seq_puts(s, "\nregs:\n");
 	seq_printf(s, "CON:\t\t0x%08x\n",
 			OMAP_HSMMC_READ(host->base, CON));
+	seq_printf(s, "PSTATE:\t\t0x%08x\n",
+		   OMAP_HSMMC_READ(host->base, PSTATE));
 	seq_printf(s, "HCTL:\t\t0x%08x\n",
 			OMAP_HSMMC_READ(host->base, HCTL));
 	seq_printf(s, "SYSCTL:\t\t0x%08x\n",
-- 
1.7.10.4

