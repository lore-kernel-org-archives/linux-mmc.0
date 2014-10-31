From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 2/4] mmc: sdhci: Fix vqmmc error setting
Date: Fri, 31 Oct 2014 14:22:49 +0200
Message-ID: <1414758171-1244-3-git-send-email-adrian.hunter@intel.com>
References: <1414758171-1244-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:64398 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759419AbaJaMYj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 31 Oct 2014 08:24:39 -0400
In-Reply-To: <1414758171-1244-1-git-send-email-adrian.hunter@intel.com>
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
index f895ab0..7736a2c 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3091,7 +3091,7 @@ int sdhci_add_host(struct sdhci_host *host)
 		if (ret) {
 			pr_warn("%s: Failed to enable vqmmc regulator: %d\n",
 				mmc_hostname(mmc), ret);
-			mmc->supply.vqmmc = NULL;
+			mmc->supply.vqmmc = ERR_PTR(-EINVAL);
 		}
 	}
 
-- 
1.9.1

