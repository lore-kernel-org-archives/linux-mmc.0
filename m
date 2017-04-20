From: Yangbo Lu <yangbo.lu@nxp.com>
Subject: [PATCH] mmc: sdhci-of-esdhc: limit SD clock for ls1012a/ls1046a
Date: Thu, 20 Apr 2017 14:58:29 +0800
Message-ID: <1492671509-22044-1-git-send-email-yangbo.lu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-co1nam03on0066.outbound.protection.outlook.com ([104.47.40.66]:27732
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S941841AbdDTHNU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 20 Apr 2017 03:13:20 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, Adrian Hunter <adrian.hunter@intel.com>
Cc: Xiaobo Xie <xiaobo.xie@nxp.com>, Yangbo Lu <yangbo.lu@nxp.com>

The ls1046a datasheet specified that the max SD clock frequency
for eSDHC SDR104/HS200 was 167MHz, and the ls1012a datasheet
specified it's 125MHz for ls1012a. So this patch is to add the
limitation.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
 drivers/mmc/host/sdhci-of-esdhc.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 49ac197..57966ef 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -456,6 +456,20 @@ static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int clock)
 	if (esdhc->vendor_ver < VENDOR_V_23)
 		pre_div = 2;
 
+	/*
+	 * Limit SD clock to 167MHz for ls1046a according to its datasheet
+	 */
+	if (clock > 167000000 &&
+	    of_find_compatible_node(NULL, NULL, "fsl,ls1046a-esdhc"))
+		clock = 167000000;
+
+	/*
+	 * Limit SD clock to 125MHz for ls1012a according to its datasheet
+	 */
+	if (clock > 125000000 &&
+	    of_find_compatible_node(NULL, NULL, "fsl,ls1012a-esdhc"))
+		clock = 125000000;
+
 	/* Workaround to reduce the clock frequency for p1010 esdhc */
 	if (of_find_compatible_node(NULL, NULL, "fsl,p1010-esdhc")) {
 		if (clock > 20000000)
-- 
2.1.0.27.g96db324

