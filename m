From: Haibo Chen <haibo.chen@nxp.com>
Subject: [PATCH v2] mmc: sdhci: cast unsigned int to unsigned long long to avoid unexpeted error
Date: Mon, 17 Oct 2016 16:18:37 +0800
Message-ID: <1476692317-26845-1-git-send-email-haibo.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db5eur01on0075.outbound.protection.outlook.com ([104.47.2.75]:44704
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934797AbcJQVr1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 17 Oct 2016 17:47:27 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, rmk+kernel@arm.linux.org.uk
Cc: stable@vger.kernel.org, linux-mmc@vger.kernel.org, haibo.chen@nxp.com

Potentially overflowing expression 1000000 * data->timeout_clks with
type unsigned int is evaluated using 32-bit arithmetic, and then used
in a context that expects an expression of type unsigned long long.

To avoid overflow, cast 1000000U to type unsigned long long.
Special thanks to Coverity.

Fixes: 7f05538af71c ("mmc: sdhci: fix data timeout (part 2)")
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Cc: stable@vger.kernel.org # v3.15+
---
 drivers/mmc/host/sdhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 223a91e..71654b9 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -687,7 +687,7 @@ static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd)
 			 * host->clock is in Hz.  target_timeout is in us.
 			 * Hence, us = 1000000 * cycles / Hz.  Round up.
 			 */
-			val = 1000000 * data->timeout_clks;
+			val = 1000000ULL * data->timeout_clks;
 			if (do_div(val, host->clock))
 				target_timeout++;
 			target_timeout += val;
-- 
1.9.1

