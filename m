From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] mmc: fixed wrong SD card detection
Date: Fri, 06 May 2011 18:38:48 +0900
Message-ID: <4DC3C1A8.1050104@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:35798 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753766Ab1EFJiq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 6 May 2011 05:38:46 -0400
Received: from epcpsbgm2.samsung.com (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LKR001YKPGIIWO0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 06 May 2011 18:38:44 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LKR00AQ3PGK8C@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 06 May 2011 18:38:44 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>

This patch added mmc_power_off after mmc_attach_sd()

i found that didn't detect the second card insert.(using SDHCI)
you can see the below log.

i want to know that somebody know this issue...

->first card inserted (correct card detect)
# mmc1: new SDHC card at address e624
mmcblk1: mmc1:e624 SU04G 3.69 GiB
 mmcblk1: p1
#
# mmc1: card e624 removed
-> second card inserted
mmc1: error -110 whilst initialising SD card
mmc1: Card removed during transfer!
mmc1: Resetting controller.
-> third card inserted 
mmc1: new SDHC card at address e624
mmcblk1: mmc1:e624 SU04G 3.69 GiB
 mmcblk1: p1

I added mmc_power_off() after only mmc_attach_sd().

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/mmc/core/core.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 1dbc185..d5d8ac0 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1522,8 +1522,10 @@ static int mmc_rescan_try_freq(struct mmc_host *host, unsigned freq)
 	/* Order's important: probe SDIO, then SD, then MMC */
 	if (!mmc_attach_sdio(host))
 		return 0;
-	if (!mmc_attach_sd(host))
+	if (!mmc_attach_sd(host)) {
+		mmc_power_off(host);
 		return 0;
+	}
 	if (!mmc_attach_mmc(host))
 		return 0;
 
