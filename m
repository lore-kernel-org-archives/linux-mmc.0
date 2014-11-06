From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 2/4] mmc: sdhci: Fix vqmmc error setting
Date: Thu,  6 Nov 2014 14:25:32 +0200
Message-ID: <1415276734-28286-3-git-send-email-adrian.hunter@intel.com>
References: <1415276734-28286-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:16542 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751121AbaKFM1K (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 6 Nov 2014 07:27:10 -0500
In-Reply-To: <1415276734-28286-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

supply.vqmmc is used with the IS_ERR macro which means
the value must be valid or an error code.  NULL is
neither, so replace with ERR_PTR(-EINVAL).

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index a743d52..c2f4754 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3096,7 +3096,7 @@ int sdhci_add_host(struct sdhci_host *host)
 		if (ret) {
 			pr_warn("%s: Failed to enable vqmmc regulator: %d\n",
 				mmc_hostname(mmc), ret);
-			mmc->supply.vqmmc = NULL;
+			mmc->supply.vqmmc = ERR_PTR(-EINVAL);
 		}
 	}
 
-- 
1.9.1

