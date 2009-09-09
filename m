From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH V3 15/30] omap_hsmmc: fix scatter-gather list sanity checking
Date: Wed, 09 Sep 2009 14:58:25 +0300
Message-ID: <20090909115825.12833.2425.sendpatchset@ahunter-laptop>
References: <20090909115633.12833.39619.sendpatchset@ahunter-laptop>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20090909115633.12833.39619.sendpatchset@ahunter-laptop>
Sender: linux-omap-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jarkko Lavinen <jarkko.lavinen@nokia.com>, Adrian Hunter <adrian.hunter@nokia.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, Pierre Ossman <pierre@ossman.eu>, linux-omap Mailing List <linux-omap@vger.kernel.org>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>, Matt Fleming <matt@console-pimps.org>
List-Id: linux-mmc@vger.kernel.org

>From fff912de41b3c8b5036aaa4d8ac6762efac533f0 Mon Sep 17 00:00:00 2001
From: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Date: Fri, 24 Apr 2009 14:20:43 +0300
Subject: [PATCH] omap_hsmmc: fix scatter-gather list sanity checking

Do not use host->dma_len when it is uninitialzed.
Finish the request with an error if the mmc_omap_prepare_data()
fails.

Signed-off-by: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 drivers/mmc/host/omap_hsmmc.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 041af02..df13a54 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -871,7 +871,7 @@ mmc_omap_start_dma_transfer(struct mmc_omap_host *host, struct mmc_request *req)
 	struct mmc_data *data = req->data;
 
 	/* Sanity check: all the SG entries must be aligned by block size. */
-	for (i = 0; i < host->dma_len; i++) {
+	for (i = 0; i < data->sg_len; i++) {
 		struct scatterlist *sgl;
 
 		sgl = data->sg + i;
@@ -1014,10 +1014,20 @@ static int omap_mmc_disable(struct mmc_host *mmc, int lazy)
 static void omap_mmc_request(struct mmc_host *mmc, struct mmc_request *req)
 {
 	struct mmc_omap_host *host = mmc_priv(mmc);
+	int err;
 
 	WARN_ON(host->mrq != NULL);
 	host->mrq = req;
-	mmc_omap_prepare_data(host, req);
+	err = mmc_omap_prepare_data(host, req);
+	if (err) {
+		req->cmd->error = err;
+		if (req->data)
+			req->data->error = err;
+		host->mrq = NULL;
+		mmc_request_done(mmc, req);
+		return;
+	}
+
 	mmc_omap_start_command(host, req->cmd, req->data);
 }
 
-- 
1.5.6.3

