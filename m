From: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
Subject: [RESEND PATCH v2 2/3] mmc: omap_hsmmc: debugfs entries for GPIO mode.
Date: Wed, 15 May 2013 10:45:15 +0200
Message-ID: <1368607516-2789-3-git-send-email-andreas.fenkart@streamunlimited.com>
References: <1368607516-2789-1-git-send-email-andreas.fenkart@streamunlimited.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.22]:62046 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757053Ab3EOIpr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 15 May 2013 04:45:47 -0400
Received: from mailout-de.gmx.net ([10.1.76.33]) by mrigmx.server.lan
 (mrigmx001) with ESMTP (Nemesis) id 0La16h-1UFKX12ejt-00llkJ for
 <linux-mmc@vger.kernel.org>; Wed, 15 May 2013 10:45:46 +0200
In-Reply-To: <1368607516-2789-1-git-send-email-andreas.fenkart@streamunlimited.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: tony@atomide.com
Cc: cjb@laptop.org, arnd@arndb.de, svenkatr@ti.com, balajitk@ti.com, grant.likely@secretlab.ca, linux-mmc@vger.kernel.org, rob@landley.net, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, zonque@gmail.com, Andreas Fenkart <andreas.fenkart@streamunlimited.com>

Signed-off-by: Andreas Fenkart <andreas.fenkart@streamunlimited.com>

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 4db8de5..2b2ec09 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -224,6 +224,7 @@ struct omap_hsmmc_host {
 	struct pinctrl		*pinctrl;
 	struct pinctrl_state	*active, *idle;
 	bool			active_pinmux;
+	int			pm_suspend_ct;
 
 	struct	omap_mmc_platform_data	*pdata;
 };
@@ -1775,12 +1776,29 @@ static int omap_hsmmc_regs_show(struct seq_file *s, void *data)
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
@@ -1788,7 +1806,7 @@ static int omap_hsmmc_regs_show(struct seq_file *s, void *data)
 	}
 
 	pm_runtime_get_sync(host->dev);
-
+	seq_printf(s, "\nregs:\n");
 	seq_printf(s, "CON:\t\t0x%08x\n",
 			OMAP_HSMMC_READ(host->base, CON));
 	seq_printf(s, "HCTL:\t\t0x%08x\n",
@@ -1963,6 +1981,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	host->slot_id	= 0;
 	host->sdio_irq_en = false;
 	host->active_pinmux = true;
+	host->pm_suspend_ct = 0;
 	host->mapbase	= res->start + pdata->reg_offset;
 	host->base	= ioremap(host->mapbase, SZ_4K);
 	host->power_mode = MMC_POWER_OFF;
@@ -2401,6 +2420,8 @@ static int omap_hsmmc_runtime_suspend(struct device *dev)
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

