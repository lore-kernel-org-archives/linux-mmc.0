From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] dw_mmc: support 8-bit buswidth
Date: Thu, 17 Feb 2011 16:12:38 +0900
Message-ID: <4D5CCA66.9080008@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:45119 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160Ab1BQHWx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Feb 2011 02:22:53 -0500
Received: from epmmp1 (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LGR00CMU2PSIU10@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 17 Feb 2011 16:13:04 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LGR005ZD2PSJM@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 17 Feb 2011 16:13:04 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Will Newton <will.newton@gmail.com>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>

This patch is supported 8-bit buswidth

dw_mmc can also 8-bit buswidth and set to CTYPE_8BIT in card-type register.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 2fcc825..0f6e4a5 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -672,6 +672,9 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	case MMC_BUS_WIDTH_4:
 		slot->ctype = SDMMC_CTYPE_4BIT;
 		break;
+	case MMC_BUS_WIDTH_8:
+		slot->ctype = SDMMC_CTYPE_8BIT;
+		break;
 	}
 
 	if (ios->clock) {
