From: Per Forlin <per.forlin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v2 10/12] omap_hsmmc: use original sg_len for dma_unmap_sg
Date: Wed,  6 Apr 2011 21:07:11 +0200
Message-ID: <1302116833-24540-11-git-send-email-per.forlin@linaro.org>
References: <1302116833-24540-1-git-send-email-per.forlin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <1302116833-24540-1-git-send-email-per.forlin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Cc: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Don't use the returned sg_len from dma_map_sg() as inparameter
to dma_unmap_sg(). Use the original sg_len for both dma_map_sg
and dma_unmap_sg.

Signed-off-by: Per Forlin <per.forlin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/mmc/host/omap_hsmmc.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 259ece0..ad3731a 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -959,7 +959,8 @@ static void omap_hsmmc_dma_cleanup(struct omap_hsmmc_host *host, int errno)
 	spin_unlock(&host->irq_lock);
 
 	if (host->use_dma && dma_ch != -1) {
-		dma_unmap_sg(mmc_dev(host->mmc), host->data->sg, host->dma_len,
+		dma_unmap_sg(mmc_dev(host->mmc), host->data->sg,
+			host->data->sg_len,
 			omap_hsmmc_get_dma_dir(host, host->data));
 		omap_free_dma(dma_ch);
 	}
@@ -1343,7 +1344,7 @@ static void omap_hsmmc_dma_cb(int lch, u16 ch_status, void *cb_data)
 		return;
 	}
 
-	dma_unmap_sg(mmc_dev(host->mmc), data->sg, host->dma_len,
+	dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
 		omap_hsmmc_get_dma_dir(host, data));
 
 	req_in_progress = host->req_in_progress;
-- 
1.7.4.1
