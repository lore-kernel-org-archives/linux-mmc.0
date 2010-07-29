From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 2/4] sdhci-s3c: enable SDHCI_QUIRK_NO_HISPD_BIT quirk
Date: Thu, 29 Jul 2010 14:34:33 +0200
Message-ID: <1280406875-31830-3-git-send-email-m.szyprowski@samsung.com>
References: <1280406875-31830-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:56830 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757383Ab0G2Mer (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Jul 2010 08:34:47 -0400
In-reply-to: <1280406875-31830-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: m.szyprowski@samsung.com, kyungmin.park@samsung.com, kgene.kim@samsung.com, ben-linux@fluff.org, akpm@linux-foundation.org, broonie@opensource.wolfsonmicro.com

This patch enables SDHCI_QUIRK_NO_HISPD_BIT on Samsung SDHCI driver.
This solves detection problems with some external SD cards. This change
has been tested on S5PC100 and S5PC110. It has no inpact on driver
speed.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/mmc/host/sdhci-s3c.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 47138af..f0b819d 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -338,6 +338,7 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 
 	/* Setup quirks for the controller */
 	host->quirks |= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC;
+	host->quirks |= SDHCI_QUIRK_NO_HISPD_BIT;
 
 #ifndef CONFIG_MMC_SDHCI_S3C_DMA
 
-- 
1.7.1.569.g6f426

