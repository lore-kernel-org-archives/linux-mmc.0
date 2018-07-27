From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] mmc: tmio: allow DMA request hook to return error status
Date: Fri, 27 Jul 2018 10:14:06 +0900
Message-ID: <1532654046-11901-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>
List-Id: linux-mmc@vger.kernel.org

dma_request_chan() may return ERR_PTR(-EPROBE_DEFER), but
tmio_mmc_request_dma() cannot propagate it since it is a
void function.

Change the return type to int so that the driver can retry
probing later in case the DMA-engine driver is probed after
the TMIO MMC driver.

I moved the call for tmio_mmc_request_dma() up because it may
fail now.  I also removed unneeded clearing of host->chan_{tx,rx}
because (struct tmio_mmc_host) is allocated by kzalloc().

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mmc/host/renesas_sdhi_internal_dmac.c |  4 +++-
 drivers/mmc/host/renesas_sdhi_sys_dmac.c      | 14 ++++++++------
 drivers/mmc/host/tmio_mmc.h                   |  3 +--
 drivers/mmc/host/tmio_mmc_core.c              | 21 ++++++++++-----------
 4 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index d032bd6..f3475a5 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -230,7 +230,7 @@ static void renesas_sdhi_internal_dmac_complete_tasklet_fn(unsigned long arg)
 	spin_unlock_irq(&host->lock);
 }
 
-static void
+static int
 renesas_sdhi_internal_dmac_request_dma(struct tmio_mmc_host *host,
 				       struct tmio_mmc_data *pdata)
 {
@@ -245,6 +245,8 @@ renesas_sdhi_internal_dmac_request_dma(struct tmio_mmc_host *host,
 	tasklet_init(&host->dma_issue,
 		     renesas_sdhi_internal_dmac_issue_tasklet_fn,
 		     (unsigned long)host);
+
+	return 0;
 }
 
 static void
diff --git a/drivers/mmc/host/renesas_sdhi_sys_dmac.c b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
index 4bb46c4..3f806f5 100644
--- a/drivers/mmc/host/renesas_sdhi_sys_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
@@ -359,15 +359,15 @@ static void renesas_sdhi_sys_dmac_issue_tasklet_fn(unsigned long priv)
 		dma_async_issue_pending(chan);
 }
 
-static void renesas_sdhi_sys_dmac_request_dma(struct tmio_mmc_host *host,
-					      struct tmio_mmc_data *pdata)
+static int renesas_sdhi_sys_dmac_request_dma(struct tmio_mmc_host *host,
+					     struct tmio_mmc_data *pdata)
 {
 	struct renesas_sdhi *priv = host_to_priv(host);
 
 	/* We can only either use DMA for both Tx and Rx or not use it at all */
 	if (!host->pdev->dev.of_node &&
 	    (!pdata->chan_priv_tx || !pdata->chan_priv_rx))
-		return;
+		return 0;
 
 	if (!host->chan_tx && !host->chan_rx) {
 		struct resource *res = platform_get_resource(host->pdev,
@@ -377,7 +377,7 @@ static void renesas_sdhi_sys_dmac_request_dma(struct tmio_mmc_host *host,
 		int ret;
 
 		if (!res)
-			return;
+			return 0;
 
 		dma_cap_zero(mask);
 		dma_cap_set(DMA_SLAVE, mask);
@@ -389,7 +389,7 @@ static void renesas_sdhi_sys_dmac_request_dma(struct tmio_mmc_host *host,
 			host->chan_tx);
 
 		if (!host->chan_tx)
-			return;
+			return 0;
 
 		cfg.direction = DMA_MEM_TO_DEV;
 		cfg.dst_addr = res->start +
@@ -433,7 +433,7 @@ static void renesas_sdhi_sys_dmac_request_dma(struct tmio_mmc_host *host,
 
 	renesas_sdhi_sys_dmac_enable_dma(host, true);
 
-	return;
+	return 0;
 
 ebouncebuf:
 ecfgrx:
@@ -443,6 +443,8 @@ static void renesas_sdhi_sys_dmac_request_dma(struct tmio_mmc_host *host,
 ecfgtx:
 	dma_release_channel(host->chan_tx);
 	host->chan_tx = NULL;
+
+	return 0;
 }
 
 static void renesas_sdhi_sys_dmac_release_dma(struct tmio_mmc_host *host)
diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index e7d6513..d8383d4 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -115,8 +115,7 @@ struct tmio_mmc_host;
 struct tmio_mmc_dma_ops {
 	void (*start)(struct tmio_mmc_host *host, struct mmc_data *data);
 	void (*enable)(struct tmio_mmc_host *host, bool enable);
-	void (*request)(struct tmio_mmc_host *host,
-			struct tmio_mmc_data *pdata);
+	int (*request)(struct tmio_mmc_host *host, struct tmio_mmc_data *pdata);
 	void (*release)(struct tmio_mmc_host *host);
 	void (*abort)(struct tmio_mmc_host *host);
 	void (*dataend)(struct tmio_mmc_host *host);
diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 3cb554c..09c2d0c 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -65,15 +65,13 @@ static inline void tmio_mmc_enable_dma(struct tmio_mmc_host *host, bool enable)
 		host->dma_ops->enable(host, enable);
 }
 
-static inline void tmio_mmc_request_dma(struct tmio_mmc_host *host,
-					struct tmio_mmc_data *pdata)
+static inline int tmio_mmc_request_dma(struct tmio_mmc_host *host,
+				       struct tmio_mmc_data *pdata)
 {
-	if (host->dma_ops) {
-		host->dma_ops->request(host, pdata);
-	} else {
-		host->chan_tx = NULL;
-		host->chan_rx = NULL;
-	}
+	if (host->dma_ops)
+		return host->dma_ops->request(host, pdata);
+
+	return 0;
 }
 
 static inline void tmio_mmc_release_dma(struct tmio_mmc_host *host)
@@ -1218,6 +1216,10 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host)
 			return ret;
 	}
 
+	ret = tmio_mmc_request_dma(_host, pdata);
+	if (ret)
+		return ret;
+
 	mmc->caps |= MMC_CAP_4_BIT_DATA | pdata->capabilities;
 	mmc->caps2 |= pdata->capabilities2;
 	mmc->max_segs = pdata->max_segs ? : 32;
@@ -1286,9 +1288,6 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host)
 	INIT_DELAYED_WORK(&_host->delayed_reset_work, tmio_mmc_reset_work);
 	INIT_WORK(&_host->done, tmio_mmc_done_work);
 
-	/* See if we also get DMA */
-	tmio_mmc_request_dma(_host, pdata);
-
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
 	pm_runtime_use_autosuspend(&pdev->dev);
-- 
2.7.4
