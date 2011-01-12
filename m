From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] sdhci-s3c: add platform_8bit_width()
Date: Wed, 12 Jan 2011 09:30:41 +0900
Message-ID: <4D2CF631.4080402@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:11229 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756304Ab1ALAbM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Jan 2011 19:31:12 -0500
Received: from epmmp2 (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LEV0071BW3ZIW80@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 12 Jan 2011 09:31:11 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LEV008YUW3ZHO@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 12 Jan 2011 09:31:11 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Kyungmin Park <kyungmin.park@samsung.com>, Chris Ball <cjb@laptop.org>, Ben Dooks <ben-linux@fluff.org>

This patch is added platform_8bit_width() function in sdhci-s3c.

We has 8-bit width support but is not a v3 controller.
So we need platform_8bit_width() to support 8-bit buswidth.

Also we need MMC_CAP_8_BIT_DATA, so we added them in platdata.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/mmc/host/sdhci-s3c.c |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 70cc3d7..4dc7d6d 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -276,10 +276,39 @@ static void sdhci_cmu_set_clock(struct sdhci_host *host, unsigned int clock)
 	host->clock = clock;
 }
 
+/*
+ * sdhci_s3c_platform_8bit_width - support 8bit buswidth
+ *
+ * We has 8-bit width support but is not a v3 controller.
+ * So we add  platform_8bit_width() and support 8bit width.
+ **/
+static int sdhci_s3c_platform_8bit_width(struct sdhci_host *host,
+		int bus_width)
+{
+	u8 ctrl;
+
+	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
+
+	if (bus_width == MMC_BUS_WIDTH_8)
+		ctrl |= SDHCI_CTRL_8BITBUS;
+	else
+		ctrl &= ~SDHCI_CTRL_8BITBUS;
+
+	if (bus_width == MMC_BUS_WIDTH_4)
+		ctrl |= SDHCI_CTRL_4BITBUS;
+	else
+		ctrl &= ~SDHCI_CTRL_4BITBUS;
+
+	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
+
+	return 0;
+}
+
 static struct sdhci_ops sdhci_s3c_ops = {
 	.get_max_clock		= sdhci_s3c_get_max_clk,
 	.set_clock		= sdhci_s3c_set_clock,
 	.get_min_clock		= sdhci_s3c_get_min_clock,
+	.platform_8bit_width	= sdhci_s3c_platform_8bit_width,
 };
 
 static void sdhci_s3c_notify_change(struct platform_device *dev, int state)
@@ -472,6 +501,9 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 	if (pdata->cd_type == S3C_SDHCI_CD_PERMANENT)
 		host->mmc->caps = MMC_CAP_NONREMOVABLE;
 
+	if (pdata->host_caps)
+		host->mmc->caps |= pdata->host_caps;
+
 	host->quirks |= (SDHCI_QUIRK_32BIT_DMA_ADDR |
 			 SDHCI_QUIRK_32BIT_DMA_SIZE);
 
-- 
1.6.0.4
