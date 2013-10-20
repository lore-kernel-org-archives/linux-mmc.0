From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 2/5] mmc: omap_hsmmc: context save and restore for DT
Date: Mon, 21 Oct 2013 00:25:19 +0530
Message-ID: <1382295322-18995-2-git-send-email-balajitk@ti.com>
References: <1382295322-18995-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55458 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573Ab3JTSzg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 20 Oct 2013 14:55:36 -0400
In-Reply-To: <1382295322-18995-1-git-send-email-balajitk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org, tony@atomide.com
Cc: linux-omap@vger.kernel.org, Andreas Fenkart <afenkart@gmail.com>, Balaji T K <balajitk@ti.com>

From: Tony Lindgren <tony@atomide.com>

We want to get rid of the omap specific platform init code
callbacks as they don't play nice with device tree.

Convert the context loss check to be based on a
register state detection instead.

Cc: Andreas Fenkart <afenkart@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Balaji T K <balajitk@ti.com>
[add check for CON and HCTL in context save and restore function]
---
 drivers/mmc/host/omap_hsmmc.c |   52 +++++++++++++++-------------------------
 1 files changed, 20 insertions(+), 32 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 84a1140..9ebff99 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -171,6 +171,10 @@ struct omap_hsmmc_host {
 	unsigned char		bus_mode;
 	unsigned char		power_mode;
 	int			suspended;
+	u32			con;
+	u32			hctl;
+	u32			sysctl;
+	u32			capa;
 	int			irq;
 	int			use_dma, dma_ch;
 	struct dma_chan		*tx_chan;
@@ -183,7 +187,6 @@ struct omap_hsmmc_host {
 	int			use_reg;
 	int			req_in_progress;
 	struct omap_hsmmc_next	next_data;
-
 	struct	omap_mmc_platform_data	*pdata;
 };
 
@@ -597,25 +600,20 @@ static void omap_hsmmc_set_bus_mode(struct omap_hsmmc_host *host)
 static int omap_hsmmc_context_restore(struct omap_hsmmc_host *host)
 {
 	struct mmc_ios *ios = &host->mmc->ios;
-	struct omap_mmc_platform_data *pdata = host->pdata;
-	int context_loss = 0;
 	u32 hctl, capa;
 	unsigned long timeout;
 
-	if (pdata->get_context_loss_count) {
-		context_loss = pdata->get_context_loss_count(host->dev);
-		if (context_loss < 0)
-			return 1;
-	}
-
-	dev_dbg(mmc_dev(host->mmc), "context was %slost\n",
-		context_loss == host->context_loss ? "not " : "");
-	if (host->context_loss == context_loss)
-		return 1;
-
 	if (!OMAP_HSMMC_READ(host->base, SYSSTATUS) & RESETDONE)
 		return 1;
 
+	if (host->con == OMAP_HSMMC_READ(host->base, CON) &&
+	    host->hctl == OMAP_HSMMC_READ(host->base, HCTL) &&
+	    host->sysctl == OMAP_HSMMC_READ(host->base, SYSCTL) &&
+	    host->capa == OMAP_HSMMC_READ(host->base, CAPA))
+		return 0;
+
+	host->context_loss++;
+
 	if (host->pdata->controller_flags & OMAP_HSMMC_SUPPORTS_DUAL_VOLT) {
 		if (host->power_mode != MMC_POWER_OFF &&
 		    (1 << ios->vdd) <= MMC_VDD_23_24)
@@ -655,9 +653,8 @@ static int omap_hsmmc_context_restore(struct omap_hsmmc_host *host)
 	omap_hsmmc_set_bus_mode(host);
 
 out:
-	host->context_loss = context_loss;
-
-	dev_dbg(mmc_dev(host->mmc), "context is restored\n");
+	dev_dbg(mmc_dev(host->mmc), "context is restored: restore count %d\n",
+		host->context_loss);
 	return 0;
 }
 
@@ -666,15 +663,10 @@ out:
  */
 static void omap_hsmmc_context_save(struct omap_hsmmc_host *host)
 {
-	struct omap_mmc_platform_data *pdata = host->pdata;
-	int context_loss;
-
-	if (pdata->get_context_loss_count) {
-		context_loss = pdata->get_context_loss_count(host->dev);
-		if (context_loss < 0)
-			return;
-		host->context_loss = context_loss;
-	}
+	host->con =  OMAP_HSMMC_READ(host->base, CON);
+	host->hctl = OMAP_HSMMC_READ(host->base, HCTL);
+	host->sysctl =  OMAP_HSMMC_READ(host->base, SYSCTL);
+	host->capa = OMAP_HSMMC_READ(host->base, CAPA);
 }
 
 #else
@@ -1635,13 +1627,9 @@ static int omap_hsmmc_regs_show(struct seq_file *s, void *data)
 {
 	struct mmc_host *mmc = s->private;
 	struct omap_hsmmc_host *host = mmc_priv(mmc);
-	int context_loss = 0;
-
-	if (host->pdata->get_context_loss_count)
-		context_loss = host->pdata->get_context_loss_count(host->dev);
 
-	seq_printf(s, "mmc%d:\n ctx_loss:\t%d:%d\n\nregs:\n",
-			mmc->index, host->context_loss, context_loss);
+	seq_printf(s, "mmc%d:\n ctx_loss:\t%d\n\nregs:\n",
+			mmc->index, host->context_loss);
 
 	if (host->suspended) {
 		seq_printf(s, "host suspended, can't read registers\n");
-- 
1.7.5.4

