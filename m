From: Yangbo Lu <yangbo.lu@freescale.com>
Subject: [PATCH] mmc: sdhci-of-esdhc: add workaround for pre divider initial value
Date: Fri, 7 Aug 2015 10:56:32 +0800
Message-ID: <1438916192-48284-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bl2on0107.outbound.protection.outlook.com ([65.55.169.107]:33046
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751662AbbHGDCC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 6 Aug 2015 23:02:02 -0400
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
index 797be75..46edf2c 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -208,6 +208,12 @@ static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int clock)
 	if (clock == 0)
 		return;
 
+	/* Workaround to start pre_div at 2 for VNN < VENDOR_V_23 */
+	temp = in_be32(host->ioaddr + SDHCI_SLOT_INT_STATUS);
+	temp = (temp & SDHCI_VENDOR_VER_MASK) >> SDHCI_VENDOR_VER_SHIFT;
+	if (temp < VENDOR_V_23)
+		pre_div = 2;
+
 	/* Workaround to reduce the clock frequency for p1010 esdhc */
 	if (of_find_compatible_node(NULL, NULL, "fsl,p1010-esdhc")) {
 		if (clock > 20000000)
-- 
2.1.0.27.g96db324

