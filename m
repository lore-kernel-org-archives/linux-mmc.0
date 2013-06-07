From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/4] mmc: omap_hsmmc: Fix context save and restore for DT
Date: Fri, 07 Jun 2013 14:49:50 -0700
Message-ID: <20130607214950.18581.56829.stgit@localhost>
References: <20130607214557.18581.75288.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20130607214557.18581.75288.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
To: cjb@laptop.org
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, Balaji T K <balajitk@ti.com>, linux-arm-kernel@lists.infradead.org, Andreas Fenkart <afenkart@gmail.com>
List-Id: linux-mmc@vger.kernel.org

We want to get rid of the omap specific platform init code
callbacks as they don't play nice with device tree.

Let's convert the context loss check to be based on a
register state detection instead.

Cc: Andreas Fenkart <afenkart@gmail.com>
Cc: Balaji T K <balajitk@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/mmc/host/omap_hsmmc.c |   41 ++++++++---------------------------------
 1 file changed, 8 insertions(+), 33 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 6e44025..478849b 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -169,19 +169,19 @@ struct omap_hsmmc_host {
 	unsigned char		bus_mode;
 	unsigned char		power_mode;
 	int			suspended;
+	u32			hctl;
+	u32			capa;
 	int			irq;
 	int			use_dma, dma_ch;
 	struct dma_chan		*tx_chan;
 	struct dma_chan		*rx_chan;
 	int			slot_id;
 	int			response_busy;
-	int			context_loss;
 	int			protect_card;
 	int			reqs_blocked;
 	int			use_reg;
 	int			req_in_progress;
 	struct omap_hsmmc_next	next_data;
-
 	struct	omap_mmc_platform_data	*pdata;
 };
 
@@ -595,25 +595,16 @@ static void omap_hsmmc_set_bus_mode(struct omap_hsmmc_host *host)
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
 
+	if (host->hctl == OMAP_HSMMC_READ(host->base, HCTL) &&
+	    host->capa == OMAP_HSMMC_READ(host->base, CAPA))
+		return 0;
+
 	if (host->pdata->controller_flags & OMAP_HSMMC_SUPPORTS_DUAL_VOLT) {
 		if (host->power_mode != MMC_POWER_OFF &&
 		    (1 << ios->vdd) <= MMC_VDD_23_24)
@@ -653,8 +644,6 @@ static int omap_hsmmc_context_restore(struct omap_hsmmc_host *host)
 	omap_hsmmc_set_bus_mode(host);
 
 out:
-	host->context_loss = context_loss;
-
 	dev_dbg(mmc_dev(host->mmc), "context is restored\n");
 	return 0;
 }
@@ -664,15 +653,8 @@ out:
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
+	host->hctl = OMAP_HSMMC_READ(host->base, HCTL);
+	host->capa = OMAP_HSMMC_READ(host->base, CAPA);
 }
 
 #else
@@ -1633,13 +1615,6 @@ static int omap_hsmmc_regs_show(struct seq_file *s, void *data)
 {
 	struct mmc_host *mmc = s->private;
 	struct omap_hsmmc_host *host = mmc_priv(mmc);
-	int context_loss = 0;
-
-	if (host->pdata->get_context_loss_count)
-		context_loss = host->pdata->get_context_loss_count(host->dev);
-
-	seq_printf(s, "mmc%d:\n ctx_loss:\t%d:%d\n\nregs:\n",
-			mmc->index, host->context_loss, context_loss);
 
 	if (host->suspended) {
 		seq_printf(s, "host suspended, can't read registers\n");

