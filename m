From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] mmc: sdhci-s3c: add quirk about BROKEN_ADMA_ZEROLEN_DESC
Date: Tue, 12 Jul 2011 17:30:47 +0900
Message-ID: <4E1C0637.2090603@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:16373 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751583Ab1GLIai (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Jul 2011 04:30:38 -0400
Received: from epcpsbgm2.samsung.com (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LO700A2AOYYF5C0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 12 Jul 2011 17:30:36 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LO70077HOZ0QV@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 12 Jul 2011 17:30:36 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Ben Dooks <ben-linux@fluff.org>, Kyungmin Park <kyungmin.park@samsung.com>

This patch is added the quirk for Samsung SoCs.

Samsung SoCs need to set QUIRK_BROKEN_ADMA_ZEROLEN_DESC.
(If ADMA operation is more than 65535, maybe set by zero.)

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/mmc/host/sdhci-s3c.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 460ffaf..03da44a 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -502,6 +502,9 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 	/* This host supports the Auto CMD12 */
 	host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
 
+	/* Samsung SoCs need BROKEN_ADMA_ZEROLEN_DESC */
+	host->quirks |= SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC;
+
 	if (pdata->cd_type == S3C_SDHCI_CD_NONE ||
 	    pdata->cd_type == S3C_SDHCI_CD_PERMANENT)
 		host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
