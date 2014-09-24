From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 18/27] mmc: sdhci: use pm_runtime_last_busy_and_autosuspend helper
Date: Wed, 24 Sep 2014 21:45:08 +0530
Message-ID: <1411575342-31048-19-git-send-email-vinod.koul@intel.com>
References: <1411575342-31048-1-git-send-email-vinod.koul@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1411575342-31048-1-git-send-email-vinod.koul@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: subhransu.s.prusty@intel.com, vinod.koul@intel.com, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Use the new pm_runtime_last_busy_and_autosuspend helper instead of open
coding the same code

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 drivers/mmc/host/sdhci.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 37b2a9a..862346a 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2623,8 +2623,7 @@ static int sdhci_runtime_pm_get(struct sdhci_host *host)
 
 static int sdhci_runtime_pm_put(struct sdhci_host *host)
 {
-	pm_runtime_mark_last_busy(host->mmc->parent);
-	return pm_runtime_put_autosuspend(host->mmc->parent);
+	return pm_runtime_last_busy_and_autosuspend(host->mmc->parent);
 }
 
 static void sdhci_runtime_pm_bus_on(struct sdhci_host *host)
-- 
1.7.0.4
