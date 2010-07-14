From: Christian Dietrich <qy03fugy@stud.informatik.uni-erlangen.de>
Subject: [PATCH 4/5] drivers/mmc/host/msm-sdcc: Remove dead config options
Date: Wed, 14 Jul 2010 16:04:53 +0200
Message-ID: <459cdebccb9bfaa88194b47608e7e739339aae55.1279116162.git.qy03fugy__11723.6618571498$1279116375$gmane$org@stud.informatik.uni-erlangen.de>
References: <c3c850bed3f5714f1efcfad24ad4f8bfcb6b5b54.1279116162.git.qy03fugy@stud.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from faui40.informatik.uni-erlangen.de ([131.188.34.40]:47087 "EHLO
	faui40.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756520Ab0GNOEz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Jul 2010 10:04:55 -0400
Content-Disposition: inline
In-Reply-To: <c3c850bed3f5714f1efcfad24ad4f8bfcb6b5b54.1279116162.git.qy03fugy@stud.informatik.uni-erlangen.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Brown <davidb@codeaurora.org>, Daniel Walker <dwalker@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, San Mehat <san@google.com>, Andrew Morton <akpm@linux-foundation.>
Cc: vamos-dev@i4.informatik.uni-erlangen.de

CONFIG_MMC_MSM7X00A_RESUME_IN_WQ and CONFIG_MMC_EMBEDDED_SDIO don't
exist in Kconfig and is never defined anywhere else, therefore removing
all references for it from the source code.

Signed-off-by: Christian Dietrich <qy03fugy@stud.informatik.uni-erlangen.de>
---
 drivers/mmc/host/msm_sdcc.c |   25 -------------------------
 drivers/mmc/host/msm_sdcc.h |    4 ----
 2 files changed, 0 insertions(+), 29 deletions(-)

diff --git a/drivers/mmc/host/msm_sdcc.c b/drivers/mmc/host/msm_sdcc.c
index 24e0945..3bd8ff7 100644
--- a/drivers/mmc/host/msm_sdcc.c
+++ b/drivers/mmc/host/msm_sdcc.c
@@ -1057,22 +1057,6 @@ msmsdcc_init_dma(struct msmsdcc_host *host)
 	return 0;
 }
 
-#ifdef CONFIG_MMC_MSM7X00A_RESUME_IN_WQ
-static void
-do_resume_work(struct work_struct *work)
-{
-	struct msmsdcc_host *host =
-		container_of(work, struct msmsdcc_host, resume_task);
-	struct mmc_host	*mmc = host->mmc;
-
-	if (mmc) {
-		mmc_resume_host(mmc);
-		if (host->stat_irq)
-			enable_irq(host->stat_irq);
-	}
-}
-#endif
-
 static int
 msmsdcc_probe(struct platform_device *pdev)
 {
@@ -1145,15 +1129,6 @@ msmsdcc_probe(struct platform_device *pdev)
 	host->dmares = dmares;
 	spin_lock_init(&host->lock);
 
-#ifdef CONFIG_MMC_EMBEDDED_SDIO
-	if (plat->embedded_sdio)
-		mmc_set_embedded_sdio_data(mmc,
-					   &plat->embedded_sdio->cis,
-					   &plat->embedded_sdio->cccr,
-					   plat->embedded_sdio->funcs,
-					   plat->embedded_sdio->num_funcs);
-#endif
-
 	/*
 	 * Setup DMA
 	 */
diff --git a/drivers/mmc/host/msm_sdcc.h b/drivers/mmc/host/msm_sdcc.h
index da0039c..d7dedcf 100644
--- a/drivers/mmc/host/msm_sdcc.h
+++ b/drivers/mmc/host/msm_sdcc.h
@@ -235,10 +235,6 @@ struct msmsdcc_host {
 	int			cmdpoll;
 	struct msmsdcc_stats	stats;
 
-#ifdef CONFIG_MMC_MSM7X00A_RESUME_IN_WQ
-	struct work_struct	resume_task;
-#endif
-
 	/* Command parameters */
 	unsigned int		cmd_timeout;
 	unsigned int		cmd_pio_irqmask;
-- 
1.7.0.4

