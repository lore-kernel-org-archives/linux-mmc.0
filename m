From: Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH] mmc: sdhci-pxav3: fix race between runtime pm and irq
Date: Wed, 21 Jan 2015 20:45:13 +0800
Message-ID: <1421844313-2851-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: chris@printf.net, ulf.hansson@linaro.org, sebastian.hesselbarth@gmail.com
Cc: thomas.petazzoni@free-electrons.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Jisheng Zhang <jszhang@marvell.com>, stable@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

This patch is to fix a race condition that may cause an unhandled irq,
which results in big sdhci interrupt numbers and endless "mmc1: got irq
while runtime suspended" msgs before v3.15.

Consider following scenario:

      CPU0                            CPU1
                              sdhci_pxav3_runtime_suspend()
                               spin_lock_irqsave(&host->lock, flags);
 sdhci_irq()
  spining on the &host->lock
                               host->runtime_suspended = true;
                               spin_unlock_irqrestore(&host->lock, flags);
  get the &host->lock
  runtime_suspended is true now
  return IRQ_NONE;

Fix this race by using the core sdhci.c supplied sdhci_runtime_suspend_host()
in runtime suspend hook which will disable card interrupts. We also use the
sdhci_runtime_resume_host() in the runtime resume hook accordingly.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
Cc: <stable@vger.kernel.org> # v3.9+
---
 drivers/mmc/host/sdhci-pxav3.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index 4de39fb..6975c51 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -460,17 +460,15 @@ static int sdhci_pxav3_runtime_suspend(struct device *dev)
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_pxa *pxa = pltfm_host->priv;
-	unsigned long flags;
+	int ret;
 
-	spin_lock_irqsave(&host->lock, flags);
-	host->runtime_suspended = true;
-	spin_unlock_irqrestore(&host->lock, flags);
+	ret = sdhci_runtime_suspend_host(host);
 
 	clk_disable_unprepare(pxa->clk_io);
 	if (!IS_ERR(pxa->clk_core))
 		clk_disable_unprepare(pxa->clk_core);
 
-	return 0;
+	return ret;
 }
 
 static int sdhci_pxav3_runtime_resume(struct device *dev)
@@ -478,17 +476,12 @@ static int sdhci_pxav3_runtime_resume(struct device *dev)
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_pxa *pxa = pltfm_host->priv;
-	unsigned long flags;
 
 	clk_prepare_enable(pxa->clk_io);
 	if (!IS_ERR(pxa->clk_core))
 		clk_prepare_enable(pxa->clk_core);
 
-	spin_lock_irqsave(&host->lock, flags);
-	host->runtime_suspended = false;
-	spin_unlock_irqrestore(&host->lock, flags);
-
-	return 0;
+	return sdhci_runtime_resume_host(host);
 }
 #endif
 
-- 
2.1.4
