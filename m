From: Yangbo Lu <yangbo.lu@freescale.com>
Subject: [PATCH v2] mmc: sdhci-of-esdhc: add workaround for pre divider initial value
Date: Tue, 11 Aug 2015 10:53:34 +0800
Message-ID: <1439261614-38605-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2on0139.outbound.protection.outlook.com ([207.46.100.139]:20576
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933433AbbHKC6x (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 10 Aug 2015 22:58:53 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, joakim.tjernlund@transmode.se
Cc: Yangbo Lu <yangbo.lu@freescale.com>

For eSDHC(version < 2.3), the pre divider only could divide base clock
by 2 at least. Add workaround for this to avoid unexpected issue.

Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
---
 drivers/mmc/host/sdhci-of-esdhc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 797be75..653f335 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -208,6 +208,12 @@ static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int clock)
 	if (clock == 0)
 		return;
 
+	/* Workaround to start pre_div at 2 for VNN < VENDOR_V_23 */
+	temp = esdhc_readw(host, SDHCI_HOST_VERSION);
+	temp = (temp & SDHCI_VENDOR_VER_MASK) >> SDHCI_VENDOR_VER_SHIFT;
+	if (temp < VENDOR_V_23)
+		pre_div = 2;
+
 	/* Workaround to reduce the clock frequency for p1010 esdhc */
 	if (of_find_compatible_node(NULL, NULL, "fsl,p1010-esdhc")) {
 		if (clock > 20000000)
-- 
2.1.0.27.g96db324

