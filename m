From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 10/25] mmc: sdhci: Reduce spin lock usage in sdhci_execute_tuning
Date: Mon, 20 Mar 2017 19:50:38 +0200
Message-ID: <1490032253-6030-11-git-send-email-adrian.hunter@intel.com>
References: <1490032253-6030-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:11877 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756047AbdCTR6O (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 20 Mar 2017 13:58:14 -0400
In-Reply-To: <1490032253-6030-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Al Cooper <alcooperx@gmail.com>, Jaedon Shin <jaedon.shin@gmail.com>, Haibo Chen <haibo.chen@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>, Shawn Lin <shawn.lin@rock-chips.com>, Douglas Anderson <dianders@chromium.org>, Zach Brown <zach.brown@ni.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, Jisheng Zhang <jszhang@marvell.com>, Yangbo Lu <yangbo.lu@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, Weijun Yang <Weijun.Yang@csr.com>, Barry Song <Baohua.Song@csr.com>, Peter Griffin <peter.griffin@linaro.org>, Lee Jones <lee.jones@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Harjani Ritesh <riteshh@codeaurora.org>

Tuning execution is already synchronized with respect to other host
operations by upper layers "claiming" the host, which also takes care of
runtime pm. There can be no requests in progress. Retain the spin lock
usage only for ensuring that sending tuning commands is synchronized with
respect to the interrupt handler.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 36 ++++++++++++++----------------------
 1 file changed, 14 insertions(+), 22 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index f7dfb40826c7..fffd2efd703e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1987,8 +1987,7 @@ static void sdhci_reset_tuning(struct sdhci_host *host)
 	sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
 }
 
-static void sdhci_abort_tuning(struct sdhci_host *host, u32 opcode,
-			       unsigned long flags)
+static void sdhci_abort_tuning(struct sdhci_host *host, u32 opcode)
 {
 	sdhci_reset_tuning(host);
 
@@ -1997,9 +1996,7 @@ static void sdhci_abort_tuning(struct sdhci_host *host, u32 opcode,
 
 	sdhci_end_tuning(host);
 
-	spin_unlock_irqrestore(&host->lock, flags);
 	mmc_abort_tuning(host->mmc, opcode);
-	spin_lock_irqsave(&host->lock, flags);
 }
 
 /*
@@ -2009,12 +2006,14 @@ static void sdhci_abort_tuning(struct sdhci_host *host, u32 opcode,
  * interrupt setup is different to other commands and there is no timeout
  * interrupt so special handling is needed.
  */
-static void sdhci_send_tuning(struct sdhci_host *host, u32 opcode,
-			      unsigned long flags)
+static void sdhci_send_tuning(struct sdhci_host *host, u32 opcode)
 {
 	struct mmc_host *mmc = host->mmc;
 	struct mmc_command cmd = {};
 	struct mmc_request mrq = {};
+	unsigned long flags;
+
+	spin_lock_irqsave(&host->lock, flags);
 
 	cmd.opcode = opcode;
 	cmd.flags = MMC_RSP_R1 | MMC_CMD_ADTC;
@@ -2048,17 +2047,16 @@ static void sdhci_send_tuning(struct sdhci_host *host, u32 opcode,
 
 	host->tuning_done = 0;
 
+	mmiowb();
 	spin_unlock_irqrestore(&host->lock, flags);
 
 	/* Wait for Buffer Read Ready interrupt */
 	wait_event_timeout(host->buf_ready_int, (host->tuning_done == 1),
 			   msecs_to_jiffies(50));
 
-	spin_lock_irqsave(&host->lock, flags);
 }
 
-static void __sdhci_execute_tuning(struct sdhci_host *host, u32 opcode,
-				   unsigned long flags)
+static void __sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
 {
 	int i;
 
@@ -2069,12 +2067,12 @@ static void __sdhci_execute_tuning(struct sdhci_host *host, u32 opcode,
 	for (i = 0; i < MAX_TUNING_LOOP; i++) {
 		u16 ctrl;
 
-		sdhci_send_tuning(host, opcode, flags);
+		sdhci_send_tuning(host, opcode);
 
 		if (!host->tuning_done) {
 			pr_info("%s: Tuning timeout, falling back to fixed sampling clock\n",
 				mmc_hostname(host->mmc));
-			sdhci_abort_tuning(host, opcode, flags);
+			sdhci_abort_tuning(host, opcode);
 			return;
 		}
 
@@ -2099,12 +2097,9 @@ int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
 	int err = 0;
-	unsigned long flags;
 	unsigned int tuning_count = 0;
 	bool hs400_tuning;
 
-	spin_lock_irqsave(&host->lock, flags);
-
 	hs400_tuning = host->flags & SDHCI_HS400_TUNING;
 
 	if (host->tuning_mode == SDHCI_TUNING_MODE_1)
@@ -2121,7 +2116,7 @@ int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	/* HS400 tuning is done in HS200 mode */
 	case MMC_TIMING_MMC_HS400:
 		err = -EINVAL;
-		goto out_unlock;
+		goto out;
 
 	case MMC_TIMING_MMC_HS200:
 		/*
@@ -2142,26 +2137,23 @@ int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 		/* FALLTHROUGH */
 
 	default:
-		goto out_unlock;
+		goto out;
 	}
 
 	if (host->ops->platform_execute_tuning) {
-		spin_unlock_irqrestore(&host->lock, flags);
 		err = host->ops->platform_execute_tuning(host, opcode);
-		spin_lock_irqsave(&host->lock, flags);
-		goto out_unlock;
+		goto out;
 	}
 
 	host->mmc->retune_period = tuning_count;
 
 	sdhci_start_tuning(host);
 
-	__sdhci_execute_tuning(host, opcode, flags);
+	__sdhci_execute_tuning(host, opcode);
 
 	sdhci_end_tuning(host);
-out_unlock:
+out:
 	host->flags &= ~SDHCI_HS400_TUNING;
-	spin_unlock_irqrestore(&host->lock, flags);
 
 	return err;
 }
-- 
1.9.1

