From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 17/27] mmc: sdhci-pxav3: use pm_runtime_last_busy_and_autosuspend helper
Date: Wed, 24 Sep 2014 21:45:07 +0530
Message-ID: <1411575342-31048-18-git-send-email-vinod.koul@intel.com>
References: <1411575342-31048-1-git-send-email-vinod.koul@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1411575342-31048-1-git-send-email-vinod.koul@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: subhransu.s.prusty@intel.com, vinod.koul@intel.com, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Russell King <rmk+kernel@arm.linux.org.uk>, Marcin Wojtas <mw@semihalf.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Use the new pm_runtime_last_busy_and_autosuspend helper instead of open
coding the same code

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 drivers/mmc/host/sdhci-pxav3.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index 6f842fb..2706d3f 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -417,8 +417,7 @@ static int sdhci_pxav3_suspend(struct device *dev)
 
 	pm_runtime_get_sync(dev);
 	ret = sdhci_suspend_host(host);
-	pm_runtime_mark_last_busy(dev);
-	pm_runtime_put_autosuspend(dev);
+	pm_runtime_last_busy_and_autosuspend(dev);
 
 	return ret;
 }
@@ -430,8 +429,7 @@ static int sdhci_pxav3_resume(struct device *dev)
 
 	pm_runtime_get_sync(dev);
 	ret = sdhci_resume_host(host);
-	pm_runtime_mark_last_busy(dev);
-	pm_runtime_put_autosuspend(dev);
+	pm_runtime_last_busy_and_autosuspend(dev);
 
 	return ret;
 }
-- 
1.7.0.4
