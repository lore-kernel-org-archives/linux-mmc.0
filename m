From: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
Subject: [PATCH v2 2/3] mmc: omap_hsmmc: debugfs entries for GPIO mode.
Date: Fri, 12 Apr 2013 14:38:26 +0200
Message-ID: <1365770307-19859-3-git-send-email-andreas.fenkart@streamunlimited.com>
References: <1365770307-19859-1-git-send-email-andreas.fenkart@streamunlimited.com>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1365770307-19859-1-git-send-email-andreas.fenkart@streamunlimited.com>
Sender: linux-omap-owner@vger.kernel.org
To: tony@atomide.com
Cc: cjb@laptop.org, arnd@arndb.de, svenkatr@ti.com, balajitk@ti.com, grant.likely@secretlab.ca, linux-mmc@vger.kernel.org, rob@landley.net, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, zonque@gmail.com, Andreas Fenkart <andreas.fenkart@streamunlimited.com>
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Andreas Fenkart <andreas.fenkart@streamunlimited.com>

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index c52a0d1..0f9eb54 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -212,6 +212,7 @@ struct omap_hsmmc_host {
 	struct pinctrl		*pinctrl;
 	struct pinctrl_state	*active, *idle;
 	bool			active_pinmux;
+	int			pm_suspend_ct;
 
 	struct	omap_mmc_platform_data	*pdata;
 };
@@ -1763,12 +1764,29 @@ static int omap_hsmmc_regs_show(struct seq_file *s, void *data)
 	struct mmc_host *mmc = s->private;
 	struct omap_hsmmc_host *host = mmc_priv(mmc);
 	int context_loss = 0;
+	unsigned long flags;
 
 	if (host->pdata->get_context_loss_count)
 		context_loss = host->pdata->get_context_loss_count(host->dev);
 
-	seq_printf(s, "mmc%d:\n ctx_loss:\t%d:%d\n\nregs:\n",
-			mmc->index, host->context_loss, context_loss);
+	seq_printf(s, "mmc%d:\n ctx_loss:\t%d:%d\n",
+		   mmc->index, host->context_loss, context_loss);
+
+	if (mmc_slot(host).sdio_irq) {
+		spin_lock_irqsave(&host->irq_lock, flags);
+		seq_printf(s, "\n");
+		seq_printf(s, "pinmux config\t%s\n", host->active_pinmux ?
+			   "sdio" : "gpio");
+		seq_printf(s, "sdio irq\t%s\n", host->sdio_irq_en ? "enabled" :
+			   "disabled");
+		if (!host->active_pinmux) {
+			seq_printf(s, "sdio irq pin\t%s\n",
+				   gpio_get_value(mmc_slot(host).gpio_cirq) ?
+				   "high" : "low");
+		}
+		seq_printf(s, "pm suspends\t%d\n", host->pm_suspend_ct);
+		spin_unlock_irqrestore(&host->irq_lock, flags);
+	}
 
 	if (host->suspended) {
 		seq_printf(s, "host suspended, can't read registers\n");
@@ -1776,7 +1794,7 @@ static int omap_hsmmc_regs_show(struct seq_file *s, void *data)
 	}
 
 	pm_runtime_get_sync(host->dev);
-
+	seq_printf(s, "\nregs:\n");
 	seq_printf(s, "CON:\t\t0x%08x\n",
 			OMAP_HSMMC_READ(host->base, CON));
 	seq_printf(s, "HCTL:\t\t0x%08x\n",
@@ -1951,6 +1969,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	host->slot_id	= 0;
 	host->sdio_irq_en = false;
 	host->active_pinmux = true;
+	host->pm_suspend_ct = 0;
 	host->mapbase	= res->start + pdata->reg_offset;
 	host->base	= ioremap(host->mapbase, SZ_4K);
 	host->power_mode = MMC_POWER_OFF;
@@ -2389,6 +2408,8 @@ static int omap_hsmmc_runtime_suspend(struct device *dev)
 	if (mmc_slot(host).sdio_irq && host->pinctrl) {
 		spin_lock_irqsave(&host->irq_lock, flags);
 		host->active_pinmux = false;
+		host->pm_suspend_ct++;
+
 		OMAP_HSMMC_WRITE(host->base, ISE, 0);
 		OMAP_HSMMC_WRITE(host->base, IE, 0);
 		OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
-- 
1.7.10.4

