From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] mmc: delete is_first_req parameter from pre-request callback
Date: Wed, 23 Nov 2016 11:02:24 +0100
Message-ID: <1479895344-16818-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35481 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934780AbcKWKCf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Nov 2016 05:02:35 -0500
Received: by mail-wm0-f53.google.com with SMTP id a197so70291394wmd.0
        for <linux-mmc@vger.kernel.org>; Wed, 23 Nov 2016 02:02:35 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chunyan Zhang <zhang.chunyan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>, Linus Walleij <linus.walleij@linaro.org>

The void (*pre_req) callback in the struct mmc_host_ops vtable
is passing an argument "is_first_req" indicating whether this is
the first request or not.

None of the in-kernel users use this parameter: instead, since
they all just do variants of dma_map* they use the DMA cookie
to indicate whether a pre* callback has already been done for
a request when they decide how to handle it.

Delete the parameter from the callback and all users, as it is
just pointless cruft.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/core.c           | 11 ++++-------
 drivers/mmc/host/dw_mmc.c         |  3 +--
 drivers/mmc/host/jz4740_mmc.c     |  3 +--
 drivers/mmc/host/mmci.c           |  3 +--
 drivers/mmc/host/mtk-sd.c         |  3 +--
 drivers/mmc/host/omap_hsmmc.c     |  3 +--
 drivers/mmc/host/rtsx_pci_sdmmc.c |  3 +--
 drivers/mmc/host/sdhci.c          |  3 +--
 include/linux/mmc/host.h          |  3 +--
 9 files changed, 12 insertions(+), 23 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 67e262315a50..faeea26efba5 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -611,18 +611,15 @@ EXPORT_SYMBOL(mmc_is_req_done);
  *	mmc_pre_req - Prepare for a new request
  *	@host: MMC host to prepare command
  *	@mrq: MMC request to prepare for
- *	@is_first_req: true if there is no previous started request
- *                     that may run in parellel to this call, otherwise false
  *
  *	mmc_pre_req() is called in prior to mmc_start_req() to let
  *	host prepare for the new request. Preparation of a request may be
  *	performed while another request is running on the host.
  */
-static void mmc_pre_req(struct mmc_host *host, struct mmc_request *mrq,
-		 bool is_first_req)
+static void mmc_pre_req(struct mmc_host *host, struct mmc_request *mrq)
 {
 	if (host->ops->pre_req)
-		host->ops->pre_req(host, mrq, is_first_req);
+		host->ops->pre_req(host, mrq);
 }
 
 /**
@@ -667,7 +664,7 @@ struct mmc_async_req *mmc_start_req(struct mmc_host *host,
 
 	/* Prepare a new request */
 	if (areq)
-		mmc_pre_req(host, areq->mrq, !host->areq);
+		mmc_pre_req(host, areq->mrq);
 
 	if (host->areq) {
 		status = mmc_wait_for_data_req_done(host, host->areq->mrq, areq);
@@ -696,7 +693,7 @@ struct mmc_async_req *mmc_start_req(struct mmc_host *host,
 
 			/* prepare the request again */
 			if (areq)
-				mmc_pre_req(host, areq->mrq, !host->areq);
+				mmc_pre_req(host, areq->mrq);
 		}
 	}
 
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 4fcbc4012ed0..969acbf0740c 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -883,8 +883,7 @@ static int dw_mci_pre_dma_transfer(struct dw_mci *host,
 }
 
 static void dw_mci_pre_req(struct mmc_host *mmc,
-			   struct mmc_request *mrq,
-			   bool is_first_req)
+			   struct mmc_request *mrq)
 {
 	struct dw_mci_slot *slot = mmc_priv(mmc);
 	struct mmc_data *data = mrq->data;
diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index 684087db170b..819ad32964fc 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -320,8 +320,7 @@ static int jz4740_mmc_start_dma_transfer(struct jz4740_mmc_host *host,
 }
 
 static void jz4740_mmc_pre_request(struct mmc_host *mmc,
-				   struct mmc_request *mrq,
-				   bool is_first_req)
+				   struct mmc_request *mrq)
 {
 	struct jz4740_mmc_host *host = mmc_priv(mmc);
 	struct mmc_data *data = mrq->data;
diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index df990bb8c873..1ddbb64e385a 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -684,8 +684,7 @@ static void mmci_get_next_data(struct mmci_host *host, struct mmc_data *data)
 	next->dma_chan = NULL;
 }
 
-static void mmci_pre_request(struct mmc_host *mmc, struct mmc_request *mrq,
-			     bool is_first_req)
+static void mmci_pre_request(struct mmc_host *mmc, struct mmc_request *mrq)
 {
 	struct mmci_host *host = mmc_priv(mmc);
 	struct mmc_data *data = mrq->data;
diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 84e9afcb5c09..db185441966d 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -927,8 +927,7 @@ static void msdc_ops_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		msdc_start_command(host, mrq, mrq->cmd);
 }
 
-static void msdc_pre_req(struct mmc_host *mmc, struct mmc_request *mrq,
-		bool is_first_req)
+static void msdc_pre_req(struct mmc_host *mmc, struct mmc_request *mrq)
 {
 	struct msdc_host *host = mmc_priv(mmc);
 	struct mmc_data *data = mrq->data;
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 5f2f24a7360d..ad11c4cc12ed 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1565,8 +1565,7 @@ static void omap_hsmmc_post_req(struct mmc_host *mmc, struct mmc_request *mrq,
 	}
 }
 
-static void omap_hsmmc_pre_req(struct mmc_host *mmc, struct mmc_request *mrq,
-			       bool is_first_req)
+static void omap_hsmmc_pre_req(struct mmc_host *mmc, struct mmc_request *mrq)
 {
 	struct omap_hsmmc_host *host = mmc_priv(mmc);
 
diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
index 3ccaa1415f33..ecb99a8d2fa2 100644
--- a/drivers/mmc/host/rtsx_pci_sdmmc.c
+++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
@@ -190,8 +190,7 @@ static int sd_pre_dma_transfer(struct realtek_pci_sdmmc *host,
 	return using_cookie;
 }
 
-static void sdmmc_pre_req(struct mmc_host *mmc, struct mmc_request *mrq,
-		bool is_first_req)
+static void sdmmc_pre_req(struct mmc_host *mmc, struct mmc_request *mrq)
 {
 	struct realtek_pci_sdmmc *host = mmc_priv(mmc);
 	struct mmc_data *data = mrq->data;
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 48055666c655..eefe5ed73822 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2190,8 +2190,7 @@ static void sdhci_post_req(struct mmc_host *mmc, struct mmc_request *mrq,
 	data->host_cookie = COOKIE_UNMAPPED;
 }
 
-static void sdhci_pre_req(struct mmc_host *mmc, struct mmc_request *mrq,
-			       bool is_first_req)
+static void sdhci_pre_req(struct mmc_host *mmc, struct mmc_request *mrq)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
 
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 5310f94be0ab..fdd13e0b8ec8 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -93,8 +93,7 @@ struct mmc_host_ops {
 	 */
 	void	(*post_req)(struct mmc_host *host, struct mmc_request *req,
 			    int err);
-	void	(*pre_req)(struct mmc_host *host, struct mmc_request *req,
-			   bool is_first_req);
+	void	(*pre_req)(struct mmc_host *host, struct mmc_request *req);
 	void	(*request)(struct mmc_host *host, struct mmc_request *req);
 
 	/*
-- 
2.7.4

