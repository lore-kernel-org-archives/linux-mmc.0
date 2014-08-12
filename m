From: Peter Griffin <peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 4/5] mmc: sdhci-pci: Use SET_RUNTIME_PM_OPS macro to set runtime pm callbacks
Date: Tue, 12 Aug 2014 17:14:28 +0100
Message-ID: <1407860069-12706-5-git-send-email-peter.griffin@linaro.org>
References: <1407860069-12706-1-git-send-email-peter.griffin@linaro.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1407860069-12706-1-git-send-email-peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jarkko.lavinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, balajitk-l0cyMroinI0@public.gmane.org, baohua-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, viresh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, ian.molton-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org
Cc: peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

This allows us to get rid of the #else condition, as the macro compiles
away to nothing if not enabled.

Signed-off-by: Peter Griffin <peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/mmc/host/sdhci-pci.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index 52c42fc..745629d 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -1267,20 +1267,13 @@ static int sdhci_pci_runtime_idle(struct device *dev)
 	return 0;
 }
 
-#else
-
-#define sdhci_pci_runtime_suspend	NULL
-#define sdhci_pci_runtime_resume	NULL
-#define sdhci_pci_runtime_idle		NULL
-
 #endif
 
 static const struct dev_pm_ops sdhci_pci_pm_ops = {
 	.suspend = sdhci_pci_suspend,
 	.resume = sdhci_pci_resume,
-	.runtime_suspend = sdhci_pci_runtime_suspend,
-	.runtime_resume = sdhci_pci_runtime_resume,
-	.runtime_idle = sdhci_pci_runtime_idle,
+	SET_RUNTIME_PM_OPS(sdhci_pci_runtime_suspend,
+			sdhci_pci_runtime_resume, sdhci_pci_runtime_idle)
 };
 
 /*****************************************************************************\
-- 
1.9.1
