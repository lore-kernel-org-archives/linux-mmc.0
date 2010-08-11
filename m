From: akpm@linux-foundation.org
Subject: [patch 047/177] drivers/mmc/host/msm-sdcc: remove dead config options
Date: Tue, 10 Aug 2010 18:01:53 -0700
Message-ID: <201008110101.o7B11r3L027087@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:46012 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757897Ab0HKBCg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Aug 2010 21:02:36 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, qy03fugy@stud.informatik.uni-erlangen.de, davidb@codeaurora.org, dwalker@codeaurora.org, linux-mmc@vger.kernel.org

From: Christian Dietrich <qy03fugy@stud.informatik.uni-erlangen.de>

CONFIG_MMC_MSM7X00A_RESUME_IN_WQ and CONFIG_MMC_EMBEDDED_SDIO don't exist
in Kconfig and is never defined anywhere else, therefore removing all
references for it from the source code.

Signed-off-by: Christian Dietrich <qy03fugy@stud.informatik.uni-erlangen.de>
Acked-by: David Brown <davidb@codeaurora.org>
Cc: Daniel Walker <dwalker@codeaurora.org>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/host/msm_sdcc.c |   25 -------------------------
 drivers/mmc/host/msm_sdcc.h |    4 ----
 2 files changed, 29 deletions(-)

diff -puN drivers/mmc/host/msm_sdcc.c~drivers-mmc-host-msm-sdcc-remove-dead-config-options drivers/mmc/host/msm_sdcc.c
--- a/drivers/mmc/host/msm_sdcc.c~drivers-mmc-host-msm-sdcc-remove-dead-config-options
+++ a/drivers/mmc/host/msm_sdcc.c
@@ -1057,22 +1057,6 @@ msmsdcc_init_dma(struct msmsdcc_host *ho
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
@@ -1145,15 +1129,6 @@ msmsdcc_probe(struct platform_device *pd
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
diff -puN drivers/mmc/host/msm_sdcc.h~drivers-mmc-host-msm-sdcc-remove-dead-config-options drivers/mmc/host/msm_sdcc.h
--- a/drivers/mmc/host/msm_sdcc.h~drivers-mmc-host-msm-sdcc-remove-dead-config-options
+++ a/drivers/mmc/host/msm_sdcc.h
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
_
