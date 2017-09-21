From: Yangbo Lu <yangbo.lu@nxp.com>
Subject: [PATCH] mmc: sdhci-of-esdhc: disable SD clock for clock value 0
Date: Thu, 21 Sep 2017 13:42:38 +0800
Message-ID: <20170921054238.46666-1-yangbo.lu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2nam01on0068.outbound.protection.outlook.com ([104.47.34.68]:33504
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751641AbdIUGAD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 21 Sep 2017 02:00:03 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, Adrian Hunter <adrian.hunter@intel.com>
Cc: Yangbo Lu <yangbo.lu@nxp.com>

SD clock should be disabled for clock value 0. It's not
right to just return. This may cause failure of signal
voltage switching.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
 drivers/mmc/host/sdhci-of-esdhc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index d96a057a7db8..b21008729aeb 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -36,6 +36,8 @@ struct sdhci_esdhc {
 	unsigned int peripheral_clock;
 };
 
+static void esdhc_clock_enable(struct sdhci_host *host, bool enable);
+
 /**
  * esdhc_read*_fixup - Fixup the value read from incompatible eSDHC register
  *		       to make it compatible with SD spec.
@@ -469,8 +471,10 @@ static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int clock)
 
 	host->mmc->actual_clock = 0;
 
-	if (clock == 0)
+	if (clock == 0) {
+		esdhc_clock_enable(host, false);
 		return;
+	}
 
 	/* Workaround to start pre_div at 2 for VNN < VENDOR_V_23 */
 	if (esdhc->vendor_ver < VENDOR_V_23)
-- 
2.14.1

