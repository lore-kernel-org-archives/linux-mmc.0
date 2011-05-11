From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] sdhci-s3c: fixed compiler error for renamed register
Date: Wed, 11 May 2011 16:31:32 +0900
Message-ID: <4DCA3B54.3000607@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:59796 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752947Ab1EKPll (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 May 2011 11:41:41 -0400
Received: from epcpsbgm1.samsung.com (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LL0009SUSVIQR90@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 11 May 2011 16:31:25 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LL0002PQSWD6Q@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 11 May 2011 16:31:25 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Ben Dooks <ben-linux@fluff.org>, Kyungmin Park <kyungmin.park@samsung.com>

In Arindam Nath's patch "mmc:sd: add support for driver type selection"
included renamed SDHCI_HOST_CONTROL1.

In sdhci-s3c, we used SDHCI_HOST_CONTROL in sdhci_s3c_platform_8bit_width().
Also we need to use the renamed register in sdhci-s3c.c

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/mmc/host/sdhci-s3c.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 69e3ee3..15a6195 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -289,7 +289,7 @@ static int sdhci_s3c_platform_8bit_width(struct sdhci_host *host, int width)
 {
 	u8 ctrl;
 
-	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
+	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL1);
 
 	switch (width) {
 	case MMC_BUS_WIDTH_8:
@@ -304,7 +304,7 @@ static int sdhci_s3c_platform_8bit_width(struct sdhci_host *host, int width)
 		break;
 	}
 
-	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
+	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL1);
 
 	return 0;
 }
