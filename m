From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH v13 1/7] mmc: omap_hsmmc: install dummy pm runtime hooks if !CONFIG_PM_RUNTIME
Date: Fri, 23 May 2014 10:30:28 +0200
Message-ID: <1400833834-15893-2-git-send-email-afenkart@gmail.com>
References: <1400833834-15893-1-git-send-email-afenkart@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1400833834-15893-1-git-send-email-afenkart@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Chris Ball <chris@printf.net>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, Balaji T K <balajitk@ti.com>, Andreas Mueller <schnitzeltony@googlemail.com>, Sebastian Reichel <sre@kernel.org>, zonque@gmail.com, galak@codeaurora.org, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Andreas Fenkart <afenkart@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Andreas Fenkart <afenkart@gmail.com>

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 272e0ee..c62d9dd 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -199,7 +199,9 @@ struct omap_hsmmc_host {
 	struct dma_chan		*rx_chan;
 	int			slot_id;
 	int			response_busy;
+#ifdef CONFIG_PM
 	int			context_loss;
+#endif
 	int			protect_card;
 	int			reqs_blocked;
 	int			use_reg;
@@ -712,14 +714,8 @@ static void omap_hsmmc_context_save(struct omap_hsmmc_host *host)
 
 #else
 
-static int omap_hsmmc_context_restore(struct omap_hsmmc_host *host)
-{
-	return 0;
-}
-
-static void omap_hsmmc_context_save(struct omap_hsmmc_host *host)
-{
-}
+#define omap_hsmmc_context_restore(host)
+#define omap_hsmmc_context_save(host)
 
 #endif
 
@@ -1700,11 +1696,14 @@ static int omap_hsmmc_regs_show(struct seq_file *s, void *data)
 	struct mmc_host *mmc = s->private;
 	struct omap_hsmmc_host *host = mmc_priv(mmc);
 
-	seq_printf(s, "mmc%d:\n ctx_loss:\t%d\n\nregs:\n",
-			mmc->index, host->context_loss);
+	seq_printf(s, "mmc%d:\n", mmc->index);
 
-	pm_runtime_get_sync(host->dev);
+#ifdef CONFIG_PM
+	seq_printf(s, "ctx_loss:\t%d\n", host->context_loss);
+#endif
 
+	pm_runtime_get_sync(host->dev);
+	seq_puts(s, "\nregs:\n");
 	seq_printf(s, "CON:\t\t0x%08x\n",
 			OMAP_HSMMC_READ(host->base, CON));
 	seq_printf(s, "HCTL:\t\t0x%08x\n",
@@ -2243,6 +2242,7 @@ static int omap_hsmmc_resume(struct device *dev)
 #define omap_hsmmc_resume	NULL
 #endif
 
+#ifdef CONFIG_PM_RUNTIME
 static int omap_hsmmc_runtime_suspend(struct device *dev)
 {
 	struct omap_hsmmc_host *host;
@@ -2264,6 +2264,10 @@ static int omap_hsmmc_runtime_resume(struct device *dev)
 
 	return 0;
 }
+#else
+#define omap_hsmmc_runtime_suspend	NULL
+#define omap_hsmmc_runtime_resume	NULL
+#endif
 
 static struct dev_pm_ops omap_hsmmc_dev_pm_ops = {
 	.suspend	= omap_hsmmc_suspend,
-- 
1.7.10.4

