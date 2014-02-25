From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH v7 4/4] mmc: omap_hsmmc: Extend debugfs for SDIO IRQ, GPIO and pinmux.
Date: Tue, 25 Feb 2014 13:49:38 +0100
Message-ID: <1393332578-28599-1-git-send-email-afenkart@gmail.com>
References: <1393331866-28307-4-git-send-email-afenkart@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1393331866-28307-4-git-send-email-afenkart@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, Balaji T K <balajitk@ti.com>, zonque@gmail.com, galak@codeaurora.org, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Andreas Fenkart <afenkart@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Add SDIO IRQ entries to debugfs entry. Note that PSTATE shows current
state of data lines, incl. SDIO IRQ pending

Signed-off-by: Andreas Fenkart <afenkart@gmail.com>

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 452c05a..cf03481 100644
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
@@ -1792,14 +1793,30 @@ static int omap_hsmmc_regs_show(struct seq_file *s, void *data)
 {
 	struct mmc_host *mmc = s->private;
 	struct omap_hsmmc_host *host = mmc_priv(mmc);
+	const char* cirq_state;
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
1.7.10.4

