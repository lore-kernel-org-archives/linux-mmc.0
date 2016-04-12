From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 3/5] mmc: sdhci: Remove redundant condition
Date: Tue, 12 Apr 2016 14:25:07 +0300
Message-ID: <1460460309-13619-4-git-send-email-adrian.hunter@intel.com>
References: <1460460309-13619-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:9541 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932926AbcDLL3I (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 12 Apr 2016 07:29:08 -0400
In-Reply-To: <1460460309-13619-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

The logic '!mmc.f_max || (mmc.f_max && mmc.f_max > max_clk)'
is equivalent to '!mmc.f_max || mmc.f_max > max_clk'.

Reported-by: David Binderman <dcb314@hotmail.com>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index c6dbe65ada20..3e221e9a7b52 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2992,7 +2992,7 @@ int sdhci_add_host(struct sdhci_host *host)
 	} else
 		mmc->f_min = host->max_clk / SDHCI_MAX_DIV_SPEC_200;
 
-	if (!mmc->f_max || (mmc->f_max && (mmc->f_max > max_clk)))
+	if (!mmc->f_max || mmc->f_max > max_clk)
 		mmc->f_max = max_clk;
 
 	if (!(host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)) {
-- 
1.9.1

