From: Haibo Chen <haibo.chen@nxp.com>
Subject: [PATCH] mmc: sdhci: cast unsigned int to unsigned long long to avoid unexpeted error
Date: Tue, 13 Sep 2016 15:06:58 +0800
Message-ID: <1473750418-23111-1-git-send-email-haibo.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db5eur01on0061.outbound.protection.outlook.com ([104.47.2.61]:17536
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755679AbcIMJhZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 13 Sep 2016 05:37:25 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org

Potentially overflowing expression 1000000 * data->timeout_clks with
type unsigned int is evaluated using 32-bit arithmetic, and then used
in a context that expects an expression of type unsigned long long.

To avoid overflow, cast 1000000U to type unsigned long long.
Special thanks to coverity <http://www.coverity.com>

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mmc/host/sdhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 4805566..0e9f495 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -687,7 +687,7 @@ static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd)
 			 * host->clock is in Hz.  target_timeout is in us.
 			 * Hence, us = 1000000 * cycles / Hz.  Round up.
 			 */
-			val = 1000000 * data->timeout_clks;
+			val = (unsigned long long)1000000 * data->timeout_clks;
 			if (do_div(val, host->clock))
 				target_timeout++;
 			target_timeout += val;
-- 
1.9.1

