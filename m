From: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Subject: [PATCH] mmc: sdhci: fix ctrl_2 on super-speed selection
Date: Thu, 13 Jun 2013 16:41:28 +0200
Message-ID: <1371134488-20219-1-git-send-email-peppe.cavallaro@st.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog107.obsmtp.com ([207.126.144.123]:51506 "EHLO
	eu1sys200aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755225Ab3FMOli (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Jun 2013 10:41:38 -0400
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 26305DE
	for <linux-mmc@vger.kernel.org>; Thu, 13 Jun 2013 14:41:35 +0000 (GMT)
Received: from mail7.sgp.st.com (unknown [164.129.223.81])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2E9E55183
	for <linux-mmc@vger.kernel.org>; Thu, 13 Jun 2013 14:41:16 +0000 (GMT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>

This patch fixes the HC ctrl_2 programming where, in case of
SDR104 and HS200, we have to write 100b in the the UHS Mode
bits. We wrote 101b that is reserved from Arasan Specs.

Reported-by: Youssef Triki <youssef.triki@st.com>
Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
---
 drivers/mmc/host/sdhci.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index b8bb3b3..ae745ab 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1526,16 +1526,15 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 			ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
 			/* Select Bus Speed Mode for host */
 			ctrl_2 &= ~SDHCI_CTRL_UHS_MASK;
-			if (ios->timing == MMC_TIMING_MMC_HS200)
-				ctrl_2 |= SDHCI_CTRL_HS_SDR200;
+			if ((ios->timing == MMC_TIMING_MMC_HS200) ||
+			    (ios->timing == MMC_TIMING_UHS_SDR104))
+				ctrl_2 |= SDHCI_CTRL_UHS_SDR104;
 			else if (ios->timing == MMC_TIMING_UHS_SDR12)
 				ctrl_2 |= SDHCI_CTRL_UHS_SDR12;
 			else if (ios->timing == MMC_TIMING_UHS_SDR25)
 				ctrl_2 |= SDHCI_CTRL_UHS_SDR25;
 			else if (ios->timing == MMC_TIMING_UHS_SDR50)
 				ctrl_2 |= SDHCI_CTRL_UHS_SDR50;
-			else if (ios->timing == MMC_TIMING_UHS_SDR104)
-				ctrl_2 |= SDHCI_CTRL_UHS_SDR104;
 			else if (ios->timing == MMC_TIMING_UHS_DDR50)
 				ctrl_2 |= SDHCI_CTRL_UHS_DDR50;
 			sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
-- 
1.7.4.4

