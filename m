From: Kyungmin Park <kmpark@infradead.org>
Subject: [PATCH] mmc: sdhci-s3c: Auto CMD12 support
Date: Sat, 30 Oct 2010 12:58:56 +0900
Message-ID: <20101030035856.GA13041@july>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:19440 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751069Ab0J3D7E (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Oct 2010 23:59:04 -0400
Received: from epmmp2 (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Sun Java(tm) System Messaging Server 7u3-15.01 64bit (built Feb 12 2010))
 with ESMTP id <0LB3006U84EEG960@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Sat, 30 Oct 2010 12:59:02 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LB30048V4EF9W@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Sat, 30 Oct 2010 12:59:03 +0900 (KST)
Content-disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, akpm@linux-foundation.org
Cc: jh80.chung@samsung.com, Ben Dooks <ben-linux@fluff.org>, Chris Ball <cjb@laptop.org>

From: Kyungmin Park <kyungmin.park@samsung.com>

Samsung SDHCI host controller supports the Auto CMD12.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index aacb862..e2d79e7 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -414,6 +414,9 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 	 * SDHCI block, or a missing configuration that needs to be set. */
 	host->quirks |= SDHCI_QUIRK_NO_BUSY_IRQ;
 
+	/* This host supports the Auto CMD12 */
+	host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
+
 	if (pdata->cd_type == S3C_SDHCI_CD_NONE ||
 	    pdata->cd_type == S3C_SDHCI_CD_PERMANENT)
 		host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
