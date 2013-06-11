From: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Subject: [PATCH] mmc: sdhci: fix caps2 for HS200
Date: Tue, 11 Jun 2013 16:09:20 +0200
Message-ID: <1370959760-27215-1-git-send-email-peppe.cavallaro@st.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog114.obsmtp.com ([207.126.144.137]:55669 "EHLO
	eu1sys200aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751322Ab3FKOJp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Jun 2013 10:09:45 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, Giuseppe Cavallaro <peppe.cavallaro@st.com>

Although the HC supports HS200 (eMMC) the caps2 are always zero; this means that
no way to use the super speed mode (when init the card).

If the HC support SDR104, for SD3.0, so it also supports HS200 for eMMC and
this patch just sets the MMC_CAP2_HS200 in the host caps2 field.

Reported-by: Youssef Triki <youssef.triki@st.com>
Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
---
 drivers/mmc/host/sdhci.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 2ea429c..5626f5f 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2962,9 +2962,13 @@ int sdhci_add_host(struct sdhci_host *host)
 		mmc->caps |= MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25;
 
 	/* SDR104 supports also implies SDR50 support */
-	if (caps[1] & SDHCI_SUPPORT_SDR104)
+	if (caps[1] & SDHCI_SUPPORT_SDR104) {
 		mmc->caps |= MMC_CAP_UHS_SDR104 | MMC_CAP_UHS_SDR50;
-	else if (caps[1] & SDHCI_SUPPORT_SDR50)
+		/* SD3.0: SDR104 is supported so from eMMC caps2
+		 * can be promoted to support HS200.
+		 */
+		mmc->caps2 |= MMC_CAP2_HS200;
+	} else if (caps[1] & SDHCI_SUPPORT_SDR50)
 		mmc->caps |= MMC_CAP_UHS_SDR50;
 
 	if (caps[1] & SDHCI_SUPPORT_DDR50)
-- 
1.7.4.4

