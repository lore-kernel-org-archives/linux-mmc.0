From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH] sdhci: highspeed:  check for mmc as well as sd cards
Date: Wed, 6 Oct 2010 11:57:23 -0700
Message-ID: <41A82D88-6200-469C-986D-EF46B0C6A773@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:50563 "HELO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S933029Ab0JFS64 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 6 Oct 2010 14:58:56 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


when examining the code in the mmc directory the SD and MMC code
set highspeed using a different constant.  Change the sd driver
to recognize this and switch to high speed.

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 drivers/mmc/host/sdhci.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index d3f924b..1d3f4d8 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1194,8 +1194,9 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	else
 		ctrl &= ~SDHCI_CTRL_4BITBUS;
 
-	if (ios->timing == MMC_TIMING_SD_HS &&
-	    !(host->quirks & SDHCI_QUIRK_NO_HISPD_BIT))
+	if ((ios->timing == MMC_TIMING_SD_HS
+			|| ios->timing == MMC_TIMING_MMC_HS)
+		&& !(host->quirks & SDHCI_QUIRK_NO_HISPD_BIT))
 		ctrl |= SDHCI_CTRL_HISPD;
 	else
 		ctrl &= ~SDHCI_CTRL_HISPD;
-- 
1.6.0.4

