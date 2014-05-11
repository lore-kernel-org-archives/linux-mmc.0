From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH v11 3/6] mmc: omap_hsmmc: Extend debugfs by SDIO IRQ handling, runtime state
Date: Sun, 11 May 2014 13:28:55 +0200
Message-ID: <1399807738-32223-4-git-send-email-afenkart@gmail.com>
References: <1399807738-32223-1-git-send-email-afenkart@gmail.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1399807738-32223-1-git-send-email-afenkart@gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Chris Ball <chris@printf.net>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, Balaji T K <balajitk@ti.com>, Andreas Mueller <schnitzeltony@googlemail.com>, Sebastian Reichel <sre@kernel.org>, zonque@gmail.com, galak@codeaurora.org, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Andreas Fenkart <afenkart@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Add SDIO IRQ entries to debugfs entry. Note that PSTATE shows current
state of data lines, incl. SDIO IRQ pending

Acked-by: Balaji T K <balajitk@ti.com>
Signed-off-by: Andreas Fenkart <afenkart@gmail.com>

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 4ee4645..1a9d31f 100644
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
@@ -1825,14 +1826,29 @@ static int omap_hsmmc_regs_show(struct seq_file *s, void *data)
 {
 	struct mmc_host *mmc = s->private;
 	struct omap_hsmmc_host *host = mmc_priv(mmc);
+	bool suspended;
 
-	seq_printf(s, "mmc%d:\n ctx_loss:\t%d\n\nregs:\n",
-			mmc->index, host->context_loss);
+	seq_printf(s, "mmc%d:\n", mmc->index);
+	seq_printf(s, "sdio irq mode\t%s\n",
+		   (mmc->caps & MMC_CAP_SDIO_IRQ) ? "interrupt" : "polling");
 
-	pm_runtime_get_sync(host->dev);
+	if (mmc->caps & MMC_CAP_SDIO_IRQ) {
+		seq_printf(s, "sdio irq \t%s\n",
+			   (host->flags & HSMMC_SDIO_IRQ_ENABLED) ?  "enabled"
+			   : "disabled");
+	}
+
+	suspended = host->dev->power.runtime_status != RPM_ACTIVE;
+	seq_printf(s, "runtime state\t%s\n", (suspended ?  "idle" : "active"));
 
+	seq_printf(s, "ctx_loss:\t%d\n", host->context_loss);
+
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
1.7.10.4

