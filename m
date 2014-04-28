From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH v10 3/5] mmc: omap_hsmmc: Extend debugfs by SDIO IRQ handling, runtime state
Date: Mon, 28 Apr 2014 09:40:58 +0200
Message-ID: <1398670860-30695-4-git-send-email-afenkart@gmail.com>
References: <1398670860-30695-1-git-send-email-afenkart@gmail.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1398670860-30695-1-git-send-email-afenkart@gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Chris Ball <chris@printf.net>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, Balaji T K <balajitk@ti.com>, zonque@gmail.com, galak@codeaurora.org, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Andreas Fenkart <afenkart@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Add SDIO IRQ entries to debugfs entry. Note that PSTATE shows current
state of data lines, incl. SDIO IRQ pending

Signed-off-by: Andreas Fenkart <afenkart@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index e675042..76fe3bd 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1819,14 +1819,28 @@ static int omap_hsmmc_regs_show(struct seq_file *s, void *data)
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

