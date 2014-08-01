From: Chuanxiao Dong <chuanxiao.dong@intel.com>
Subject: [PATCH] mmc: sdhci: fix the wrong type of curr
Date: Fri, 1 Aug 2014 14:00:13 +0800
Message-ID: <20140801060012.GA2568@intel.com>
Reply-To: Chuanxiao Dong <chuanxiao.dong@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:31312 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750770AbaHAGCG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 1 Aug 2014 02:02:06 -0400
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org, ulf.hansson@linaro.org

curr should use signed type since it will contain the returned
value which is possible to be a negative value. Using u32 will
make the returned value to be true even there is a negative result.
Change to use int instead of u32

Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
---
 drivers/mmc/host/sdhci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 47055f3..c026ec8 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3078,7 +3078,7 @@ int sdhci_add_host(struct sdhci_host *host)
 	 */
 	max_current_caps = sdhci_readl(host, SDHCI_MAX_CURRENT);
 	if (!max_current_caps && host->vmmc) {
-		u32 curr = regulator_get_current_limit(host->vmmc);
+		int curr = regulator_get_current_limit(host->vmmc);
 		if (curr > 0) {
 
 			/* convert to SDHCI_MAX_CURRENT format */
-- 
1.7.10.4
