From: NeilBrown <neil@brown.name>
Subject: [PATCH 1/2] mmc: omap_hsmmc: stop using .enable and .disable method.
Date: Thu, 26 Mar 2015 08:43:37 +1100
Message-ID: <20150325214337.11463.93489.stgit@notabene.brown>
References: <20150325213419.11463.33321.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150325213419.11463.33321.stgit@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Chris Ball <chris@printf.net>
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

enable and disable are only used to get and put
runtime pm references.  .set_ios already does this
itself, and other drivers just do it in set_ios
and .request without using enable/disable.

So add pm_runtime get/put to omap_hsmmc_request(),
and discard the enable/disable methods.

Signed-off-by: NeilBrown <neil@brown.name>
---
 drivers/mmc/host/omap_hsmmc.c |   24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index f84cfb01716d..092bcecd73e6 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -882,6 +882,8 @@ static void omap_hsmmc_request_done(struct omap_hsmmc_host *host, struct mmc_req
 		return;
 	host->mrq = NULL;
 	mmc_request_done(host->mmc, mrq);
+	pm_runtime_mark_last_busy(host->dev);
+	pm_runtime_put_autosuspend(host->dev);
 }
 
 /*
@@ -1537,6 +1539,7 @@ static void omap_hsmmc_request(struct mmc_host *mmc, struct mmc_request *req)
 
 	BUG_ON(host->req_in_progress);
 	BUG_ON(host->dma_ch != -1);
+	pm_runtime_get_sync(host->dev);
 	if (host->protect_card) {
 		if (host->reqs_blocked < 3) {
 			/*
@@ -1778,25 +1781,6 @@ static void omap_hsmmc_conf_bus_power(struct omap_hsmmc_host *host)
 	set_sd_bus_power(host);
 }
 
-static int omap_hsmmc_enable_fclk(struct mmc_host *mmc)
-{
-	struct omap_hsmmc_host *host = mmc_priv(mmc);
-
-	pm_runtime_get_sync(host->dev);
-
-	return 0;
-}
-
-static int omap_hsmmc_disable_fclk(struct mmc_host *mmc)
-{
-	struct omap_hsmmc_host *host = mmc_priv(mmc);
-
-	pm_runtime_mark_last_busy(host->dev);
-	pm_runtime_put_autosuspend(host->dev);
-
-	return 0;
-}
-
 static int omap_hsmmc_multi_io_quirk(struct mmc_card *card,
 				     unsigned int direction, int blk_size)
 {
@@ -1808,8 +1792,6 @@ static int omap_hsmmc_multi_io_quirk(struct mmc_card *card,
 }
 
 static struct mmc_host_ops omap_hsmmc_ops = {
-	.enable = omap_hsmmc_enable_fclk,
-	.disable = omap_hsmmc_disable_fclk,
 	.post_req = omap_hsmmc_post_req,
 	.pre_req = omap_hsmmc_pre_req,
 	.request = omap_hsmmc_request,
