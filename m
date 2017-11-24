From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2 13/22] mmc: tmio,renesas_sdhi: move Renesas-specific DMA data to renesas_sdhi.h
Date: Sat, 25 Nov 2017 01:24:48 +0900
Message-ID: <1511540697-27387-14-git-send-email-yamada.masahiro@socionext.com>
References: <1511540697-27387-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from conuserg-11.nifty.com ([210.131.2.78]:61686 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753802AbdKXQ0J (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Nov 2017 11:26:09 -0500
In-Reply-To: <1511540697-27387-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

struct tmio_mmc_host has "dma_dataend" and "dma_complete", but in fact,
they are Renesas private data.  Move them to renesas_sdhi.h

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - Newly added

 drivers/mmc/host/renesas_sdhi.h               |  2 ++
 drivers/mmc/host/renesas_sdhi_internal_dmac.c |  8 ++++++--
 drivers/mmc/host/renesas_sdhi_sys_dmac.c      | 15 ++++++++++-----
 drivers/mmc/host/tmio_mmc.h                   |  2 --
 4 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
index 9a507b3..3250dbe 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -39,6 +39,8 @@ struct tmio_mmc_dma {
 	enum dma_slave_buswidth dma_buswidth;
 	bool (*filter)(struct dma_chan *chan, void *arg);
 	void (*enable)(struct tmio_mmc_host *host, bool enable);
+	struct completion	dma_dataend;
+	struct tasklet_struct	dma_complete;
 };
 
 struct renesas_sdhi {
diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 691a99f..02c2724 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -132,7 +132,9 @@ renesas_sdhi_internal_dmac_abort_dma(struct tmio_mmc_host *host) {
 
 static void
 renesas_sdhi_internal_dmac_dataend_dma(struct tmio_mmc_host *host) {
-	tasklet_schedule(&host->dma_complete);
+	struct renesas_sdhi *priv = host_to_priv(host);
+
+	tasklet_schedule(&priv->dma_priv.dma_complete);
 }
 
 static void
@@ -222,10 +224,12 @@ static void
 renesas_sdhi_internal_dmac_request_dma(struct tmio_mmc_host *host,
 				       struct tmio_mmc_data *pdata)
 {
+	struct renesas_sdhi *priv = host_to_priv(host);
+
 	/* Each value is set to non-zero to assume "enabling" each DMA */
 	host->chan_rx = host->chan_tx = (void *)0xdeadbeaf;
 
-	tasklet_init(&host->dma_complete,
+	tasklet_init(&priv->dma_priv.dma_complete,
 		     renesas_sdhi_internal_dmac_complete_tasklet_fn,
 		     (unsigned long)host);
 	tasklet_init(&host->dma_issue,
diff --git a/drivers/mmc/host/renesas_sdhi_sys_dmac.c b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
index aeb3838..c8a74b2 100644
--- a/drivers/mmc/host/renesas_sdhi_sys_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
@@ -140,12 +140,15 @@ static void renesas_sdhi_sys_dmac_abort_dma(struct tmio_mmc_host *host)
 
 static void renesas_sdhi_sys_dmac_dataend_dma(struct tmio_mmc_host *host)
 {
-	complete(&host->dma_dataend);
+	struct renesas_sdhi *priv = host_to_priv(host);
+
+	complete(&priv->dma_priv.dma_dataend);
 }
 
 static void renesas_sdhi_sys_dmac_dma_callback(void *arg)
 {
 	struct tmio_mmc_host *host = arg;
+	struct renesas_sdhi *priv = host_to_priv(host);
 
 	spin_lock_irq(&host->lock);
 
@@ -163,7 +166,7 @@ static void renesas_sdhi_sys_dmac_dma_callback(void *arg)
 
 	spin_unlock_irq(&host->lock);
 
-	wait_for_completion(&host->dma_dataend);
+	wait_for_completion(&priv->dma_priv.dma_dataend);
 
 	spin_lock_irq(&host->lock);
 	tmio_mmc_do_data_irq(host);
@@ -173,6 +176,7 @@ static void renesas_sdhi_sys_dmac_dma_callback(void *arg)
 
 static void renesas_sdhi_sys_dmac_start_dma_rx(struct tmio_mmc_host *host)
 {
+	struct renesas_sdhi *priv = host_to_priv(host);
 	struct scatterlist *sg = host->sg_ptr, *sg_tmp;
 	struct dma_async_tx_descriptor *desc = NULL;
 	struct dma_chan *chan = host->chan_rx;
@@ -216,7 +220,7 @@ static void renesas_sdhi_sys_dmac_start_dma_rx(struct tmio_mmc_host *host)
 					       DMA_CTRL_ACK);
 
 	if (desc) {
-		reinit_completion(&host->dma_dataend);
+		reinit_completion(&priv->dma_priv.dma_dataend);
 		desc->callback = renesas_sdhi_sys_dmac_dma_callback;
 		desc->callback_param = host;
 
@@ -247,6 +251,7 @@ static void renesas_sdhi_sys_dmac_start_dma_rx(struct tmio_mmc_host *host)
 
 static void renesas_sdhi_sys_dmac_start_dma_tx(struct tmio_mmc_host *host)
 {
+	struct renesas_sdhi *priv = host_to_priv(host);
 	struct scatterlist *sg = host->sg_ptr, *sg_tmp;
 	struct dma_async_tx_descriptor *desc = NULL;
 	struct dma_chan *chan = host->chan_tx;
@@ -295,7 +300,7 @@ static void renesas_sdhi_sys_dmac_start_dma_tx(struct tmio_mmc_host *host)
 					       DMA_CTRL_ACK);
 
 	if (desc) {
-		reinit_completion(&host->dma_dataend);
+		reinit_completion(&priv->dma_priv.dma_dataend);
 		desc->callback = renesas_sdhi_sys_dmac_dma_callback;
 		desc->callback_param = host;
 
@@ -424,7 +429,7 @@ static void renesas_sdhi_sys_dmac_request_dma(struct tmio_mmc_host *host,
 		if (!host->bounce_buf)
 			goto ebouncebuf;
 
-		init_completion(&host->dma_dataend);
+		init_completion(&priv->dma_priv.dma_dataend);
 		tasklet_init(&host->dma_issue,
 			     renesas_sdhi_sys_dmac_issue_tasklet_fn,
 			     (unsigned long)host);
diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index dc470d3..8b169a0 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -148,8 +148,6 @@ struct tmio_mmc_host {
 	bool			force_pio;
 	struct dma_chan		*chan_rx;
 	struct dma_chan		*chan_tx;
-	struct completion	dma_dataend;
-	struct tasklet_struct	dma_complete;
 	struct tasklet_struct	dma_issue;
 	struct scatterlist	bounce_sg;
 	u8			*bounce_buf;
-- 
2.7.4

