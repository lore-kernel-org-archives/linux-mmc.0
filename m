From: Pramod Gurav <pramod.gurav@smartplayin.com>
Subject: [PATCH 5/5] mmc: msm_sdcc: Remove unwanted initializations in probe
Date: Tue, 16 Sep 2014 16:47:48 +0530
Message-ID: <1410866268-15185-6-git-send-email-pramod.gurav@smartplayin.com>
References: <1410866268-15185-1-git-send-email-pramod.gurav@smartplayin.com>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1410866268-15185-1-git-send-email-pramod.gurav@smartplayin.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: David Brown <davidb@codeaurora.org>, Daniel Walker <dwalker@fifo99.com>, Bryan Huntsman <bryanh@codeaurora.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

This removes unnecessary initialisations of resource pointers
and does away with a lable and just returns error on fail instead.

Cc: David Brown <davidb@codeaurora.org>
Cc: Daniel Walker <dwalker@fifo99.com>
Cc: Bryan Huntsman <bryanh@codeaurora.org>
CC: Ulf Hansson <ulf.hansson@linaro.org>
CC: linux-mmc@vger.kernel.org
CC: linux-arm-msm@vger.kernel.org
Signed-off-by: Pramod Gurav <pramod.gurav@smartplayin.com>
---
 drivers/mmc/host/msm_sdcc.c |   20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/msm_sdcc.c b/drivers/mmc/host/msm_sdcc.c
index 5025364..2b0c4d9 100644
--- a/drivers/mmc/host/msm_sdcc.c
+++ b/drivers/mmc/host/msm_sdcc.c
@@ -1166,17 +1166,16 @@ msmsdcc_probe(struct platform_device *pdev)
 	struct msm_mmc_platform_data *plat = pdev->dev.platform_data;
 	struct msmsdcc_host *host;
 	struct mmc_host *mmc;
-	struct resource *cmd_irqres = NULL;
-	struct resource *stat_irqres = NULL;
-	struct resource *memres = NULL;
-	struct resource *dmares = NULL;
+	struct resource *cmd_irqres;
+	struct resource *stat_irqres;
+	struct resource *memres;
+	struct resource *dmares;
 	int ret;
 
 	/* must have platform data */
 	if (!plat) {
 		dev_err(&pdev->dev, "Platform data not available\n");
-		ret = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 
 	if (pdev->id < 1 || pdev->id > 4)
@@ -1201,12 +1200,9 @@ msmsdcc_probe(struct platform_device *pdev)
 	/*
 	 * Setup our host structure
 	 */
-
 	mmc = mmc_alloc_host(sizeof(struct msmsdcc_host), &pdev->dev);
-	if (!mmc) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!mmc)
+		return -ENOMEM;
 
 	host = mmc_priv(mmc);
 	host->pdev_id = pdev->id;
@@ -1402,7 +1398,7 @@ msmsdcc_probe(struct platform_device *pdev)
 	tasklet_kill(&host->dma_tlet);
  host_free:
 	mmc_free_host(mmc);
- out:
+
 	return ret;
 }
 
-- 
1.7.9.5
