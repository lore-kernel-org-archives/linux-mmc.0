From: Tushar Behera <tushar.behera@linaro.org>
Subject: [PATCH 6/8] mmc: sdhci: fix coding style in sdhci_execute_tuning
Date: Fri,  9 Nov 2012 17:09:56 +0530
Message-ID: <1352461198-21941-7-git-send-email-tushar.behera@linaro.org>
References: <1352461198-21941-1-git-send-email-tushar.behera@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1352461198-21941-1-git-send-email-tushar.behera@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, patches@linaro.org
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---
 drivers/mmc/host/sdhci.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index b947155..4bed582 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1792,9 +1792,9 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 		requires_tuning_nonuhs = true;
 
 	if (((ctrl & SDHCI_CTRL_UHS_MASK) == SDHCI_CTRL_UHS_SDR104) ||
-	    requires_tuning_nonuhs)
+	    requires_tuning_nonuhs) {
 		ctrl |= SDHCI_CTRL_EXEC_TUNING;
-	else {
+	} else {
 		spin_unlock(&host->lock);
 		enable_irq(host->irq);
 		sdhci_runtime_pm_put(host);
-- 
1.7.4.1
