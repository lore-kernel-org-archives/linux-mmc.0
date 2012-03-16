From: "Al Cooper" <acooper@gmail.com>
Subject: [PATCH] mmc: Prevent 1.8V switch for SD hosts that don't
 support UHS modes.
Date: Fri, 16 Mar 2012 15:54:17 -0400
Message-ID: <1331927657-2849-1-git-send-email-acooper@gmail.com>
References: <y>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mms3.broadcom.com ([216.31.210.19]:4007 "EHLO MMS3.broadcom.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756977Ab2CPTzs (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 16 Mar 2012 15:55:48 -0400
In-Reply-To: <y>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org
Cc: Al Cooper <acooper@gmail.com>

The driver should not try to switch to 1.8V when the SD 3.0 host
controller does not have any UHS capabilities bits set (SDR50, DDR50
or SDR104). See page 72 of "SD Specifications Part A2 SD Host
Controller Simplified Specification Version 3.00" under
"1.8V Signaling Enable". Instead of setting SDR12 and SDR25 in the host
capabilities data structure for all V3.0 host controllers, only set them
if SDR104, SDR50 or DDR50 is set in the host capabilities register. This
will prevent the switch to 1.8V later.

Signed-off-by: Al Cooper <acooper@gmail.com>
---
 drivers/mmc/host/sdhci.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 8d66706..cdf900e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2762,8 +2762,9 @@ int sdhci_add_host(struct sdhci_host *host)
 	    mmc_card_is_removable(mmc))
 		mmc->caps |= MMC_CAP_NEEDS_POLL;
 
-	/* UHS-I mode(s) supported by the host controller. */
-	if (host->version >= SDHCI_SPEC_300)
+	/* Any UHS-I mode in caps implies SDR12 and SDR25 support. */
+	if (caps[1] & (SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_SDR50 |
+		       SDHCI_SUPPORT_DDR50))
 		mmc->caps |= MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25;
 
 	/* SDR104 supports also implies SDR50 support */
-- 
1.7.6


