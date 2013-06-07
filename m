From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/4] mmc: omap_hsmmc: debugfs entries for GPIO and SDIO mode
Date: Fri, 07 Jun 2013 14:50:00 -0700
Message-ID: <20130607215000.18581.97811.stgit@localhost>
References: <20130607214557.18581.75288.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:51274 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757093Ab3FGVuD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 7 Jun 2013 17:50:03 -0400
In-Reply-To: <20130607214557.18581.75288.stgit@localhost>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: Balaji T K <balajitk@ti.com>, Andreas Fenkart <andreas.fenkart@streamunlimited.com>, Andreas Fenkart <afenkart@gmail.com>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

From: Andreas Fenkart <andreas.fenkart@streamunlimited.com>

Update the debugfs related code for the SDIO support.
Note that PSTATE shows current state of data lines.

Cc: Andreas Fenkart <afenkart@gmail.com>
Cc: Balaji T K <balajitk@ti.com>
Signed-off-by: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
[tony@atomide.com: combined both sysfs patches into one]
---
 drivers/mmc/host/omap_hsmmc.c |   26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 8ca08fb..d0d3df0 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -53,6 +53,7 @@
 #define OMAP_HSMMC_RSP54	0x0118
 #define OMAP_HSMMC_RSP76	0x011C
 #define OMAP_HSMMC_DATA		0x0120
+#define OMAP_HSMMC_PSTATE	0x0124
 #define OMAP_HSMMC_HCTL		0x0128
 #define OMAP_HSMMC_SYSCTL	0x012C
 #define OMAP_HSMMC_STAT		0x0130
@@ -188,6 +189,7 @@ struct omap_hsmmc_host {
 	struct pinctrl		*pinctrl;
 	struct pinctrl_state	*fixed, *active, *idle;
 	bool			active_pinmux;
+	int			pm_suspend_ct;
 	struct	omap_mmc_platform_data	*pdata;
 };
 
@@ -1781,6 +1783,23 @@ static int omap_hsmmc_regs_show(struct seq_file *s, void *data)
 {
 	struct mmc_host *mmc = s->private;
 	struct omap_hsmmc_host *host = mmc_priv(mmc);
+	unsigned long flags;
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
@@ -1788,9 +1807,11 @@ static int omap_hsmmc_regs_show(struct seq_file *s, void *data)
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
@@ -1970,6 +1991,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	host->slot_id	= 0;
 	host->sdio_irq_en = false;
 	host->active_pinmux = true;
+	host->pm_suspend_ct = 0;
 	host->mapbase	= res->start + pdata->reg_offset;
 	host->base	= ioremap(host->mapbase, SZ_4K);
 	host->power_mode = MMC_POWER_OFF;
@@ -2378,6 +2400,8 @@ static int omap_hsmmc_runtime_suspend(struct device *dev)
 	if (mmc->caps & MMC_CAP_SDIO_IRQ) {
 		spin_lock_irqsave(&host->irq_lock, flags);
 		host->active_pinmux = false;
+		host->pm_suspend_ct++;
+
 		OMAP_HSMMC_WRITE(host->base, ISE, 0);
 		OMAP_HSMMC_WRITE(host->base, IE, 0);
 		OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);

