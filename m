From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] sdhci-s3c: add platform_8bit_width()
Date: Wed, 12 Jan 2011 11:59:12 +0900
Message-ID: <4D2D1900.1020200@samsung.com>
References: <4D2CF631.4080402@samsung.com>
 <20110112022030.GA27414@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:12173 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932795Ab1ALC7u (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Jan 2011 21:59:50 -0500
Received: from epmmp2 (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LEW004I92ZICB80@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 12 Jan 2011 11:59:42 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LEW00HXW2ZITT@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 12 Jan 2011 11:59:42 +0900 (KST)
In-reply-to: <20110112022030.GA27414@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Ben Dooks <ben-linux@fluff.org>

Hi Chris.

Thanks for your comments.
So i fixed them, and resend the patch.

We have 8-bit width support bu is not a v3 controller.
So we need platform_8bit_width() to support 8-bit buswidth.
Also we need MMC_CAP_8_BIT_DATA, so we add it in platdata.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/sdhci-s3c.c |   34 ++++++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 70cc3d7..8d27bbd 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -276,10 +276,41 @@ static void sdhci_cmu_set_clock(struct sdhci_host *host, unsigned int clock)
 	host->clock = clock;
 }
 
+/*
+ * sdhci_s3c_platform_8bit_width - support 8bit buswidth
+ *
+ * We have 8-bit width support but is not a v3 controller.
+ * So we add platform_8bit_width() and support 8bit width.
+ **/
+static int sdhci_s3c_platform_8bit_width(struct sdhci_host *host, int width)
+{
+	u8 ctrl;
+
+	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
+
+	switch (width) {
+	case MMC_BUS_WIDTH_8:
+		ctrl |= SDHCI_CTRL_8BITBUS;
+		ctrl &= ~SDHCI_CTRL_4BITBUS;
+		break;
+	case MMC_BUS_WIDTH_4:
+		ctrl |= SDHCI_CTRL_4BITBUS;
+		ctrl &= ~SDHCI_CTRL_8BITBUS;
+		break;
+	default:
+		break;
+	}
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
@@ -472,6 +503,9 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 	if (pdata->cd_type == S3C_SDHCI_CD_PERMANENT)
 		host->mmc->caps = MMC_CAP_NONREMOVABLE;
 
+	if (pdata->host_caps)
+		host->mmc->caps |= pdata->host_caps;
+
 	host->quirks |= (SDHCI_QUIRK_32BIT_DMA_ADDR |
 			 SDHCI_QUIRK_32BIT_DMA_SIZE);
 
-- 
1.6.0.4
